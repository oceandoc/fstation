import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AuthFormEvent extends Equatable {
  const AuthFormEvent();

  @override
  List<Object?> get props => [];
}

class AuthFormInputsChangedEvent extends AuthFormEvent {
  const AuthFormInputsChangedEvent({this.name, this.password});
  final String? name;
  final String? password;
}

class AuthFormSignUpSubmittedEvent extends AuthFormEvent {
  const AuthFormSignUpSubmittedEvent({required this.context});
  final BuildContext context;
}

class AuthFormSignInSubmittedEvent extends AuthFormEvent {

  const AuthFormSignInSubmittedEvent({
    required this.context, this.lastLoggedInUserId,
  });
  final String? lastLoggedInUserId;
  final BuildContext context;

  @override
  List<Object?> get props => [lastLoggedInUserId, context];
}

class ResetAuthFormEvent extends AuthFormEvent {}

class AuthFormGuestSignInEvent extends AuthFormEvent {}
