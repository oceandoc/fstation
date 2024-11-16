import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../impl/user_manager.dart';
import 'auth_session_event.dart';
import 'auth_session_state.dart';

@injectable
class AuthSessionBloc extends Bloc<AuthSessionEvent, AuthSessionState> {
  AuthSessionBloc() : super(const Unauthenticated()) {
    on<InitializeLastLoggedInUser>((event, emit) {
      if (UserManager.instance.isAuth) {
        emit(Authenticated(
            lastLoggedInUserId: UserManager.instance.lastLoginUser));
      } else {
        emit(Unauthenticated(
            lastLoggedInUserId: UserManager.instance.lastLoginUser));
      }
    });

    on<UserLoggedIn>((event, emit) => emit(Authenticated(
        lastLoggedInUserId: event.lastLoggedInUserId,
        freshLogin: event.freshLogin)));

    on<UserLoggedOut>((event, emit) =>
        emit(Unauthenticated(lastLoggedInUserId: state.lastLoggedInUserId)));

    on<AppLostFocus>((event, emit) {
      if (state is Authenticated) {
        emit(const Unauthenticated(sessionTimeoutLogout: true));
      }
    });

    on<AppSessionTimeout>((event, emit) {
      if (state is Authenticated) {
        emit(const Unauthenticated(sessionTimeoutLogout: true));
      }
    });
  }
}
