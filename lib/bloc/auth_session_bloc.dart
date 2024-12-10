import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../impl/user_manager.dart';
import 'auth_session_event.dart';
import 'auth_session_state.dart';

@injectable
class AuthSessionBloc extends Bloc<AuthSessionEvent, AuthSessionState> {
  AuthSessionBloc() : super(const UnauthenticatedState()) {
    on<InitializeLastLogInUserEvent>((event, emit) {
      if (UserManager.instance.isAuth) {
        emit(AuthenticatedState(
            lastLogInUserId: UserManager.instance.lastLoginUser));
      } else {
        emit(UnauthenticatedState(
            lastLogInUserId: UserManager.instance.lastLoginUser));
      }
    });

    on<UserLoggedInEvent>((event, emit) => emit(AuthenticatedState(
        lastLogInUserId: event.lastLoggedInUserId,
        freshLogin: event.freshLogin)));

    on<UserLogOutEvent>((event, emit) =>
        emit(UnauthenticatedState(lastLogInUserId: state.lastLogInUserId)));

    on<AppLostFocusEvent>((event, emit) {
      if (state is AuthenticatedState) {
        emit(const UnauthenticatedState(sessionTimeoutLogout: true));
      }
    });

    on<AppSessionTimeoutEvent>((event, emit) {
      if (state is AuthenticatedState) {
        emit(const UnauthenticatedState(sessionTimeoutLogout: true));
      }
    });
  }
}
