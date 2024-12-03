// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../bloc/app_setting_bloc.dart' as _i3;
import '../bloc/auth_form_bloc.dart' as _i8;
import '../bloc/auth_session_bloc.dart' as _i4;
import 'validator/email_validator.dart' as _i5;
import 'validator/name_validator.dart' as _i6;
import 'validator/password_validator.dart' as _i7;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.AppSettingBloc>(() => _i3.AppSettingBloc());
    gh.factory<_i4.AuthSessionBloc>(() => _i4.AuthSessionBloc());
    gh.factory<_i5.EmailValidator>(() => _i5.EmailValidator());
    gh.factory<_i6.NameValidator>(() => _i6.NameValidator());
    gh.factory<_i7.PasswordValidator>(() => _i7.PasswordValidator());
    gh.factory<_i8.AuthFormBloc>(
        () => _i8.AuthFormBloc(authSessionBloc: gh<_i4.AuthSessionBloc>()));
    return this;
  }
}
