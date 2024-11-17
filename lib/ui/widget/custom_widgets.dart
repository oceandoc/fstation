import 'package:checkmark/checkmark.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fstation/extension/context_extension.dart';
import 'package:fstation/extension/extensions.dart';

class CustomBlurryDialog extends StatelessWidget {
  const CustomBlurryDialog({
    super.key,
    this.child,
    this.trailingWidgets,
    this.title,
    this.titleWidget,
    this.titleWidgetInPadding,
    this.actions,
    this.icon,
    this.normalTitleStyle = false,
    this.bodyText,
    this.isWarning = false,
    this.horizontalInset = 50.0,
    this.verticalInset = 32.0,
    this.scrollable = true,
    this.contentPadding = const EdgeInsets.all(14),
    this.leftAction,
    this.theme,
  });

  final IconData? icon;
  final String? title;
  final Widget? titleWidget;
  final Widget? titleWidgetInPadding;
  final List<Widget>? trailingWidgets;
  final Widget? child;
  final List<Widget>? actions;
  final Widget? leftAction;
  final bool normalTitleStyle;
  final String? bodyText;
  final bool isWarning;
  final bool scrollable;
  final double horizontalInset;
  final double verticalInset;
  final EdgeInsetsGeometry contentPadding;
  final ThemeData? theme;

  static double calculateHorizontalMargin(
      BuildContext context, double minimum) {
    final screenWidth = context.width;
    final val = (screenWidth / 1000).clamp(0.0, 1.0);
    var percentage = 0.25 * val * val;
    percentage = percentage.clamp(0.0, 0.25);
    return (screenWidth * percentage).withMinimum(minimum);
  }

  @override
  Widget build(BuildContext context) {
    final ctxTheme = theme ?? context.theme;
    final vInsets = verticalInset;
    final horizontalMargin =
        calculateHorizontalMargin(context, horizontalInset);
    return Center(
      child: SingleChildScrollView(
        child: Dialog(
          backgroundColor: ctxTheme.dialogBackgroundColor,
          surfaceTintColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(
              horizontal: horizontalMargin, vertical: vInsets),
          clipBehavior: Clip.antiAlias,
          child: TapDetector(
            onTap: () {},
            child: Container(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (titleWidget != null) titleWidget!,
                  if (titleWidgetInPadding != null)
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 28, left: 28, right: 24),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: titleWidgetInPadding,
                      ),
                    ),
                  if (titleWidget == null && titleWidgetInPadding == null)
                    normalTitleStyle
                        ? Padding(
                            padding: const EdgeInsets.only(
                                top: 28, left: 28, right: 24),
                            child: Row(
                              children: [
                                if (icon != null || isWarning) ...[
                                  Icon(isWarning ? Icons.warning : icon),
                                  const SizedBox(width: 10),
                                ],
                                Expanded(
                                  child: Text(title ?? '',
                                      style: ctxTheme.textTheme.displayLarge),
                                ),
                                if (trailingWidgets != null) ...trailingWidgets!
                              ],
                            ),
                          )
                        : Container(
                            color: ctxTheme.cardTheme.color,
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (icon != null) ...[
                                  Icon(icon),
                                  const SizedBox(width: 10),
                                ],
                                Expanded(
                                  child: Text(
                                    title ?? '',
                                    style: ctxTheme.textTheme.displayMedium,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  Padding(
                    padding: contentPadding,
                    child: SizedBox(
                      width: context.width,
                      child: bodyText != null
                          ? Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                bodyText!,
                                style: ctxTheme.textTheme.displayMedium,
                              ),
                            )
                          : child,
                    ),
                  ),

                  /// Actions.
                  if (actions != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: SizedBox(
                        width: context.width - horizontalInset,
                        child: Wrap(
                          alignment: leftAction == null
                              ? WrapAlignment.end
                              : WrapAlignment.spaceBetween,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            if (leftAction != null) ...[
                              const SizedBox(width: 6),
                              leftAction!,
                              const SizedBox(width: 6),
                            ],
                            ...actions!.addSeparators(
                                separator: const SizedBox(width: 6))
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

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
    final br = BorderRadius.circular(14.0.multipliedRadius);
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
