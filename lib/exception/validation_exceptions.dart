import 'app_exception.dart';

class InvalidEmailException extends AppException {
  const InvalidEmailException._({required super.message, required super.code});

  factory InvalidEmailException.invalidEmail() {
    return const InvalidEmailException._(
        code: kInvalidEmail, message: 'invalid email');
  }
  static const kInvalidEmail = 0;
}

class InvalidNameException extends AppException {
  const InvalidNameException._({required super.message, required super.code});

  factory InvalidNameException.invalidName() {
    return const InvalidNameException._(
        code: kInvalidName, message: 'invalid name');
  }

  factory InvalidNameException.invalidLength(int min, int max) {
    return InvalidNameException._(
        code: kInvalidLength,
        message: 'Name length must be between $min and $max characters');
  }

  static const kInvalidName = 0;
  static const kInvalidLength = 1;
}

class InvalidPasswordException extends AppException {
  const InvalidPasswordException._(
      {required super.message, required super.code});

  factory InvalidPasswordException.shortPassword() {
    return const InvalidPasswordException._(
        code: kShortPassword,
        message: 'password must be at least 6 characters');
  }

  factory InvalidPasswordException.longPassword() {
    return const InvalidPasswordException._(
        code: kLongPassword,
        message: 'password must not be longer than 20 characters');
  }
  static const kShortPassword = 0;
  static const kLongPassword = 1;
}
