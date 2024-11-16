import 'package:dartz/dartz.dart' as dz;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fstation/ui/widget/submit_button.dart';
import '../../bloc/auth_form_bloc.dart';
import '../../bloc/auth_form_event.dart';
import '../../bloc/auth_form_state.dart';
import '../../generated/l10n.dart';
import '../../util/auth_page_theme_extensions.dart';
import '../../util/util.dart';
import 'auth_change.dart';
import 'email_input_field.dart';
import 'failures.dart';
import 'forgot_password_popup.dart';
import 'form_dimensions.dart';
import 'glassmorphism_cover.dart';
import 'password_input_field.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    required this.flipCard,
    super.key,
    this.lastLoggedInUserId,
  });

  final void Function() flipCard;
  final String? lastLoggedInUserId;

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool initialized = false;

  late AuthFormBloc bloc;

  Future<dz.Either<ForgotPasswordFailure, bool>> submitForgotPasswordEmail(
      String forgotPasswordEmail) async {
    return bloc.submitForgotPasswordEmail(forgotPasswordEmail);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!initialized) {
      bloc = BlocProvider.of<AuthFormBloc>(context);
      bloc.add(ResetAuthFormEvent());
      initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthFormBloc, AuthFormState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is AuthFormSubmissionFailed &&
            state.errors.containsKey('general')) {
          showToast(state.errors['general']![0].toString());
        }
      },
      builder: (context, state) {
        String? getEmailErrors() {
          if (state is AuthFormSubmissionFailed &&
              state.errors.containsKey('email')) {
            return state.errors['email']![0].toString();
          }
          return null;
        }

        String? getPasswordErrors() {
          if (state is AuthFormSubmissionFailed &&
              state.errors.containsKey('password')) {
            return state.errors['password']?[0].toString();
          }
          return null;
        }

        void onEmailChanged(String email) =>
            bloc.add(AuthFormInputsChangedEvent(email: email));

        void onPasswordChanged(String password) =>
            bloc.add(AuthFormInputsChangedEvent(password: password));

        void onSubmitted() => bloc.add(AuthFormSignInSubmittedEvent(
            lastLoggedInUserId: widget.lastLoggedInUserId));

        final linkColor =
            Theme.of(context).extension<AuthPageThemeExtensions>()!.linkColor;

        return GlassMorphismCover(
          borderRadius: BorderRadius.circular(16),
          child: FormDimensions(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    Localization.current.log_in,
                    style: const TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AuthEmailInput(
                        getEmailErrors: getEmailErrors,
                        onEmailChanged: onEmailChanged,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AuthPasswordInput(
                        getPasswordErrors: getPasswordErrors,
                        onPasswordChanged: onPasswordChanged,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SubmitButton(
                        isLoading: state is AuthFormSubmissionLoading,
                        onSubmitted: onSubmitted,
                        buttonText: Localization.current.submit,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          forgotPasswordPopup(
                              context, submitForgotPasswordEmail);
                        },
                        child: Text(
                          Localization.current.forgot_password,
                          style: TextStyle(
                            color: linkColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      AuthChangePage(
                        infoText: Localization.current.dont_have_account,
                        flipPageText: Localization.current.sign_up,
                        flipCard: widget.flipCard,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
