
import 'package:flutter/material.dart';
import 'package:fstation/extension/context_extension.dart';
import 'package:fstation/extension/extensions.dart';

import '../custom_widgets.dart';

class BlurryDialog extends StatelessWidget {
  const BlurryDialog({
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