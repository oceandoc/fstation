import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fstation/impl/user_manager.dart';
import 'package:fstation/ui/widget/auth/fingerprint_button.dart';
import 'package:fstation/ui/widget/auth/sign_in_form.dart';
import 'package:fstation/ui/widget/auth/sign_up_form.dart';
import 'package:fstation/ui/widget/dialog/quit_app_dialog.dart';
import 'package:fstation/ui/widget/flip_card_animation.dart';

import '../bloc/auth_session_bloc.dart';
import '../bloc/auth_session_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, this.lastLoggedInUserId});

  final String? lastLoggedInUserId;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
      if (currentAuthState is UnauthenticatedState) {
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
          ],
        ),
      ),
    );
  }
}
