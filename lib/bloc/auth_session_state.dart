import 'package:equatable/equatable.dart';

abstract class AuthSessionState extends Equatable {
  const AuthSessionState({required this.lastLogInUserId});
  final String? lastLogInUserId;
  @override
  List<Object> get props {
    final propsList = <Object>[];
    if (lastLogInUserId != null) {
      propsList.add(lastLogInUserId! as Object);
    }
    return propsList;
  }
}

class UnauthenticatedState extends AuthSessionState {
  const UnauthenticatedState(
      {this.sessionTimeoutLogout = false, super.lastLogInUserId});
  final bool sessionTimeoutLogout;
}

class AuthenticatedState extends AuthSessionState {
  const AuthenticatedState({this.freshLogin = true, super.lastLogInUserId});
  final bool freshLogin;
}
