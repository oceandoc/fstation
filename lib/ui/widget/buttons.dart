import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    required this.isLoading, required this.onSubmitted, required this.buttonText, super.key,
  });
  final bool isLoading;
  final Function() onSubmitted;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const SizedBox.shrink(),
      onPressed: isLoading ? null : onSubmitted,
      label: Text(
        buttonText,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.amber,
        ),
      ),
    );
  }
}
