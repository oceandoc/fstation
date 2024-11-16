import 'package:equatable/equatable.dart';

abstract class AuthSessionState extends Equatable {
  const AuthSessionState({required this.lastLoggedInUserId});
  final String? lastLoggedInUserId;
  @override
  List<Object> get props {
    final propsList = <Object>[];
    if (lastLoggedInUserId != null) {
      propsList.add(lastLoggedInUserId! as Object);
    }
    return propsList;
  }
}

class Unauthenticated extends AuthSessionState {
  const Unauthenticated(
      {this.sessionTimeoutLogout = false, super.lastLoggedInUserId});
  final bool sessionTimeoutLogout;
}

class Authenticated extends AuthSessionState {
  const Authenticated({this.freshLogin = true, super.lastLoggedInUserId});
  final bool freshLogin;
}
