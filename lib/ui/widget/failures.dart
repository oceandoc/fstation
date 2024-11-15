import 'failure_template.dart';

class SignUpFailure extends Failure {

  const SignUpFailure._({required super.message, required super.code});

  factory SignUpFailure.unknownError([String? message]) {
    return SignUpFailure._(
        message: message ?? 'unknown error occurred, please try again',
        code: kUnknownError);
  }


  factory SignUpFailure.userAlreadyExists([String? message]) {
    return SignUpFailure._(
        message: message ?? 'user already exists',
        code: kUserAlreadyExists);
  }

  factory SignUpFailure.invalidUserPasswordCombination([String? message]) {
    return SignUpFailure._(
        message: message ?? 'invalid password', code: kInvalidUserPasswordCombination);
  }

  factory SignUpFailure.noInternetConnection([String? message]) {
    return SignUpFailure._(
        message: message ?? 'please turn on internet for sign up',
        code: kNoInternetConnection);
  }

  static const kUnknownError = -1;
  static const kInvalidUserName = 0;
  static const kUserAlreadyExists = 1;
  static const kInvalidUserPasswordCombination = 2;
  static const kNoInternetConnection = 3;
}

class SignInFailure extends Failure {

  const SignInFailure._({required super.message, required super.code});

  factory SignInFailure.unknownError([String? message]) {
    return SignInFailure._(
        message: message ?? 'unknown error occurred, please try again',
        code: kUnknownError);
  }

  factory SignInFailure.invalidUserPasswordCombination([String? message]) {
    return SignInFailure._(
        message: message ?? 'invalid email', code: kInvalidUserPasswordCombination);
  }

  factory SignInFailure.noInternetConnection([String? message]) {
    return SignInFailure._(
        message: message ?? 'please turn on internet for first log in',
        code: kNoInternetConnection);
  }

  factory SignInFailure.userDisabled([String? message]) {
    return SignInFailure._(
        message:
            message ?? 'user has been banned, please contact customer service',
        code: kUserDisabled);
  }
  static const kUnknownError = -1;
  static const kInvalidUserName = 0;
  static const kUserAlreadyExists = 1;
  static const kInvalidUserPasswordCombination = 2;
  static const kNoInternetConnection = 3;
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
      message: message ?? 'No internet connection',
      code: kNoInternetConnection,
    );
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
