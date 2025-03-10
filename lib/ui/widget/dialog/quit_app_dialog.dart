import 'package:flutter/material.dart';
import 'package:fstation/ui/widget/buttons.dart';

import '../../../extension/popup_theme_extensions.dart';
import '../../../generated/l10n.dart';
import 'glass_dialog.dart';

Future<bool> quitAppDialog(BuildContext context) async {
  final mainTextColor =
      Theme.of(context).extension<PopupThemeExtensions>()!.mainTextColor;

  return (await showCustomDialog(
        context: context,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                Localization.current.close_app,
                style: TextStyle(
                  fontSize: 18,
                  color: mainTextColor,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: const Text('No'),
                  ),
                  const SizedBox(width: 10),
                  SubmitButton(
                    isLoading: false,
                    onSubmitted: () => Navigator.pop(context, true),
                    buttonText: 'Yes',
                  ),
                ],
              ),
            ],
          ),
        ),
      ) ??
      false) as bool;
}
