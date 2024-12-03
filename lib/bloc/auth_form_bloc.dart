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
        super(const AuthFormInitial(name: '', password: '')) {
    on<AuthFormInputsChangedEvent>(
      (event, emit) {
        emit(
          AuthFormInitial(
            name: event.name ?? state.name,
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
          name: state.name, password: state.password));

      final result = await UserManager.instance
          .signUpWithNameAndPassword(state.name, state.password);

      await result.fold((error) {
        final errorMap = <String, List>{};

        if (error.code == SignUpFailure.kUnknownError) {
          errorMap['general'] = [error.message];
        }
        if (error.code == SignUpFailure.kInvalidUserName) {
          errorMap['name'] = [error.message];
        }
        if (error.code == SignUpFailure.kUserAlreadyExists) {
          errorMap['name'] = [error.message];
        }
        if (error.code == SignUpFailure.kInvalidUserPasswordCombination) {
          errorMap['password'] = [error.message];
        }
        if (error.code == SignUpFailure.kNoInternetConnection) {
          errorMap['general'] = [error.message];
        }

        emit(AuthFormSubmissionFailed(
            name: state.name, password: state.password, errors: errorMap));
      }, (user) async {
        _authSessionBloc.add(UserLoggedIn(lastLoggedInUserId: state.name));

        emit(AuthFormSubmissionSuccessful(
            name: state.name, password: state.password));
        UserManager.instance.cancelFingerprintAuth();
      });
    });

    on<AuthFormSignInSubmittedEvent>((event, emit) async {
      emit(AuthFormSubmissionLoading(
          name: state.name, password: state.password));
    });

    on<ResetAuthFormEvent>((event, emit) {
      emit(const AuthFormInitial(name: '', password: ''));
    });
  }

  final AuthSessionBloc _authSessionBloc;

  Future<Either<ForgotPasswordFailure, bool>> submitForgotPasswordName(
      String forgotPasswordName) async {
    return UserManager.instance
        .submitForgotPasswordName(forgotPasswordName);
  }
}
