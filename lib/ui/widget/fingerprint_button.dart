import 'package:flutter/material.dart';
import 'package:fstation/impl/user_manager.dart';

import 'glassmorphism_cover.dart';

class FingerprintButton extends StatelessWidget {
  const FingerprintButton({super.key});

  @override
  Widget build(BuildContext context) {
    if (!UserManager.instance.shouldActivateFingerPrint()) {
      return const SizedBox(
        height: 80,
        width: 80,
      );
    }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: GlassMorphismCover(
        borderRadius: BorderRadius.circular(50),
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: Colors.white.withOpacity(0.7),
              // width: 2,
            ),
          ),
          child: IconButton(
            iconSize: 50,
            icon: Icon(
              Icons.fingerprint,
              color: Colors.white.withOpacity(0.7),
            ),
            onPressed: UserManager.instance.startFingerPrintAuthIfNeeded,
          ),
        ),
      ),
    );
  }
}
