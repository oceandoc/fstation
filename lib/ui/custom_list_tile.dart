import 'package:flutter/material.dart';
import 'package:fstation/extension/context_extension.dart';
import 'package:fstation/extension/extensions.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    required this.title,
    super.key,
    this.subtitle,
    this.trailing,
    this.trailingRaw,
    this.trailingText,
    this.onTap,
    this.leading,
    this.icon,
    this.passedColor,
    this.rotateIcon,
    this.enabled = true,
    this.largeTitle = false,
    this.maxSubtitleLines = 8,
    this.visualDensity,
    this.titleStyle,
    this.borderR = 20.0,
    this.bgColor,
    this.verticalPadding = 0.0,
  });
  final void Function()? onTap;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final Widget? trailingRaw;
  final String? trailingText;
  final IconData? icon;
  final Widget? leading;
  final Color? passedColor;
  final int? rotateIcon;
  final bool enabled;
  final bool largeTitle;
  final int maxSubtitleLines;
  final VisualDensity? visualDensity;
  final TextStyle? titleStyle;
  final double borderR;
  final Color? bgColor;
  final double verticalPadding;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.blue,
      fontStyle: FontStyle.italic,
      letterSpacing: 2,
      wordSpacing: 4,
      decoration: TextDecoration.underline,
      decorationStyle: TextDecorationStyle.dashed,
      decorationColor: Colors.red,
      shadows: [
        Shadow(
          blurRadius: 10,
          offset: Offset(5, 5),
        ),
      ],
    );

    final iconColor = passedColor;
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 400),
      opacity: enabled ? 1.0 : 0.5,
      child: ListTile(
        enabled: enabled,
        tileColor: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderR.multipliedRadius),
        ),
        visualDensity: visualDensity,
        onTap: onTap,
        contentPadding:
            EdgeInsets.symmetric(horizontal: 16, vertical: verticalPadding),
        minVerticalPadding: 8,
        leading: icon != null
            ? SizedBox(
                height: double.infinity,
                child: rotateIcon != null
                    ? RotatedBox(
                        quarterTurns: rotateIcon!,
                        child: Icon(
                          icon,
                          color: iconColor,
                        ),
                      )
                    : Icon(
                        icon,
                        color: iconColor,
                      ),
              )
            : leading,
        title: Text(
          title,
          style: titleStyle,
          maxLines: subtitle != null ? 4 : 5,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: subtitle?.isNotEmpty == true
            ? Text(
                subtitle!,
                style: textStyle,
                maxLines: maxSubtitleLines,
                overflow: TextOverflow.ellipsis,
              )
            : null,
        trailing: trailingRaw ??
            (trailing == null && trailingText == null
                ? null
                : FittedBox(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(maxWidth: context.width * 0.3),
                      child: trailingText != null
                          ? Text(
                              trailingText!,
                              style: textStyle,
                            )
                          : trailing,
                    ),
                  )),
      ),
    );
  }
}
