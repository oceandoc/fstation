import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import '../ui/home_page.dart';
import '../ui/setting_page.dart';
import '../ui/splash_page.dart';
import '../ui/widget/global_footer.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  AppRouter() : super();

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  late final List<AutoRoute> routes = [
    AutoRoute(
      page: SplashRoute.page,
      initial: true,
    ),
  ];
}

class _RouterObserver extends AutoRouterObserver {
  final List<String> _navigationStack = [];

  @override
  void didPush(Route route, Route? previousRoute) {
    _updateStack(route);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    _navigationStack.removeLast();
  }

  void _updateStack(Route route) {
    if (route.settings.name != null) {
      _navigationStack.add(route.settings.name!);
      if (_navigationStack.length > 5) {
        _navigationStack.removeAt(0);
      }
    }
  }

  List<String> get lastFivePages => _navigationStack.reversed.toList();
}


final routerObserver = _RouterObserver();

final router = AppRouter();
