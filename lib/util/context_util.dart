

import 'package:flutter/material.dart';
import 'package:fstation/extension/context_extension.dart';

import 'constants.dart';

class ContextUtil {
  BuildContext? get context => kAppKey.currentContext;
  BuildContext? get overlayContext => kAppKey.currentState?.overlay?.context;

  ThemeData get theme => context == null ? ThemeData.fallback() : context!.theme;
  TextTheme get textTheme => theme.textTheme;
  bool get isDarkMode => theme.brightness == Brightness.dark;

  EdgeInsets? get padding => context == null ? null : MediaQuery.paddingOf(context!);
  EdgeInsets? get viewPadding => context == null ? null : MediaQuery.viewPaddingOf(context!);
  EdgeInsets? get viewInsets => context == null ? null : MediaQuery.viewInsetsOf(context!);
}
