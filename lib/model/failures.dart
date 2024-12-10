import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure({required this.message, required this.code});

  final String message;
  final int code;

  @override
  List<Object?> get props => [code, message];

  @override
  String toString() {
    return 'Error $code: $message';
  }
}

class SignUpFailure extends Failure {
  const SignUpFailure._({required super.message, required super.code});

  factory SignUpFailure.unknownError([String? message]) {
    return SignUpFailure._(
        message: message ?? 'unknown error occurred, please try again',
        code: kUnknownError);
  }

  factory SignUpFailure.noInternetConnection([String? message]) {
    return SignUpFailure._(
        message: message ?? 'please turn on internet for sign up',
        code: kNoInternetConnection);
  }

  factory SignUpFailure.userAlreadyExists([String? message]) {
    return SignUpFailure._(
        message: message ?? 'user already exists', code: kUserAlreadyExists);
  }

  factory SignUpFailure.invalidUserName([String? message]) {
    return SignUpFailure._(
        message: message ?? 'invalid user name',
        code: kUserName);
  }

  factory SignUpFailure.invalidUserPassword([String? message]) {
    return SignUpFailure._(
        message: message ?? 'invalid user password',
        code: kUserPassword);
  }

  static const kUnknownError = -1;
  static const kNoInternetConnection = 1;
  static const kUserAlreadyExists = 2;
  static const kUserName = 3;
  static const kUserPassword = 4;

}

class SignInFailure extends Failure {
  const SignInFailure._({required super.message, required super.code});

  factory SignInFailure.unknownError([String? message]) {
    return SignInFailure._(
        message: message ?? 'unknown error occurred, please try again',
        code: kUnknownError);
  }

  factory SignInFailure.noInternetConnection([String? message]) {
    return SignInFailure._(
        message: message ?? 'please turn on internet for first log in',
        code: kNoInternetConnection);
  }

  factory SignInFailure.invalidUserName([String? message]) {
    return SignInFailure._(
        message: message ?? 'invalid user name',
        code: kUserName);
  }

  factory SignInFailure.invalidUserPassword([String? message]) {
    return SignInFailure._(
        message: message ?? 'invalid user password',
        code: kUserPassword);
  }

  factory SignInFailure.userDisabled([String? message]) {
    return SignInFailure._(
        message:
            message ?? 'user has been banned, please contact customer service',
        code: kUserDisabled);
  }

  static const kUnknownError = -1;
  static const kNoInternetConnection = 1;
  static const kUserName = 2;
  static const kUserPassword = 3;
  static const kUserDisabled = 4;
}

class ForgotPasswordFailure extends Failure {
  const ForgotPasswordFailure._({required super.message, required super.code});

  factory ForgotPasswordFailure.unknownError([String? message]) {
    return ForgotPasswordFailure._(
      message: message ?? 'Unknown error occurred',
      code: kUnknownError,
    );
  }

  factory ForgotPasswordFailure.noInternetConnection([String? message]) {
    return ForgotPasswordFailure._(
        message: message ?? 'please turn on internet for first log in',
        code: kNoInternetConnection);
  }

  factory ForgotPasswordFailure.userNotFound([String? message]) {
    return ForgotPasswordFailure._(
      message: message ?? 'user not found',
      code: kUserNotFound,
    );
  }

  static const kUnknownError = -1;
  static const kNoInternetConnection = 3;
  static const kUserNotFound = 4;
}
