import 'package:equatable/equatable.dart';

abstract class AuthFormState extends Equatable {
  const AuthFormState({required this.name, required this.password});

  final String name;
  final String password;

  @override
  List<Object> get props => [name, password];
}

class AuthFormInitial extends AuthFormState {
  const AuthFormInitial({required super.name, required super.password});
}

class AuthFormSubmissionLoading extends AuthFormState {
  const AuthFormSubmissionLoading(
      {required super.name, required super.password});
}

class AuthFormSubmissionSuccessful extends AuthFormState {
  const AuthFormSubmissionSuccessful(
      {required super.name, required super.password});
}

class AuthFormSubmissionFailed extends AuthFormState {
  const AuthFormSubmissionFailed(
      {required super.name, required super.password, required this.errors});

  final Map<String, List> errors;

  @override
  String toString() {
    return 'AuthFormSubmissionFailed(email: $name, password: $password, errors: $errors)';
  }

  @override
  List<Object> get props => [name, password, errors];
}
