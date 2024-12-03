import 'package:fstation/util/validator/validator.dart';
import 'package:injectable/injectable.dart';

import '../../exception/validation_exceptions.dart';

@injectable
class NameValidator implements Validator<String> {
  static const int maxLength = 64;
  static const int minLength = 1;

  @override
  bool validate(String name) {
    // Check length first
    if (name.length < minLength || name.length > maxLength) {
      throw InvalidNameException.invalidLength(minLength, maxLength);
    }

    // Check format
    final isValid = RegExp(r'^[a-zA-Z][a-zA-Z0-9_]*$').hasMatch(name);
    if (!isValid) {
      throw InvalidNameException.invalidName();
    }

    return true;
  }
}
