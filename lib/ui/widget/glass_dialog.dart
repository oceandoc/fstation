import 'package:flutter/material.dart';

import '../../util/popup_theme_extensions.dart';
import 'glassmorphism_cover.dart';

Future<dynamic> showCustomDialog(
    {required BuildContext context, required Widget child}) {
  final barrierColor =
      Theme.of(context).extension<PopupThemeExtensions>()!.barrierColor;

  final popupGradientStartColor = Theme.of(context)
      .extension<PopupThemeExtensions>()!
      .popupGradientStartColor;

  final popupGradientEndColor = Theme.of(context)
      .extension<PopupThemeExtensions>()!
      .popupGradientEndColor;

  return showGeneralDialog(
    context: context,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierDismissible: true,
    barrierColor: barrierColor,
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, anim1, anim2) {
      return Container(
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: GlassMorphismCover(
          borderRadius: BorderRadius.circular(40),
          child: Material(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                gradient: LinearGradient(
                  colors: [
                    popupGradientStartColor,
                    popupGradientEndColor,
                  ],
                  begin: AlignmentDirectional.topStart,
                  end: AlignmentDirectional.bottomEnd,
                ),
              ),
              child: child,
            ),
          ),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;
      if (anim.status == AnimationStatus.reverse) {
        tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
      } else {
        tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
      }

      return SlideTransition(
        position: tween.animate(anim),
        child: FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    },
  );
}
