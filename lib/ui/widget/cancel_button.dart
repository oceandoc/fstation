import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {

  const CancelButton(
      {required this.buttonText, required this.onPressed, super.key});
  final String buttonText;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: Theme.of(context).textButtonTheme.style,
      onPressed: onPressed,
      child: Text(
        buttonText,
      ),
    );
  }
}
