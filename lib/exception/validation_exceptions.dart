import 'app_exception.dart';

class InvalidEmailException extends AppException {

  const InvalidEmailException._({required super.message, required super.code});

  factory InvalidEmailException.invalidEmail() {
    return const InvalidEmailException._(
        code: kInvalidEmail, message: 'invalid email');
  }
  static const kInvalidEmail = 0;
}

class InvalidPasswordException extends AppException {

  const InvalidPasswordException._({required super.message, required super.code});

  factory InvalidPasswordException.shortPassword() {
    return const InvalidPasswordException._(
        code: kShortPassword, message: 'password must be at least 6 characters');
  }

  factory InvalidPasswordException.longPassword() {
    return const InvalidPasswordException._(
        code: kLongPassword,
        message: 'password must not be longer than 20 characters');
  }
  static const kShortPassword = 0;
  static const kLongPassword = 1;
}
