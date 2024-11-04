import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

import '../bloc/app_setting_bloc.dart';
import '../generated/l10n.dart';
import '../impl/setting.dart';
import '../util/custom_widgets.dart';
import '../util/enums.dart';
import '../util/extensions.dart';
import '../util/language.dart';
import '../util/settings_search_controller.dart';
import '../util/util.dart';

enum _ThemeSettingsKeys {
  themeMode,
  autoColoring,
  wallpaperColors,
  pitchBlack,
  defaultColor,
  defaultColorDark,
  language,
}

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  SettingPageState createState() => SettingPageState();
}

class SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AppSettingBloc>();
    var themeData = Theme.of(context);
    final settingImpl = Provider.of<SettingImpl>(context);

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
        title: Text("Theme"),
        onPressed: (context) {
          pickThemeStyle();
        },
      ),
    ];

    List<AbstractSettingsTile> network = [
      SettingsTile.navigation(
        trailing: const Text("English"),
        leading: const Icon(Icons.language),
        title: const Text('English'),
        onPressed: (context) {
          pickI18N(context);
        },
      ),
      SettingsTile.navigation(
        trailing: Text("Theme"),
        leading: const Icon(Icons.dark_mode),
        title: const Text("Theme"),
        onPressed: (context) {
          pickThemeStyle();
        },
      ),
    ];

    List<SettingsSection> sections = [SettingsSection(title: const Text('Interface'), tiles: interfaceTiles), SettingsSection(title: Text('network'), tiles: network)];

    final settingsList = SettingsList(
        applicationType: ApplicationType.cupertino,
        platform: DevicePlatform.iOS,
        sections: sections);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Setting')),
      child: SafeArea(bottom: false, child: settingsList),
    );
  }


  Future pickI18N(BuildContext context) async {
    final settingImpl = Provider.of<SettingImpl>(context);
   return CustomBlurryDialog(
        title: Localization.current.language,
        normalTitleStyle: true,
        actions: [],
        child: SizedBox(
          height: nampack.height * 0.5,
          width: nampack.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ...Language.supportLanguages.map(
                  (e) => Padding(
                    key: Key(e.code),
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: ListTileWithCheckMark(
                        leading: Container(
                          padding: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 1.5,
                              color: context.theme.colorScheme.onSurface
                                  .withAlpha(100),
                            ),
                          ),
                          child: Text(
                            e.name[0],
                            style: const TextStyle(fontSize: 13.0),
                          ),
                        ),
                        titleWidget: Text.rich(
                          TextSpan(
                            text: e.name,
                            style: context.textTheme.displayMedium,
                            children: [
                              TextSpan(
                                text: ' (${e.country})',
                                style: context.textTheme.displaySmall,
                              ),
                            ],
                          ),
                        ),
                        active: e == Language.getLanguage(settingImpl.language),
                        onTap: () => settingImpl.language = e.code,
                      ),

                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }

  late final Enum? initialItem;

  SettingSubpageEnum get settingPage => SettingSubpageEnum.theme;

  GlobalKey getSettingWidgetGlobalKey(Enum key) {
    return SettingsSearchController.inst
        .getSettingWidgetGlobalKey(settingPage, key);
  }

  Color? getBgColor(Enum key) {
    return key == initialItem ? Colors.grey.withAlpha(80) : null;
  }

  Widget getItemWrapper({required Enum key, required Widget child}) {
    return Stack(
      key: getSettingWidgetGlobalKey(key),
      children: [
        child,
        if (key == initialItem)
          () {
            bool finished = false;
            return Positioned.fill(
              child: IgnorePointer(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.0.multipliedRadius),
                    color: Colors.grey.withAlpha(100),
                  ),
                ).animate(
                  autoPlay: true,
                  onComplete: (controller) async {
                    if (!finished) {
                      finished = true;
                      Future<void> oneLap() async {
                        await controller.animateTo(controller.upperBound);
                        await controller.animateTo(controller.lowerBound);
                      }

                      await oneLap();
                      await oneLap();
                    }
                  },
                  effects: [
                    const FadeEffect(
                      duration: Duration(milliseconds: 200),
                      delay: Duration(milliseconds: 50),
                    ),
                  ],
                ),
              ),
            );
          }()
      ],
    );
  }

  Future pickThemeStyle() async {}
}
