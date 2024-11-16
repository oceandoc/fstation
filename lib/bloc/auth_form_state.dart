import 'package:equatable/equatable.dart';

abstract class AuthFormState extends Equatable {
  const AuthFormState({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class AuthFormInitial extends AuthFormState {
  const AuthFormInitial({required super.email, required super.password});
}

class AuthFormSubmissionLoading extends AuthFormState {
  const AuthFormSubmissionLoading(
      {required super.email, required super.password});
}

class AuthFormSubmissionSuccessful extends AuthFormState {
  const AuthFormSubmissionSuccessful(
      {required super.email, required super.password});
}

class AuthFormSubmissionFailed extends AuthFormState {
  const AuthFormSubmissionFailed(
      {required super.email, required super.password, required this.errors});

  final Map<String, List> errors;

  @override
  String toString() {
    return 'AuthFormSubmissionFailed(email: $email, password: $password, errors: $errors)';
  }

  @override
  List<Object> get props => [email, password, errors];
}
