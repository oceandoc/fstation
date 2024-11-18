import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:settings_ui/settings_ui.dart';

import '../bloc/app_setting_bloc.dart';
import '../generated/l10n.dart';
import '../impl/setting_impl.dart';
import '../util/util.dart';
import 'widget/custom_widgets.dart';
import 'widget/dialog/blur_dialog.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  SettingPageState createState() => SettingPageState();
}

class SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    final interfaceTiles = <AbstractSettingsTile>[
      SettingsTile.navigation(
        trailing: Text(Localization.current.language),
        leading: const Icon(Icons.language),
        title: Text(Localization.current.language),
        onPressed: (context) {
          pickI18N(context);
        },
      ),
      SettingsTile.navigation(
        trailing: Text(Localization.current.theme_setting_theme_title),
        leading: const Icon(Icons.dark_mode),
        title: const Text('Theme'),
        onPressed: (context) {
          pickThemeStyle();
        },
      ),
    ];

    final network = <AbstractSettingsTile>[
      SettingsTile.navigation(
        trailing: const Text('English'),
        leading: const Icon(Icons.language),
        title: const Text('English'),
        onPressed: (context) {
          pickI18N(context);
        },
      ),
      SettingsTile.navigation(
        trailing: const Text('Theme'),
        leading: const Icon(Icons.dark_mode),
        title: const Text('Theme'),
        onPressed: (context) {
          pickThemeStyle();
        },
      ),
    ];

    final sections = <SettingsSection>[
      SettingsSection(title: const Text('Interface'), tiles: interfaceTiles),
      SettingsSection(title: const Text('network'), tiles: network)
    ];

    final settingsList = SettingsList(
        applicationType: ApplicationType.cupertino,
        platform: DevicePlatform.iOS,
        sections: sections);

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Setting')),
      child: SafeArea(bottom: false, child: settingsList),
    );
  }

  Future pickI18N(BuildContext context) async {
    final settingImpl = SettingImpl.instance;
    return showCupertinoDialog(
      context: context,
      builder: (context) => BlurryDialog(
        title: Localization.current.language,
        normalTitleStyle: true,
        actions: [
          CupertinoDialogAction(
            child: const Text('Close'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ...Localization.delegate.supportedLocales.map(
                  (e) => Padding(
                    key: Key(e.languageCode),
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: ListTileWithCheckMark(
                      leading: Container(
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1.5,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withAlpha(100),
                          ),
                        ),
                        child: Text(
                          e.languageCode[0],
                          style: const TextStyle(fontSize: 13.0),
                        ),
                      ),
                      titleWidget: Text.rich(
                        TextSpan(
                          text: getLocaleName(e),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      active: e.languageCode == settingImpl.language,
                      onTap: () async {
                        await settingImpl.saveLanguage(e.languageCode);
                        context
                            .read<AppSettingBloc>()
                            .add(ChangeLanguageEvent(e.languageCode));
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future pickThemeStyle() async {}
}
