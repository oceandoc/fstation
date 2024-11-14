import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../bloc/app_setting_bloc.dart';
import '../generated/l10n.dart';
import '../impl/setting_impl.dart';
import '../util/language.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  int page = 0;
  List<Widget> pages = [];

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
    // if (!SettingImpl.instance.firstLaunch) {
    //   context.go('/home');
    // }
    pages = [
      welcomePage,
      languagePage,
      darkModePage,
    ];

    Widget child = PageView(
      controller: _pageController,
      physics: const BouncingScrollPhysics(),
      onPageChanged: (i) {
        FocusScope.of(context)
            .requestFocus(FocusNode()); //Dismiss keyboard on page change
        setState(() {
          page = i;
        });
      },
      children: pages,
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
            constraints: const BoxConstraints(),
            child: child,
          ),
        ),
      ),
    );
  }

  Widget get welcomePage {
    return Column(
      children: [
        const SizedBox(height: 80),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
          child: Image.asset('assets/logo_color.png', width: 180),
        ),
        const SizedBox(height: 30),
        const _AnimatedHello(),
        const SizedBox(height: 100)
      ],
    );
  }

  Divider Function(dynamic context, dynamic _) separatorBuilder =
      (context, _) => const Divider(
            height: 1,
            indent: 48,
            endIndent: 48,
          );

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
            onTap: () async {
              await SettingImpl.instance.saveLanguage(lang.code);
              context
                  .read<AppSettingBloc>()
                  .add(ChangeLanguageEvent(lang.code));
            },
          );
        },
        separatorBuilder: separatorBuilder,
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
      case ThemeMode.system:
        return Localization.current.theme_setting_dark_mode_system;
    }
  }

  Widget get darkModePage {
    return BlocBuilder<AppSettingBloc, AppSettingState>(
      builder: (context, state) {
        return _IntroPage(
          icon: FontAwesomeIcons.circleHalfStroke,
          title: Localization.current.theme_setting_dark_mode,
          content: ListView.separated(
            itemBuilder: (context, index) {
              final mode = ThemeMode.values[index];
              return ListTile(
                leading: state.themeMode == mode
                    ? const Icon(Icons.done_rounded)
                    : const SizedBox(),
                title: Text(_themeModeName(mode)),
                minLeadingWidth: 24,
                onTap: () async {
                  await SettingImpl.instance.saveThemeMode(mode);
                  context
                      .read<AppSettingBloc>()
                      .add(ChangeThemeModeEvent(mode));
                },
              );
            },
            separatorBuilder: separatorBuilder,
            itemCount: ThemeMode.values.length,
          ),
        );
      },
    );
  }

  Widget _bottom() {
    return PositionedDirectional(
      bottom: 10,
      start: 10,
      end: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (page >= pages.length - 1) ...[
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size.fromHeight(50),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue.withOpacity(0.7),
                ),
                onPressed: () async {
                  await Future.delayed(const Duration(milliseconds: 300));
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        shadows: [Shadow(color: Colors.grey)],
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 30,
                      shadows: [
                        Shadow(
                          color: Colors.grey,
                          blurRadius: 3,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
          Center(
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
        ],
      ),
    );
  }
}

class _IntroPage extends StatelessWidget {
  const _IntroPage({this.icon, this.title, this.content});

  final IconData? icon;
  final String? title;
  final Widget? content;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 36),
        if (icon != null) FaIcon(icon, size: 80),
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
  const _AnimatedHello();

  @override
  _AnimatedHelloState createState() => _AnimatedHelloState();
}

class _AnimatedHelloState extends State<_AnimatedHello> {
  List<String> get _hellos => const [
        'Hello',
        '你好',
        'φ(≧ω≦*)♪',
        'ヽ(^o^)丿',
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
        height: 80,
        child: Text(
          _hellos[index],
          style: const TextStyle(fontSize: 64),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
