import 'package:flutter/material.dart';
import 'package:fstation/impl/setting_impl.dart';
import 'package:fstation/impl/user_manager.dart';
import 'package:go_router/go_router.dart';

import '../ui/albums_select_page.dart';
import '../ui/backup_page.dart';
import '../ui/error_page.dart';
import '../ui/home_page.dart';
import '../ui/login_page.dart';
import '../ui/profile_page.dart';
import '../ui/server_config_page.dart';
import '../ui/splash_page.dart';
import '../ui/store_repo_config_page.dart';
import '../ui/widget/bottom_nav_bar.dart';

final GoRouter router = GoRouter(
  initialLocation: '/home',
  redirect: (context, state) {
    if (SettingImpl.instance.firstLaunch) {
      return '/splash';
    } else if (UserManager.instance.isAuth) {
      if (SettingImpl.instance.serverRepoUuids.isEmpty) {
        return '/store_repo_config';
      }
      return null;
    } else if (SettingImpl.instance.serverAddr.isEmpty) {
      return '/server_addr_config';
    } else if (!UserManager.instance.isAuth) {
      return '/login';
    }
    return null;
  },
  errorBuilder: (context, state) {
    return ErrorPage(error: state.error);
  },
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashPage(),
      routes: [
        GoRoute(path: '/home', builder: (context, state) => const HomePage()),
        GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      ],
    ),
    GoRoute(
      path: '/store_repo_config',
      builder: (context, state) => const StoreRepoConfigPage(),
      routes: [
        GoRoute(path: '/home', builder: (context, state) => const HomePage()),
      ],
    ),
    GoRoute(
      path: '/server_addr_config',
      builder: (context, state) => const ServerConfigPage(),
      routes: [
        GoRoute(path: '/home', builder: (context, state) => const HomePage()),
        GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      ],
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
      routes: [
        GoRoute(path: '/home', builder: (context, state) => const HomePage()),
      ],
    ),
    GoRoute(
      path: '/backup',
      builder: (context, state) => const BackupPage(),
    ),
    GoRoute(
      path: '/select_albums',
      builder: (context, state) => const AlbumsSelectPage(),
    ),
    StatefulShellRoute(
      navigatorContainerBuilder: (context, navigationShell, children) {
        return children[navigationShell.currentIndex];
      },
      builder: (context, state, child) {
        return ScaffoldWithBottomNavBar(child: child);
      },
      branches: [
        // Branch 1
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) {
                return const HomePage();
              },
              routes: [
                GoRoute(
                  path: '/backup',
                  builder: (context, state) => const BackupPage(),
                  routes: [
                    GoRoute(
                      path: '/select_albums',
                      builder: (context, state) => const AlbumsSelectPage(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        // Branch 2
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) {
                return const ProfilePage();
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
