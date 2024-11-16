import 'package:equatable/equatable.dart';

abstract class AuthFormEvent extends Equatable {
  const AuthFormEvent();

  @override
  List<Object> get props => [];
}

class AuthFormInputsChangedEvent extends AuthFormEvent {
  const AuthFormInputsChangedEvent({this.email, this.password});
  final String? email;
  final String? password;
}

class AuthFormSignUpSubmittedEvent extends AuthFormEvent {}

class AuthFormSignInSubmittedEvent extends AuthFormEvent {

  const AuthFormSignInSubmittedEvent({this.lastLoggedInUserId});
  final String? lastLoggedInUserId;
}

class ResetAuthFormEvent extends AuthFormEvent {}

class AuthFormGuestSignInEvent extends AuthFormEvent {}
