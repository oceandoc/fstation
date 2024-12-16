import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../generated/l10n.dart';
import '../impl/setting_impl.dart';

class BackupConfigPage extends StatefulWidget {
  const BackupConfigPage({super.key});

  @override
  State<BackupConfigPage> createState() => _BackupConfigPageState();
}

class _BackupConfigPageState extends State<BackupConfigPage> {
  bool _autoBackup = false;
  bool _backgroundBackup = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text(Localization.current.backup_settings),
      ),
      body: ListView(
        children: [
          Card(
            margin: const EdgeInsets.all(16),
            child: Column(
              children: [
                SwitchListTile(
                  title: Text(Localization.current.auto_backup),
                  subtitle: Text(Localization.current.auto_backup_desc),
                  value: _autoBackup,
                  onChanged: (value) {
                    setState(() {
                      _autoBackup = value;
                    });
                  },
                ),
                SwitchListTile(
                  title: Text(Localization.current.background_backup),
                  subtitle: Text(Localization.current.background_backup_desc),
                  value: _backgroundBackup,
                  onChanged: _autoBackup
                      ? (value) {
                          setState(() {
                            _backgroundBackup = value;
                          });
                        }
                      : null,
                ),
                const Divider(),
                ListTile(
                  title: Text(Localization.current.choose_backup_albums),
                  subtitle: Text(
                    SettingImpl.instance.selectedAlbums.isEmpty
                        ? Localization.current.no_albums_selected
                        : '${SettingImpl.instance.selectedAlbums.length} ${Localization.current.albums_selected}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/select_albums'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
