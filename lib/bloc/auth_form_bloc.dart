import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fstation/impl/logger.dart';
import 'package:fstation/impl/user_manager.dart';
import 'package:go_router/go_router.dart';
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
        super(const AuthFormInitialState(name: '', password: '')) {
    on<AuthFormInputsChangedEvent>(
      (event, emit) {
        emit(
          AuthFormInitialState(
            name: event.name ?? state.name,
            password: event.password ?? state.password,
          ),
        );
      },
    );

    on<AuthFormGuestSignInEvent>(
      (event, emit) async {
        await UserManager.instance.updateCurrentUser(User(name: 'guest'));
        _authSessionBloc
            .add(const UserLoggedInEvent(lastLoggedInUserId: 'guest'));
      },
    );

    on<AuthFormSignUpSubmittedEvent>((event, emit) async {
      emit(AuthFormSubmissionLoadingState(
          name: state.name, password: state.password));

      final result = await UserManager.instance
          .signUpWithNameAndPassword(state.name, state.password);

      await result.fold((error) {
        final errorMap = <String, List>{};

        if (error.code == SignUpFailure.kUnknownError) {
          errorMap['general'] = [error.message];
        }
        if (error.code == SignUpFailure.kNoInternetConnection) {
          errorMap['general'] = [error.message];
        }
        if (error.code == SignUpFailure.kUserAlreadyExists) {
          errorMap['name'] = [error.message];
        }
        if (error.code == SignUpFailure.kUserName) {
          errorMap['name'] = [error.message];
        }
        if (error.code == SignUpFailure.kUserPassword) {
          errorMap['password'] = [error.message];
        }

        emit(AuthFormSubmitFailedState(
            name: state.name, password: state.password, errors: errorMap));
      }, (user) async {
        _authSessionBloc.add(UserLoggedInEvent(lastLoggedInUserId: state.name));
        emit(AuthFormSubmitSuccessState(
            name: state.name, password: state.password));
        UserManager.instance.cancelFingerprintAuth();
        UserManager.instance.isAuth = true;
        event.context.go('/home');
      });
    });

    on<AuthFormSignInSubmittedEvent>((event, emit) async {
      emit(AuthFormSubmissionLoadingState(
          name: state.name, password: state.password));

      final result = await UserManager.instance
          .signInWithNameAndPassword(state.name, state.password);

      await result.fold((error) {
        final errorMap = <String, List>{};

        if (error.code == SignInFailure.kUnknownError) {
          errorMap['general'] = [error.message];
        }
        if (error.code == SignInFailure.kNoInternetConnection) {
          errorMap['general'] = [error.message];
        }
        if (error.code == SignInFailure.kUserDisabled) {
          errorMap['general'] = [error.message];
        }
        if (error.code == SignUpFailure.kUserName) {
          errorMap['name'] = [error.message];
        }
        if (error.code == SignUpFailure.kUserPassword) {
          errorMap['password'] = [error.message];
        }

        emit(AuthFormSubmitFailedState(
            name: state.name, password: state.password, errors: errorMap));
      }, (user) async {
        _authSessionBloc.add(UserLoggedInEvent(lastLoggedInUserId: state.name));
        emit(AuthFormSubmitSuccessState(
            name: state.name, password: state.password));
        UserManager.instance.cancelFingerprintAuth();
        UserManager.instance.isAuth = true;
        Logger.debug('log in success');
        event.context.go('/home');
      });
    });

    on<ResetAuthFormEvent>((event, emit) {
      emit(const AuthFormInitialState(name: '', password: ''));
    });
  }

  final AuthSessionBloc _authSessionBloc;

  Future<Either<ForgotPasswordFailure, bool>> submitForgotPasswordName(
      String forgotPasswordName) async {
    return UserManager.instance.submitForgotPasswordName(forgotPasswordName);
  }
}
