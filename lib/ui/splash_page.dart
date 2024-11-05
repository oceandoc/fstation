import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fstation/ui/widget/start_fail_page.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../generated/l10n.dart';
import '../impl/setting.dart';
import '../util/constants.dart';
import '../util/language.dart';

class SplashPage extends StatefulWidget {
  SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  int page = 0;
  List<Widget> pages = [];
  bool _startupLoadingFailed = false;
  bool invalidStartup = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!SettingImpl.instance.firstLanuch) {
      context.go('/home');
    }
    pages = [
      welcomePage,
      languagePage,
      darkModePage,
    ];

    Widget child = PageView(
      controller: _pageController,
      children: pages,
      onPageChanged: (i) {
        FocusScope.of(context).requestFocus(FocusNode());
        setState(() {
          page = i;
        });
      },
    );

    child = Stack(children: [child, _bottom()]);
    return wrapChild(child);
  }

  Widget wrapChild(Widget child) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 768),
            child: child,
          ),
        ),
      ),
    );
  }

  Widget get welcomePage {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
          child: Image.asset(
            // 'res/img/chaldea.png',
            'res/img/launcher_icon/app_icon_logo.png',
            width: 180,
          ),
        ),
        Text(
          'Chaldea',
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        _AnimatedHello(),
        const SizedBox(height: 100)
      ],
    );
  }

  Widget get languagePage {
    return _IntroPage(
      icon: FontAwesomeIcons.earthAsia,
      title: Localization.current.select_lang,
      content: ListView.separated(
        itemBuilder: (context, index) {
          final lang = Language.supportLanguages[index];
          return ListTile(
            leading: Language.getLanguage(SettingImpl.instance.language) == lang
                ? const Icon(Icons.done_rounded)
                : const SizedBox(),
            title: Text(lang.name),
            minLeadingWidth: 24,
            onTap: () {
              SettingImpl.instance.language = lang.code;
            },
          );
        },
        separatorBuilder: (context, _) => const Divider(
          height: 1,
          indent: 48,
          endIndent: 48,
        ),
        itemCount: Language.supportLanguages.length,
      ),
    );
  }

  String _themeModeName(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.dark:
        return Localization.current.theme_setting_dark_mode_dark;
      case ThemeMode.light:
        return Localization.current.theme_setting_dark_mode_light;
      default:
        return Localization.current.theme_setting_dark_mode_system;
    }
  }

  Widget get darkModePage {
    return _IntroPage(
      icon: FontAwesomeIcons.circleHalfStroke,
      title: Localization.current.theme_setting_dark_mode,
      content: ListView.separated(
        itemBuilder: (context, index) {
          final mode = ThemeMode.values[index];
          return ListTile(
            leading: SettingImpl.instance.themeMode == mode
                ? const Icon(Icons.done_rounded)
                : const SizedBox(),
            title: Text(_themeModeName(mode)),
            minLeadingWidth: 24,
            onTap: () {
              SettingImpl.instance.themeMode = mode;
            },
          );
        },
        separatorBuilder: (context, _) => const Divider(
          height: 1,
          indent: 48,
          endIndent: 48,
        ),
        itemCount: ThemeMode.values.length,
      ),
    );
  }


  Widget _bottom() {
    List<Widget> children = [Expanded(
      flex: 2,
      child: Center(
        child: SmoothPageIndicator(
          controller: _pageController,
          count: pages.length,
          effect: const WormEffect(
              dotHeight: 10, dotWidth: 10, activeDotColor: Colors.blue),
          onDotClicked: (i) {
            setState(() {
              page = i;
              _pageController.animateToPage(
                i,
                duration: kTabScrollDuration,
                curve: Curves.easeInOut,
              );
            });
          },
        ),
      ),
    )];
    if (page >= pages.length - 1) {
      // TODO(xieyz): jump logic
    }
    return PositionedDirectional(
      bottom: 10.0,
      start: 10.0,
      end: 10.0,
      child: Row(children: children),
    );
  }
}

class _IntroPage extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final Widget? content;

  const _IntroPage({this.icon, this.title, this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 36),
        if (icon != null)
          FaIcon(
            icon!,
            size: 80,
            color: Theme.of(context).brightness == Brightness.dark
                ? null
                : Theme.of(context).colorScheme.tertiary,
          ),
        if (title != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(title!, style: Theme.of(context).textTheme.titleLarge),
          ),
        if (content != null) Expanded(child: content!),
        const SizedBox(height: 48),
      ],
    );
  }
}

class _AnimatedHello extends StatefulWidget {
  _AnimatedHello();

  @override
  _AnimatedHelloState createState() => _AnimatedHelloState();
}

class _AnimatedHelloState extends State<_AnimatedHello> {
  List<String> get _hellos => const [
        // 'φ(≧ω≦*)♪'
        'ヽ(^o^)丿',
        '你好',
        'Hello',
        'こんにちは',
        '哈嘍',
        '안녕하세요',
        '¡Buenas!',
        '\u0645\u0631\u062d\u0628\u0627', // Arabic
      ];
  bool shown = false;
  int index = 0;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        setState(() {
          shown = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: shown ? 0.9 : 0,
      curve: Curves.easeInOut,
      duration: const Duration(seconds: 2),
      onEnd: () {
        if (!shown) {
          index = Random().nextInt(_hellos.length);
        }
        shown = !shown;
        setState(() {});
      },
      child: SizedBox(
        height: 36,
        child: Text(
          _hellos[index],
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
