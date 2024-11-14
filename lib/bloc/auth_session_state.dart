part of 'auth_session_bloc.dart';

abstract class AuthSessionState extends Equatable {
  final User? user;

  const AuthSessionState({required this.user});

  @override
  List<Object> get props {
    final propsList = <Object>[];

    // Add user.id to propsList if user is not null
    if (user != null) {
      propsList.add(user!.name! as Object);
    }

    return propsList;
  }
}

class Unauthenticated extends AuthSessionState {
  final bool sessionTimeoutLogout;
  final String? lastLoggedInUserId;
  const Unauthenticated(
      {this.sessionTimeoutLogout = false, this.lastLoggedInUserId})
      : super(user: null);
}

class Authenticated extends AuthSessionState {
  final bool freshLogin;
  const Authenticated({required User user, this.freshLogin = true})
      : super(user: user);
}
