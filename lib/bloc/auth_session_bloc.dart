import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../model/user.dart';

part 'auth_session_event.dart';
part 'auth_session_state.dart';

class AuthSessionBloc extends Bloc<AuthSessionEvent, AuthSessionState> {
  AuthSessionBloc() : super(const Unauthenticated()) {
    on<InitalizeLastLoggedInUser>((event, emit) {

      String? lastLoggedInUserId =
          keyValueDataSource.getValue(Global.lastLoggedInUser);

      if (lastLoggedInUserId != null &&
          lastLoggedInUserId == GuestUserDetails.guestUserId) {
        emit(Authenticated(
            user: LoggedInUser.getGuestUserModel(), freshLogin: true));
      } else {
        emit(Unauthenticated(lastLoggedInUserId: lastLoggedInUserId));
      }
    });

    on<UserLoggedIn>((event, emit) =>
        emit(Authenticated(user: event.user, freshLogin: event.freshLogin)));

    on<UserLoggedOut>((event, emit) =>
        emit(Unauthenticated(lastLoggedInUserId: state.user?.id)));

    // navigation will be handled differently for session timeout logouts
    //! These 2 states aren't used as of now
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
