import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fstation/impl/user_manager.dart';
import 'package:injectable/injectable.dart';

import '../model/failures.dart';
import '../model/user.dart';
import 'auth_form_event.dart';
import 'auth_form_state.dart';
import 'auth_session_bloc.dart';
import 'auth_session_event.dart';

@injectable
class AuthFormBloc extends Bloc<AuthFormEvent, AuthFormState> {
  AuthFormBloc({
    required AuthSessionBloc authSessionBloc,
  })  : _authSessionBloc = authSessionBloc,
        super(const AuthFormInitial(email: '', password: '')) {
    on<AuthFormInputsChangedEvent>(
      (event, emit) {
        emit(
          AuthFormInitial(
            email: event.email ?? state.email,
            password: event.password ?? state.password,
          ),
        );
      },
    );

    on<AuthFormGuestSignInEvent>(
      (event, emit) async {
        await UserManager.instance.updateCurrentUser(User(name: 'guest'));
        _authSessionBloc.add(const UserLoggedIn(lastLoggedInUserId: 'guest'));
      },
    );

    on<AuthFormSignUpSubmittedEvent>((event, emit) async {
      emit(AuthFormSubmissionLoading(
          email: state.email, password: state.password));

      final result = await UserManager.instance
          .signUpWithEmailAndPassword(state.email, state.password);

      await result.fold((error) {
        final errorMap = <String, List>{};

        if (error.code == SignUpFailure.kUnknownError) {
          errorMap['general'] = [error.message];
        }
        if (error.code == SignUpFailure.kInvalidUserName) {
          errorMap['email'] = [error.message];
        }
        if (error.code == SignUpFailure.kUserAlreadyExists) {
          errorMap['email'] = [error.message];
        }
        if (error.code == SignUpFailure.kInvalidUserPasswordCombination) {
          errorMap['password'] = [error.message];
        }
        if (error.code == SignUpFailure.kNoInternetConnection) {
          errorMap['general'] = [error.message];
        }

        emit(AuthFormSubmissionFailed(
            email: state.email, password: state.password, errors: errorMap));
      }, (user) async {
        _authSessionBloc.add(UserLoggedIn(lastLoggedInUserId: state.email));

        emit(AuthFormSubmissionSuccessful(
            email: state.email, password: state.password));
        UserManager.instance.cancelFingerprintAuth();
      });
    });

    on<AuthFormSignInSubmittedEvent>((event, emit) async {
      emit(AuthFormSubmissionLoading(
          email: state.email, password: state.password));
    });

    on<ResetAuthFormEvent>((event, emit) {
      emit(const AuthFormInitial(email: '', password: ''));
    });
  }

  final AuthSessionBloc _authSessionBloc;

  Future<Either<ForgotPasswordFailure, bool>> submitForgotPasswordEmail(
      String forgotPasswordEmail) async {
    return UserManager.instance
        .submitForgotPasswordEmail(forgotPasswordEmail);
  }
}
