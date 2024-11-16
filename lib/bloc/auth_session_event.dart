import 'package:equatable/equatable.dart';

abstract class AuthSessionEvent extends Equatable {
  const AuthSessionEvent({required this.lastLoggedInUserId});
  final String? lastLoggedInUserId;
  @override
  List<Object> get props => [];
}

class AppLostFocus extends AuthSessionEvent {
  const AppLostFocus({required super.lastLoggedInUserId});
}

class UserLoggedIn extends AuthSessionEvent {
  const UserLoggedIn(
      {required super.lastLoggedInUserId, this.freshLogin = true});


  final bool freshLogin;
}

class UserLoggedOut extends AuthSessionEvent {
  const UserLoggedOut({required super.lastLoggedInUserId});
}

class AppSessionTimeout extends AuthSessionEvent {
  const AppSessionTimeout({required super.lastLoggedInUserId});
}

class InitializeLastLoggedInUser extends AuthSessionEvent {
  const InitializeLastLoggedInUser({required super.lastLoggedInUserId});
}
