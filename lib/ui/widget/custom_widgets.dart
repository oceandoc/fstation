import 'package:checkmark/checkmark.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fstation/extension/context_extension.dart';
import 'package:fstation/extension/extensions.dart';


class TapDetector extends StatelessWidget {
  const TapDetector({
    required this.onTap,
    super.key,
    this.initializer,
    this.child,
    this.behavior,
  });

  final VoidCallback? onTap;
  final void Function(TapGestureRecognizer instance)? initializer;
  final Widget? child;
  final HitTestBehavior? behavior;

  @override
  Widget build(BuildContext context) {
    final gestures = <Type, GestureRecognizerFactory>{};
    gestures[TapGestureRecognizer] =
        GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
      () => TapGestureRecognizer(debugOwner: this),
      initializer ??
          (TapGestureRecognizer instance) {
            instance
              ..onTap = onTap
              ..gestureSettings = MediaQuery.maybeGestureSettingsOf(context);
          },
    );

    return RawGestureDetector(
      behavior: behavior,
      gestures: gestures,
      child: child,
    );
  }
}

class ListTileWithCheckMark extends StatelessWidget {
  const ListTileWithCheckMark({
    super.key,
    this.active = false,
    this.onTap,
    this.title,
    this.subtitle = '',
    this.icon = Icons.radio_button_unchecked,
    this.tileColor,
    this.titleWidget,
    this.leading,
    this.iconSize,
    this.dense = false,
    this.expanded = true,
  });

  final bool active;
  final void Function()? onTap;
  final String? title;
  final String subtitle;
  final IconData? icon;
  final Color? tileColor;
  final Widget? titleWidget;
  final Widget? leading;
  final double? iconSize;
  final bool dense;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final tileAlpha = context.isDarkMode ? 5 : 20;
    final br = BorderRadius.circular(14.0);
    final titleWidgetFinal = Padding(
      padding: EdgeInsets.symmetric(horizontal: dense ? 10.0 : 14.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleWidget ??
              Text(title ?? '', style: context.textTheme.displayMedium),
          if (subtitle != '')
            Text(subtitle, style: context.textTheme.displaySmall)
        ],
      ),
    );

    final cardColor =
        context.theme.cardTheme.color ?? context.theme.colorScheme.surface;

    return Material(
        borderRadius: br,
        color: tileColor ??
            Color.alphaBlend(
                context.theme.colorScheme.onSurface.withAlpha(tileAlpha),
                cardColor),
        child: InkWell(
          borderRadius: br,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
              children: [
                if (leading != null)
                  leading!
                else if (icon != null)
                  Icon(icon, size: iconSize),
                if (expanded)
                  Expanded(child: titleWidgetFinal)
                else
                  Flexible(child: titleWidgetFinal),
                NamidaCheckMark(
                  size: 18,
                  active: active,
                  activeColor: context.theme.listTileTheme.iconColor ??
                      context.theme.colorScheme.primary,
                  inactiveColor: context.theme.listTileTheme.iconColor ??
                      context.theme.colorScheme.onSurface,
                )
              ],
            ),
          ),
        ));
  }
}

class NamidaCheckMark extends StatelessWidget {
  const NamidaCheckMark({
    required this.size,
    required this.active,
    super.key,
    this.activeColor,
    this.inactiveColor,
  });

  final double size;
  final bool active;
  final Color? activeColor;
  final Color? inactiveColor;

  @override
  Widget build(BuildContext context) {
    final defaultColor = context.theme.listTileTheme.iconColor ??
        context.theme.colorScheme.onSurface;

    return SizedBox(
      width: size,
      height: size,
      child: CheckMark(
        strokeWidth: 2,
        activeColor: activeColor ?? defaultColor,
        inactiveColor: inactiveColor ?? defaultColor,
        duration: const Duration(milliseconds: 400),
        active: active,
      ),
    );
  }
}
