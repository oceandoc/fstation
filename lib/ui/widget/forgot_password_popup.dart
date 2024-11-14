import 'package:flutter/material.dart';
import 'package:fstation/ui/widget/submit_button.dart';

import '../../generated/l10n.dart';
import '../../util/popup_theme_extensions.dart';
import '../../util/util.dart';
import 'email_input_field.dart';
import 'failures.dart';
import 'glass_dialog.dart';

Future<void> forgotPasswordPopup(
    BuildContext context, Function(String) submitForgotPassword) {
  var forgotPasswordEmail = '';

  var isLoading = false;

  final mainTextColor =
      Theme.of(context).extension<PopupThemeExtensions>()!.mainTextColor;

  return showCustomDialog(
    context: context,
    child: Container(
      width: 300,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(Localization.current.enter_registered_email,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: mainTextColor,
              )),
          const SizedBox(height: 25),
          AuthEmailInput(
            autoFocus: true,
            getEmailErrors: () => null,
            onEmailChanged: (String email) {
              forgotPasswordEmail = email;
            },
          ),
          const SizedBox(height: 25),
          StatefulBuilder(builder: (context, setState) {
            return SubmitButton(
              isLoading: isLoading,
              onSubmitted: () async {
                setState(() {
                  isLoading = true;
                });

                final result = await submitForgotPassword(forgotPasswordEmail);
                result.fold((ForgotPasswordFailure e) {
                  setState(() {
                    isLoading = false;
                  });
                  showToast(e.message);
                }, (_) {
                  setState(() {
                    isLoading = false;
                  });
                  showToast(Localization.current.password_reset_mail_sent);
                  Navigator.of(context).pop();
                });
              },
              buttonText: Localization.current.submit,
            );
          })
        ],
      ),
    ),
  );
}
