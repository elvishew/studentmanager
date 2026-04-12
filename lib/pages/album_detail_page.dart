import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../providers/album_provider.dart';
import '../providers/states.dart';
import '../database/album_repository.dart';

/// 相册详情页
class AlbumDetailPage extends ConsumerStatefulWidget {
  final int albumId;
  final String albumName;
  final String? albumNotes;

  const AlbumDetailPage({
    super.key,
    required this.albumId,
    required this.albumName,
    this.albumNotes,
  });

  @override
  ConsumerState<AlbumDetailPage> createState() => _AlbumDetailPageState();
}

class _AlbumDetailPageState extends ConsumerState<AlbumDetailPage> {
  List<AlbumPhoto> _photos = [];
  bool _isLoading = true;
  late String _albumName;

  @override
  void initState() {
    super.initState();
    _albumName = widget.albumName;
    _loadPhotos();
  }

  Future<void> _loadPhotos() async {
    setState(() {
      _isLoading = true;
    });
    final notifier = ref.read(albumNotifierProvider.notifier);
    final photos = await notifier.getPhotos(widget.albumId);
    if (mounted) {
      setState(() {
        _photos = photos;
        _isLoading = false;
      });
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    Navigator.pop(context); // 关闭 BottomSheet

    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: source,
      imageQuality: 80,
    );

    if (image == null) return;

    try {
      // 复制到 App 沙盒
      final albumDir = await AlbumRepository.getAlbumDirectory();
      final fileName = AlbumRepository.generatePhotoFileName();
      final savedPath = '$albumDir/$fileName';

      await File(image.path).copy(savedPath);

      // 存入数据库
      final notifier = ref.read(albumNotifierProvider.notifier);
      await notifier.addPhoto(
        albumId: widget.albumId,
        filePath: savedPath,
      );

      await _loadPhotos();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('添加照片失败：$e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _showDeletePhotoDialog(AlbumPhoto photo) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.warning, color: Colors.red, size: 48),
        title: const Text('删除照片'),
        content: const Text('确定要删除这张照片吗？此操作不可恢复。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('确认删除'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    final notifier = ref.read(albumNotifierProvider.notifier);
    final success = await notifier.deletePhoto(photo.id);

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('照片已删除')),
      );
      await _loadPhotos();
    }
  }

  void _showPhotoFullscreen(String filePath) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => _PhotoViewer(filePath: filePath),
      ),
    );
  }

  Future<void> _showEditAlbumDialog() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => _EditAlbumDialog(
        initialName: _albumName,
        initialNotes: widget.albumNotes,
      ),
    );

    if (result != null && mounted) {
      final notifier = ref.read(albumNotifierProvider.notifier);
      final success = await notifier.update(
        id: widget.albumId,
        name: result['name'] as String,
        notes: result['notes'] as String?,
      );
      if (success && mounted) {
        setState(() {
          _albumName = result['name'] as String;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('相册已更新')),
        );
      }
    }
  }

  void _showPickOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('拍照'),
              onTap: () => _pickImage(ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('从相册选取'),
              onTap: () => _pickImage(ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _deleteAlbum() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.warning, color: Colors.red, size: 48),
        title: const Text('删除相册'),
        content: Text(
          '确定要删除相册「$_albumName」吗？\n\n'
          '删除后将同时删除所有照片，此操作不可恢复。',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('确认删除'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    final notifier = ref.read(albumNotifierProvider.notifier);
    final success = await notifier.delete(widget.albumId);

    if (success && mounted) {
      Navigator.pop(context, true);
    }
  }

  Widget _buildNotesBar(String notes) {
    return InkWell(
      onTap: () => _showNotesDialog(notes),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.5),
        child: Row(
          children: [
            Icon(
              Icons.notes,
              size: 16,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                notes,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: 16,
              color: Theme.of(context).colorScheme.outline,
            ),
          ],
        ),
      ),
    );
  }

  void _showNotesDialog(String notes) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('相册备注'),
        content: Text(notes),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_albumName),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: _showEditAlbumDialog,
            tooltip: '编辑相册',
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            color: Colors.red,
            onPressed: _deleteAlbum,
            tooltip: '删除相册',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // 备注信息条（有备注时显示）
                if (widget.albumNotes != null && widget.albumNotes!.isNotEmpty)
                  _buildNotesBar(widget.albumNotes!),
                // 照片区域
                Expanded(
                  child: _photos.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.photo_camera_back,
                                size: 64,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                '暂无照片',
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Theme.of(context).colorScheme.outline,
                                    ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '点击右下角按钮添加照片',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Theme.of(context).colorScheme.outline,
                                    ),
                              ),
                            ],
                          ),
                        )
                      : GridView.builder(
                          padding: const EdgeInsets.all(8),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4,
                          ),
                          itemCount: _photos.length,
                          itemBuilder: (context, index) {
                            final photo = _photos[index];
                            return GestureDetector(
                              onTap: () => _showPhotoFullscreen(photo.filePath),
                              onLongPress: () => _showDeletePhotoDialog(photo),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: _buildPhotoThumbnail(photo.filePath),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showPickOptions,
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }

  Widget _buildPhotoThumbnail(String filePath) {
    return Image.file(
      File(filePath),
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.grey[300],
          child: const Icon(Icons.broken_image, color: Colors.grey),
        );
      },
    );
  }
}

/// 编辑相册对话框
class _EditAlbumDialog extends StatefulWidget {
  final String initialName;
  final String? initialNotes;

  const _EditAlbumDialog({
    required this.initialName,
    this.initialNotes,
  });

  @override
  State<_EditAlbumDialog> createState() => _EditAlbumDialogState();
}

class _EditAlbumDialogState extends State<_EditAlbumDialog> {
  late final TextEditingController _nameController;
  late final TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _notesController = TextEditingController(text: widget.initialNotes ?? '');
    _nameController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('编辑相册'),
      content: SizedBox(
        width: 350,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: '相册名称',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _notesController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: '备注',
                hintText: '选填',
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('取消'),
        ),
        ElevatedButton(
          onPressed: _nameController.text.trim().isEmpty
              ? null
              : () => Navigator.pop(context, {
                  'name': _nameController.text.trim(),
                  'notes': _notesController.text.trim().isEmpty
                      ? null
                      : _notesController.text.trim(),
                }),
          child: const Text('保存'),
        ),
      ],
    );
  }
}

/// 全屏照片查看
class _PhotoViewer extends StatelessWidget {
  final String filePath;

  const _PhotoViewer({required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: InteractiveViewer(
          child: Image.file(
            File(filePath),
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Text(
                  '无法加载图片',
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
