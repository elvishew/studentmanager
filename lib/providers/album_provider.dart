import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'states.dart';
import 'student_provider.dart';
import '../database/album_repository.dart';

part 'album_provider.g.dart';

/// ============================================
/// AlbumRepository Provider
/// ============================================

@riverpod
AlbumRepository albumRepository(AlbumRepositoryRef ref) {
  final database = ref.watch(databaseProvider);
  return AlbumRepository(database: database);
}

/// ============================================
/// Album Notifier
/// ============================================

@riverpod
class AlbumNotifier extends _$AlbumNotifier {
  late final Database _database;
  late final AlbumRepository _repository;

  @override
  AlbumState build() {
    _database = ref.watch(databaseProvider);
    _repository = ref.watch(albumRepositoryProvider);
    return const AlbumState.initial();
  }

  /// ============================================
  /// 查询学员的所有相册
  /// ============================================

  Future<void> fetchByStudentId(int studentId) async {
    state = AlbumState.loading();

    try {
      final albums = await _repository.getAlbumsByStudentId(studentId);
      state = AlbumState.data(
        albums: albums,
        selectedStudentId: studentId,
      );
    } catch (e, stackTrace) {
      state = AlbumState.error(e, stackTrace);
    }
  }

  /// ============================================
  /// 创建相册
  /// ============================================

  Future<int?> create({
    required int studentId,
    required String name,
    String? notes,
  }) async {
    try {
      final id = await _repository.createAlbum(
        studentId: studentId,
        name: name,
        notes: notes,
      );

      await fetchByStudentId(studentId);
      return id;
    } catch (e, stackTrace) {
      state = AlbumState.error(e, stackTrace);
      return null;
    }
  }

  /// ============================================
  /// 更新相册
  /// ============================================

  Future<bool> update({
    required int id,
    required String name,
    String? notes,
  }) async {
    try {
      final success = await _repository.updateAlbum(
        id: id,
        name: name,
        notes: notes,
      );

      if (success) {
        state.when(
          initial: () => state = const AlbumState.initial(),
          loading: () => state = const AlbumState.loading(),
          error: (error, stackTrace) => state = AlbumState.error(error, stackTrace),
          data: (albums, selectedStudentId) {
            final updatedAlbums = albums.map((album) {
              if (album.id == id) {
                return album.copyWith(
                  name: name,
                  notes: notes,
                  updatedAt: DateTime.now(),
                );
              }
              return album;
            }).toList();

            state = AlbumState.data(
              albums: updatedAlbums,
              selectedStudentId: selectedStudentId,
            );
          },
        );
      }

      return success;
    } catch (e, stackTrace) {
      state = AlbumState.error(e, stackTrace);
      return false;
    }
  }

  /// ============================================
  /// 删除相册
  /// ============================================

  Future<bool> delete(int id) async {
    try {
      final success = await _repository.deleteAlbum(id);

      if (success) {
        state.when(
          initial: () => state = const AlbumState.initial(),
          loading: () => state = const AlbumState.loading(),
          error: (error, stackTrace) => state = AlbumState.error(error, stackTrace),
          data: (albums, selectedStudentId) {
            final updatedAlbums = albums.where((a) => a.id != id).toList();
            state = AlbumState.data(
              albums: updatedAlbums,
              selectedStudentId: selectedStudentId,
            );
          },
        );
      }

      return success;
    } catch (e, stackTrace) {
      state = AlbumState.error(e, stackTrace);
      return false;
    }
  }

  /// ============================================
  /// 添加照片
  /// ============================================

  Future<int?> addPhoto({
    required int albumId,
    required String filePath,
  }) async {
    try {
      final id = await _repository.addPhoto(
        albumId: albumId,
        filePath: filePath,
      );
      return id;
    } catch (e, stackTrace) {
      state = AlbumState.error(e, stackTrace);
      return null;
    }
  }

  /// ============================================
  /// 删除照片
  /// ============================================

  Future<bool> deletePhoto(int id) async {
    try {
      return await _repository.deletePhoto(id);
    } catch (e, stackTrace) {
      state = AlbumState.error(e, stackTrace);
      return false;
    }
  }

  /// ============================================
  /// 获取相册照片列表
  /// ============================================

  Future<List<AlbumPhoto>> getPhotos(int albumId) async {
    return await _repository.getPhotosByAlbumId(albumId);
  }

  /// ============================================
  /// 重置状态
  /// ============================================

  void reset() {
    state = const AlbumState.initial();
  }
}
