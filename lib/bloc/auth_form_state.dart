import 'package:equatable/equatable.dart';

abstract class AuthFormState extends Equatable {
  const AuthFormState({required this.name, required this.password});

  final String name;
  final String password;

  @override
  List<Object> get props => [name, password];
}

class AuthFormInitialState extends AuthFormState {
  const AuthFormInitialState({required super.name, required super.password});
}

class AuthFormSubmissionLoadingState extends AuthFormState {
  const AuthFormSubmissionLoadingState(
      {required super.name, required super.password});
}

class AuthFormSubmitSuccessState extends AuthFormState {
  const AuthFormSubmitSuccessState(
      {required super.name, required super.password});
}

class AuthFormSubmitFailedState extends AuthFormState {
  const AuthFormSubmitFailedState(
      {required super.name, required super.password, required this.errors});

  final Map<String, List> errors;

  @override
  String toString() {
    return 'AuthFormSubmitFailed(name: $name, password: $password, errors: $errors)';
  }

  @override
  List<Object> get props => [name, password, errors];
}
