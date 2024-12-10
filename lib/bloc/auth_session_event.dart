import 'package:equatable/equatable.dart';

abstract class AuthSessionEvent extends Equatable {
  const AuthSessionEvent({required this.lastLoggedInUserId});
  final String? lastLoggedInUserId;
  @override
  List<Object> get props => [];
}

class AppLostFocusEvent extends AuthSessionEvent {
  const AppLostFocusEvent({required super.lastLoggedInUserId});
}

class UserLoggedInEvent extends AuthSessionEvent {
  const UserLoggedInEvent(
      {required super.lastLoggedInUserId, this.freshLogin = true});
  final bool freshLogin;
}

class UserLogOutEvent extends AuthSessionEvent {
  const UserLogOutEvent({required super.lastLoggedInUserId});
}

class AppSessionTimeoutEvent extends AuthSessionEvent {
  const AppSessionTimeoutEvent({required super.lastLoggedInUserId});
}

class InitializeLastLogInUserEvent extends AuthSessionEvent {
  const InitializeLastLogInUserEvent({required super.lastLoggedInUserId});
}
