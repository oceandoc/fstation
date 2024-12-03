import 'package:flutter/material.dart';

import '../../extension/auth_page_theme_extensions.dart';

class NameInputField extends StatelessWidget {
  const NameInputField({
    required this.getNameErrors, required this.onNameChanged, super.key,
    this.autoFocus = false,
  });
  final String? Function() getNameErrors;
  final void Function(String email) onNameChanged;
  final bool autoFocus;

  @override
  Widget build(BuildContext context) {
    final errorColor =
        Theme.of(context).extension<AuthPageThemeExtensions>()!.errorTextColor;
    final prefixIconColor =
        Theme.of(context).extension<AuthPageThemeExtensions>()!.prefixIconColor;

    final hintTextColor =
        Theme.of(context).extension<AuthPageThemeExtensions>()!.hintTextColor;

    final textColor =
        Theme.of(context).extension<AuthPageThemeExtensions>()!.textColor;

    final borderColor =
        Theme.of(context).extension<AuthPageThemeExtensions>()!.borderColor;

    final fillColor =
        Theme.of(context).extension<AuthPageThemeExtensions>()!.fillColor;
    return Stack(
      children: [
        TextField(
          autofocus: autoFocus,
          style: TextStyle(color: textColor),
          decoration: InputDecoration(
            hintText: 'name',
            hintStyle: TextStyle(color: hintTextColor),
            prefixIcon: Icon(
              Icons.account_circle,
              color: prefixIconColor,
            ),
            fillColor: fillColor,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: borderColor,
                width: 0.7,
              ),
            ),
            errorText: getNameErrors(),
            errorStyle: TextStyle(
              color: errorColor,
              fontWeight: FontWeight.bold,
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none),
          ),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          onChanged: onNameChanged,
        ),
      ],
    );
  }
}
