import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fstation/impl/user_manager.dart';
import 'package:fstation/ui/widget/fingerprint_button.dart';
import 'package:fstation/ui/widget/flip_card_animation.dart';
import 'package:fstation/ui/widget/glassmorphism_cover.dart';
import 'package:fstation/ui/widget/quit_app_dialog.dart';
import 'package:fstation/ui/widget/sign_in_form.dart';
import 'package:fstation/ui/widget/sign_up_form.dart';

import '../bloc/auth_session_bloc.dart';
import '../bloc/auth_session_state.dart';
import '../util/auth_page_theme_extensions.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key, this.lastLoggedInUserId});

  final String? lastLoggedInUserId;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late Image neonImage;
  late bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_isInitialized) {
      final currentAuthState = BlocProvider.of<AuthSessionBloc>(context).state;
      if (currentAuthState is Unauthenticated) {
        UserManager.instance.startFingerPrintAuthIfNeeded();
      }
      _isInitialized = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final res = await quitAppDialog(context);
        if (res == true) {
          await SystemNavigator.pop();
        }
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              constraints: const BoxConstraints.expand(),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlipCardAnimation(
                        frontWidget: (void Function() flipCard) {
                          return SignUpForm(
                            flipCard: flipCard,
                          );
                        },
                        rearWidget: (void Function() flipCard) {
                          return SignInForm(
                            flipCard: flipCard,
                            lastLoggedInUserId: widget.lastLoggedInUserId,
                          );
                        },
                      ),
                      const SizedBox(height: 40),
                      if (MediaQuery.of(context).viewInsets.bottom == 0)
                        const FingerprintButton(),
                      SizedBox(
                        height: MediaQuery.of(context).viewInsets.bottom,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Positioned(
            //   child: Center(
            //     child: PrivacyPolicy(linkColor: linkColor),
            //   ),
            //   bottom: 20,
            //   right: 0,
            //   left: 0,
            // ),
            Positioned(
              top: 20,
              left: 20,
              child: Navigator.of(context).canPop()
                  ? GlassMorphismCover(
                      borderRadius: BorderRadius.circular(50),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
