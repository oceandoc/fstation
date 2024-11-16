import 'package:fstation/util/validator/validator.dart';
import 'package:injectable/injectable.dart';

import '../../exception/validation_exceptions.dart';

@injectable
class EmailValidator  implements Validator<String>  {
  @override
  bool validate(String email) {
    final isValid = RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);

    if (!isValid) {
      throw InvalidEmailException.invalidEmail();
    }

    return true;
  }
}
