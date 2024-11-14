import 'package:flutter/material.dart';

import 'glassmorphism_cover.dart';

class FingerprintButton extends StatelessWidget {
  late final FingerPrintAuthRepository fingerPrintAuthRepository;

  FingerprintButton({
    super.key,
  }) {
    fingerPrintAuthRepository = sl<FingerPrintAuthRepository>();
  }

  @override
  Widget build(BuildContext context) {
    return fingerPrintAuthRepository.shouldActivateFingerPrint()
        ? Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: GlassMorphismCover(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(50), // Adjust the radius as needed
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
                  onPressed: () {
                    fingerPrintAuthRepository.startFingerPrintAuthIfNeeded();
                  },
                ),
              ),
            ),
          )
        : const SizedBox(
            height: 80,
            width: 80,
          );
  }
}
