import 'dart:async';

import '../app_device_info.dart';
import './analysis_impl.dart';

class AppAnalysis {
  AppAnalysis._();
  factory AppAnalysis._instantiate() {
    if (isAndroid || isIOS) {
      return AppAnalysisImpl();
    }
    return AppAnalysis._();
  }
  static AppAnalysis instance = AppAnalysis._instantiate();
  static final bool isSupported = isAndroid || isIOS;

  Future<void> initiate() => Future.value();
  Future<String?> startView(String? viewName) => Future.value();
  Future<void> stopView(FutureOr<String?> viewId) => Future.value();
  Future<void> reportError(dynamic error, dynamic stackTrace) => Future.value();
  Future<void> logEvent(String eventId, [Map<String, String>? attributes]) => Future.value();

  static (String baseRoute, String subpath) splitViewName(String viewName) {
    final queryIndex = viewName.indexOf('?');
    var finalViewName = viewName;
    if (queryIndex >= 0) {
      finalViewName = viewName.substring(0, queryIndex);
    }

    if (finalViewName.isEmpty) return (finalViewName, '');

    String? baseRoute;

    for (final category in const ['buffAction', 'summon', 'script']) {
      final route = '/$category/';
      if (finalViewName.startsWith(route)) {
        baseRoute = route;
        break;
      }
    }
    baseRoute ??= finalViewName;
    final match = RegExp(r'^(/.+?)(\-?\d+/)*\-?\d+$').firstMatch(baseRoute);
    baseRoute = match?.group(1) ?? baseRoute;
    assert(finalViewName.startsWith(baseRoute), '$finalViewName -> $baseRoute');
    final subPath = finalViewName.startsWith(baseRoute) ? finalViewName.substring(baseRoute.length) : '';
    if (baseRoute.isEmpty) return (finalViewName, '');
    return (baseRoute, subPath);
  }
}
