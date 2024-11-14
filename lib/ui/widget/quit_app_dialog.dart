
import 'package:flutter/material.dart';

import '../../util/popup_theme_extensions.dart';
import 'glass_dialog.dart';

Future<bool> quitAppDialog(BuildContext context) async {
  final mainTextColor =
      Theme.of(context).extension<PopupThemeExtensions>()!.mainTextColor;

  return await showCustomDialog(
    context: context,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            S.current.closeTheApp,
            style: TextStyle(
              fontSize: 18.0,
              color: mainTextColor,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              CancelButton(
                buttonText: "No",
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
              const SizedBox(width: 10),
              SubmitButton(
                isLoading: false,
                onSubmitted: () => Navigator.pop(context, true),
                buttonText: "Yes",
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
