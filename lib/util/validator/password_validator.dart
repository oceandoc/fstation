
import 'package:fstation/util/validator/validator.dart';
import 'package:injectable/injectable.dart';

import '../../exception/validation_exceptions.dart';

@injectable
class PasswordValidator implements Validator<String> {
  @override
  bool validate(String password) {
    if (password.length < 6) {
      throw InvalidPasswordException.shortPassword();
    }
    if (password.length > 20) {
      throw InvalidPasswordException.longPassword();
    }

    return true;
  }
}
