import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../generated/data.pb.dart';
import '../generated/error.pbenum.dart';
import '../impl/grpc_client.dart';
import '../impl/logger.dart';
import '../impl/setting_impl.dart';

class StoreRepoConfigPage extends StatefulWidget {
  const StoreRepoConfigPage({super.key});

  @override
  State<StoreRepoConfigPage> createState() => _StoreRepoConfigPageState();
}

class _StoreRepoConfigPageState extends State<StoreRepoConfigPage> {
  bool _isLoading = true;
  String _currentPath = '';
  Dir? _dir;
  String? _error;
  final TextEditingController _pathController = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    _loadDirectory(_currentPath);
  }

  @override
  void dispose() {
    _pathController.dispose();
    super.dispose();
  }

  String _getParentPath(String path) {
    if (path.isEmpty || path == '/') return '';
    final lastSlash = path.lastIndexOf('/');
    if (lastSlash <= 0) return '';
    return path.substring(0, lastSlash);
  }

  String _normalizePath(String path) {
    if (path.isEmpty) return '/';
    return path.endsWith('/') ? path.substring(0, path.length - 1) : path;
  }

  Future<void> _loadDirectory(String path) async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response =
          await GrpcClient.instance.listServerDir(_normalizePath(path));

      if (response.errCode == ErrCode.Success) {
        setState(() {
          _dir = response.dir;
          _currentPath = path;
          _pathController.text = _normalizePath(path);
          _isLoading = false;
        });
      } else {
        setState(() {
          _error = 'Failed to load directory: ${response.errCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      Logger.error('Error loading directory', e);
      setState(() {
        _error = 'Error loading directory: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Repository Location'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _loadDirectory(_currentPath),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildBody(),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _pathController,
              decoration: const InputDecoration(
                labelText: 'Selected Path',
                border: OutlineInputBorder(),
              ),
              readOnly: true,
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            onPressed: () async {
              try {
                final response =
                    await GrpcClient.instance.createRepo(_pathController.text);
                if (response.errCode == ErrCode.Success) {
                  if (mounted) {
                    if (response.repo.hasRepoUuid()) {
                      await SettingImpl.instance
                          .addServerRepoUuid(response.repo.repoUuid);
                      if (mounted) {
                        if (!mounted) return;
                        context.go('/home');
                      }
                    }
                  }
                } else {
                  if (mounted) {
                    await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Repository Creation Failed'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Failed to create repository: ${response.errCode}'),
                            const SizedBox(height: 8),
                            const Text(
                                'Please check your network connection and try again.'),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                }
              } catch (e) {
                if (mounted) {
                  await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Network Error'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Failed to connect to server: $e'),
                          const SizedBox(height: 8),
                          const Text(
                              'Please check your network connection and try again.'),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              }
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _loadDirectory(_currentPath),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_dir == null || _dir!.files.isEmpty) {
      return const Center(
        child: Text('No directories available'),
      );
    }

    final entries = _dir!.files.entries
        .toList()
        .where((entry) => entry.value.fileType == FileType.Direcotry)
        .toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              if (_currentPath.isNotEmpty)
                ListTile(
                  leading: const Icon(Icons.folder, color: Colors.blue),
                  title: const Text('..'),
                  onTap: () {
                    final parentPath = _getParentPath(_currentPath);
                    _loadDirectory(parentPath);
                  },
                ),
              ...entries.map((entry) {
                return ListTile(
                  leading: const Icon(Icons.folder, color: Colors.blue),
                  title: Text(entry.key),
                  onTap: () {
                    final newPath = _currentPath.isEmpty
                        ? '/${entry.key}'
                        : '$_currentPath/${entry.key}';
                    _loadDirectory(newPath);
                  },
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}
