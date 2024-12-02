import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../extension/auth_page_theme_extensions.dart';

class UrlInputField extends StatelessWidget {
  const UrlInputField({
    super.key,
    required this.getUrlErrors,
    this.onServerChanged,
    required this.controller,
  });

  final String? Function() getUrlErrors;
  final void Function(String)? onServerChanged;
  final TextEditingController controller;

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
          controller: controller,
          style: TextStyle(color: textColor),
          decoration: InputDecoration(
            hintText: kIsWeb ? 'https://demo.com:port' : 'ip:port',
            hintStyle: TextStyle(color: hintTextColor),
            prefixIcon: Icon(
              Icons.cloud,
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
            errorText: getUrlErrors(),
            errorStyle: TextStyle(
              color: errorColor,
              fontWeight: FontWeight.bold,
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none),
          ),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.url,
          // onChanged: onServerChanged,
        ),
      ],
    );
  }
}
