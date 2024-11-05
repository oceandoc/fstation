import 'package:go_router/go_router.dart';

import '../generated/l10n.dart';
import '../ui/home_page.dart';
import '../ui/setting_page.dart';
import '../ui/splash_page.dart';
import '../ui/widget/global_footer.dart';

final GoRouter router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
        path: '/splash',
        builder: (context, state) => SplashPage(),
        routes: [
          GoRoute(path: 'home', builder: (context, state) => const HomePage()),
        ]),
    StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            GlobalFooter(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
                name: Localization.current.page_home_title,
                path: '/home',
                builder: (context, state) => const HomePage(),
                routes: const [])
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                name: Localization.current.page_setting_title,
                path: '/Library',
                builder: (context, state) => const SettingPage(),
                routes: const []),
          ]),
        ]),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingPage(),
    ),
  ],
);
