import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fstation/ui/widget/buttons.dart';
import 'package:fstation/ui/widget/password_input_field.dart';

import '../../../bloc/auth_form_bloc.dart';
import '../../../bloc/auth_form_event.dart';
import '../../../bloc/auth_form_state.dart';
import '../../../generated/l10n.dart';
import '../../../util/util.dart';
import '../form_dimensions.dart';
import '../glassmorphism_cover.dart';
import '../name_input_field.dart';
import 'auth_change.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    required this.flipCard,
    super.key,
  });

  final void Function() flipCard;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool isInitialized = false;
  late AuthFormBloc bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!isInitialized) {
      bloc = BlocProvider.of<AuthFormBloc>(context);
      bloc.add(ResetAuthFormEvent());
      isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AuthFormBloc>(context);

    return BlocConsumer<AuthFormBloc, AuthFormState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is AuthFormSubmitFailedState &&
            state.errors.containsKey('general')) {
          showToast(state.errors['general']![0].toString());
        }
      },
      builder: (context, state) {
        String? getNameErrors() {
          if (state is AuthFormSubmitFailedState &&
              state.errors.containsKey('name')) {
            return state.errors['name']![0].toString();
          }
          return null;
        }

        String? getPasswordErrors() {
          if (state is AuthFormSubmitFailedState &&
              state.errors.containsKey('password')) {
            return state.errors['password']?[0].toString();
          }
          return null;
        }

        void onNameChanged(String name) =>
            bloc.add(AuthFormInputsChangedEvent(name: name));

        void onPasswordChanged(String password) =>
            bloc.add(AuthFormInputsChangedEvent(password: password));

        void onSubmitted() => bloc.add(AuthFormSignUpSubmittedEvent(context: context));

        return GlassMorphismCover(
          borderRadius: BorderRadius.circular(16),
          child: FormDimensions(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    Localization.current.sign_up,
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      NameInputField(
                        getNameErrors: getNameErrors,
                        onNameChanged: onNameChanged,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      PasswordInputField(
                        getPasswordErrors: getPasswordErrors,
                        onPasswordChanged: onPasswordChanged,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SubmitButton(
                        isLoading: state is AuthFormSubmissionLoadingState,
                        onSubmitted: onSubmitted,
                        buttonText: Localization.current.submit,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      AuthChangePage(
                        infoText: Localization.current.already_have_account,
                        flipPageText: Localization.current.log_in,
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
