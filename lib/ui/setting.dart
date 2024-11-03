import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

import '../bloc/app_setting_bloc.dart';
import '../impl/setting.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  _SettingPage createState() => _SettingPage();
}


class _SettingPage extends  State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AppSettingBloc>();
    var themeData = Theme.of(context);
    final settingImpl = Provider.of<SettingImpl>(context);
    List<Widget> list = [];

    list.add(SliverToBoxAdapter(
      child: Container(
        height: 30,
      ),
    ));

    List<AbstractSettingsTile> interfaceTiles = [
      SettingsTile.navigation(
        trailing: Text("English"),
        leading: const Icon(Icons.language),
        title: Text("English"),
        onPressed: (context) {
          pickI18N();
        },
      ),
      SettingsTile.navigation(
        trailing: Text("Theme"),
        leading: const Icon(Icons.dark_mode),
        title: Text("Theme"),
        onPressed: (context) {
          pickThemeStyle();
        },
      ),
    ];

    List<AbstractSettingsTile> network = [
      SettingsTile.navigation(
        trailing: Text("English"),
        leading: const Icon(Icons.language),
        title: Text("English"),
        onPressed: (context) {
          pickI18N();
        },
      ),
      SettingsTile.navigation(
        trailing: Text("Theme"),
        leading: const Icon(Icons.dark_mode),
        title: Text("Theme"),
        onPressed: (context) {
          pickThemeStyle();
        },
      ),
    ];

    List<SettingsSection> sections = [];
    sections
        .add(SettingsSection(title: Text('Interface'), tiles: interfaceTiles));
    sections.add(SettingsSection(title: Text('network'), tiles: network));

    SettingsList settingsList = SettingsList(
        applicationType: ApplicationType.cupertino,
        // contentPadding: const EdgeInsets.only(top: Base.BASE_PADDING),
        platform: DevicePlatform.iOS,
        sections: sections);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Setting')),
      child: SafeArea(bottom: false, child: settingsList),
    );
  }

  Future pickI18N() async {}

  Future pickThemeStyle() async {}
}
