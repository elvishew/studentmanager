import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

import '../providers/states.dart';

class AlbumRepository {
  final Database database;

  AlbumRepository({required this.database});

  /// ============================================
  /// 获取相册存储目录
  /// ============================================

  static Future<String> getAlbumDirectory() async {
    final appDir = await getApplicationDocumentsDirectory();
    final albumDir = Directory(p.join(appDir.path, 'albums'));
    if (!await albumDir.exists()) {
      await albumDir.create(recursive: true);
    }
    return albumDir.path;
  }

  /// ============================================
  /// 生成照片文件名
  /// ============================================

  static String generatePhotoFileName() {
    final now = DateTime.now();
    return '${now.millisecondsSinceEpoch}_${now.microsecond}.jpg';
  }

  /// ============================================
  /// 查询学员的所有相册（含照片数量）
  /// ============================================

  Future<List<Album>> getAlbumsByStudentId(int studentId) async {
    final List<Map<String, dynamic>> maps = await database.rawQuery('''
      SELECT a.*, COUNT(ap.id) as photo_count
      FROM albums a
      LEFT JOIN album_photos ap ON a.id = ap.album_id
      WHERE a.student_id = ?
      GROUP BY a.id
      ORDER BY a.created_at DESC
    ''', [studentId]);

    return maps.map((map) => Album.fromMap(map)).toList();
  }

  /// ============================================
  /// 创建相册
  /// ============================================

  Future<int> createAlbum({
    required int studentId,
    required String name,
    String? notes,
  }) async {
    final now = DateTime.now().toIso8601String();
    return await database.insert('albums', {
      'student_id': studentId,
      'name': name,
      'notes': notes,
      'created_at': now,
      'updated_at': now,
    });
  }

  /// ============================================
  /// 更新相册
  /// ============================================

  Future<bool> updateAlbum({
    required int id,
    required String name,
    String? notes,
  }) async {
    final count = await database.update(
      'albums',
      {
        'name': name,
        'notes': notes,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
    return count > 0;
  }

  /// ============================================
  /// 删除相册（同时删除所有照片文件）
  /// ============================================

  Future<bool> deleteAlbum(int id) async {
    // 先查询所有照片路径
    final photos = await getPhotosByAlbumId(id);

    // 删除照片文件
    for (final photo in photos) {
      try {
        final file = File(photo.filePath);
        if (await file.exists()) {
          await file.delete();
        }
      } catch (_) {
        // 文件删除失败不影响数据库删除
      }
    }

    // 删除数据库记录（CASCADE 会自动删除 album_photos）
    final count = await database.delete(
      'albums',
      where: 'id = ?',
      whereArgs: [id],
    );
    return count > 0;
  }

  /// ============================================
  /// 查询相册的照片列表
  /// ============================================

  Future<List<AlbumPhoto>> getPhotosByAlbumId(int albumId) async {
    final List<Map<String, dynamic>> maps = await database.query(
      'album_photos',
      where: 'album_id = ?',
      whereArgs: [albumId],
      orderBy: 'created_at DESC',
    );
    return maps.map((map) => AlbumPhoto.fromMap(map)).toList();
  }

  /// ============================================
  /// 添加照片
  /// ============================================

  Future<int> addPhoto({
    required int albumId,
    required String filePath,
  }) async {
    final now = DateTime.now().toIso8601String();
    return await database.insert('album_photos', {
      'album_id': albumId,
      'file_path': filePath,
      'created_at': now,
      'updated_at': now,
    });
  }

  /// ============================================
  /// 删除照片（同时删除文件）
  /// ============================================

  Future<bool> deletePhoto(int id) async {
    // 先查询照片路径
    final List<Map<String, dynamic>> maps = await database.query(
      'album_photos',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      final filePath = maps.first['file_path'] as String;
      try {
        final file = File(filePath);
        if (await file.exists()) {
          await file.delete();
        }
      } catch (_) {
        // 文件删除失败不影响数据库删除
      }
    }

    final count = await database.delete(
      'album_photos',
      where: 'id = ?',
      whereArgs: [id],
    );
    return count > 0;
  }

  /// ============================================
  /// 清理学员的所有相册照片文件
  /// ============================================

  Future<void> cleanupByStudentId(int studentId) async {
    // 查询该学员所有相册
    final albums = await getAlbumsByStudentId(studentId);
    for (final album in albums) {
      // 先删除所有照片文件
      final photos = await getPhotosByAlbumId(album.id);
      for (final photo in photos) {
        try {
          final file = File(photo.filePath);
          if (await file.exists()) {
            await file.delete();
          }
        } catch (_) {}
      }
    }
  }
}
