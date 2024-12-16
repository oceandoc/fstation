import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fstation/impl/setting_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';

import '../bloc/auth_session_bloc.dart';
import '../bloc/auth_session_event.dart';
import '../exception/validation_exceptions.dart';
import '../generated/error.pbenum.dart';
import '../generated/l10n.dart';
import '../model/failures.dart';
import '../model/user.dart';
import '../util/network_util.dart';
import '../util/util.dart';
import '../util/validator/name_validator.dart';
import '../util/validator/password_validator.dart';
import 'grpc_client.dart';
import 'logger.dart';
import 'store.dart';

enum FingerPrintAuthState {
  success,
  fail,
  platformError,
  attemptsExceeded,
}

class UserManager {
  UserManager._internal();

  static final UserManager _instance = UserManager._internal();

  static UserManager get instance => _instance;

  User? _currentUser;

  User? get currentUser => _currentUser;

  bool _isAuth = false;

  bool get isAuth => _isAuth;

  set isAuth(bool value) => _isAuth = value;

  String? get lastLoginUser => _currentUser?.name;
  String? get token => _currentUser?.token;

  bool isFingerPrintAuthActivated = false;
  StreamSubscription<FingerPrintAuthState?>? fingerPrintAuthStreamSubscription;
  final LocalAuthentication auth = LocalAuthentication();

  Future<void> init() async {
    final currentUser = await Store.instance.getCurrentUser();
    if (currentUser == null) {
      return;
    }

    _currentUser = User.fromJson(currentUser);
    debugPrint('init token: ${_currentUser?.token}');
    await updateToken();
  }

  Future<void> updateToken() async {
    if (_currentUser == null || _currentUser!.token!.isEmpty) {
      return;
    }
    try {
      final response = await GrpcClient.instance.updateToken(_currentUser!);
      if (response.errCode == ErrCode.Success) {
        _currentUser!.token = response.token;
        _currentUser!.tokenUpdateTime = DateTime.now();
        await updateUser(_currentUser);
        _isAuth = true;
        Logger.error('updateToken success');
      } else {
        _currentUser?.token = '';
        await updateUser(_currentUser);
        Logger.error('updateToken error: token wrong or expired: ${response.errCode}');
      }
    } catch (e, s) {
      Logger.error('Failed to update token:', e, s);
    }
  }

  Future<void> updateUser(User? user, {bool updateCurrentUser = false}) async {
    if (user == null || user.name == null) return;
    debugPrint('update user token: ${user.token}');
    await Store.instance.updateUser(
      name: user.name!,
      token: user.token,
      tokenUpdateTime: user.tokenUpdateTime?.toIso8601String(),
    );
    if (updateCurrentUser) {
      _currentUser = user;
      await Store.instance.setCurrentUser(user.name!);
    }
  }

  Future<void> clearCurrentUser() async {
    if (_currentUser == null || _currentUser!.name == null) return;
    await Store.instance.deleteUser(_currentUser!.name!);
    await Store.instance.deleteCurrentUser();
    _currentUser = null;
  }

  Future<void> updateCurrentUser(User user) async {
    await updateUser(user);
    await Store.instance.setCurrentUser(user.name!);
    _currentUser = user;
  }

  bool shouldActivateFingerPrint() {
    try {
      Logger.info('Checking for activating fingerprints');
      Logger.debug('lastLoggedInUser = $UserManager.instance.lastLoginUser ');
      if (UserManager.instance.lastLoginUser == null) {
        return false;
      }
      return SettingImpl.instance.enableFingerprint == true;
    } catch (e) {
      Logger.error(e.toString());
      return false;
    }
  }

  void startFingerPrintAuthIfNeeded() {
    if (!shouldActivateFingerPrint()) {
      return;
    }

    if (isFingerPrintAuthActivated == true) {
      Logger.info('Finger print auth was previously running, disabling it');
      fingerPrintAuthStreamSubscription?.cancel();
    }

    isFingerPrintAuthActivated = true;
    final fingerPrintAuthStream = processFingerPrintAuth();

    fingerPrintAuthStreamSubscription =
        fingerPrintAuthStream.listen((value) async {
      Logger.debug('FingerPrintAuthState stream value = $value');

      if (value == FingerPrintAuthState.success) {
        await fingerPrintAuthStreamSubscription?.cancel();
        isFingerPrintAuthActivated = false;
        GetIt.I<AuthSessionBloc>()
            .add(UserLoggedInEvent(lastLoggedInUserId: lastLoginUser));
      } else if (value == FingerPrintAuthState.platformError) {
        await fingerPrintAuthStreamSubscription?.cancel();
        isFingerPrintAuthActivated = false;
      } else if (value == FingerPrintAuthState.attemptsExceeded) {
        await fingerPrintAuthStreamSubscription?.cancel();
        isFingerPrintAuthActivated = false;

        showToast(Localization.current.too_many_wrong_attempts);
      } else if (value == FingerPrintAuthState.fail) {
        await fingerPrintAuthStreamSubscription?.cancel();
        isFingerPrintAuthActivated = false;

        showToast(Localization.current.fingerprint_login_failed);
      }
    });
  }

  void cancelFingerprintAuth() {
    Logger.info('Cancelling fingerprint auth stream');
    fingerPrintAuthStreamSubscription?.cancel();
  }

  Future<void> isFingerprintAuthPossible() async {
    final hasBiometrics = await auth.canCheckBiometrics;
    Logger.info('hasBiometrics = $hasBiometrics');
    if (hasBiometrics == false) {
      throw Exception("device doesn't support fingerprint");
    }

    final availableBiometrics = await auth.getAvailableBiometrics();
    Logger.info('available biometrics = $availableBiometrics');

    final hasFingerprintSetup =
        availableBiometrics.contains(BiometricType.strong) ||
            availableBiometrics.contains(BiometricType.fingerprint);

    if (!hasFingerprintSetup) {
      throw Exception('please setup fingerprint in device settings');
    }
  }

  Stream<FingerPrintAuthState> processFingerPrintAuth() async* {
    Logger.info('Started processing fingerprint auth');

    while (true) {
      try {
        final authenticationResult = await auth.authenticate(
          localizedReason: 'Scan Fingerprint to Authenticate',
          options: const AuthenticationOptions(
              stickyAuth: true, biometricOnly: true),
        );

        if (authenticationResult == false) {
          yield FingerPrintAuthState.fail;
        } else if (authenticationResult == true) {
          await auth.stopAuthentication();
          yield FingerPrintAuthState.success;
        }
        await Future.delayed(const Duration(milliseconds: 500));
      } on PlatformException catch (e) {
        Logger.error(e.toString());
        await auth.stopAuthentication();
      }
    }
  }

  Future<Either<SignInFailure, User>> signIn({
    required String name,
    required String password,
  }) async {
    Logger.info('signIn - [$name]');
    if (!ConnectivityUtil.instance.hasInternetConnection()) {
      return Left(SignInFailure.noInternetConnection());
    }

    //try {
    final userRes = await GrpcClient.instance.login(name, password);
    if (userRes.errCode == ErrCode.Success) {
      final user = User(
        name: name,
        token: userRes.token,
        tokenUpdateTime: DateTime.now(),
      );
      await UserManager.instance.updateUser(user, updateCurrentUser: true);
      return Right(user);
    } else if (userRes.errCode == ErrCode.User_name_error) {
      return Left(SignInFailure.invalidUserName());
    } else if (userRes.errCode == ErrCode.User_passwd_error) {
      return Left(SignInFailure.invalidUserPassword());
    } else if (userRes.errCode == ErrCode.User_not_exists) {
      return Left(SignInFailure.invalidUserName());
    } else if (userRes.errCode == ErrCode.User_disabled) {
      return Left(SignInFailure.userDisabled());
    }
    // } catch (e) {
    //   Logger.error('Sign in failed: $e');
    // }
    return Left(SignInFailure.unknownError());
  }

  Future<Either<SignInFailure, User>> signInWithNameAndPassword(
      String name, String password) {
    try {
      GetIt.I<NameValidator>().validate(name);
      GetIt.I<PasswordValidator>().validate(password);
    } on InvalidNameException catch (e) {
      return Future.value(Left(SignInFailure.invalidUserName(e.message)));
    } on InvalidPasswordException catch (e) {
      return Future.value(Left(SignInFailure.invalidUserPassword(e.message)));
    }
    return signIn(name: name, password: password);
  }

  Future<Either<SignUpFailure, User>> signUp({
    required String name,
    required String password,
  }) async {
    Logger.info('signUp - [$name, $password]');
    if (!ConnectivityUtil.instance.hasInternetConnection()) {
      return Left(SignUpFailure.noInternetConnection());
    }

    try {
      final userRes = await GrpcClient.instance.register(name, password);
      if (userRes.errCode == ErrCode.Success) {
        return Right(User(
            name: name, token: userRes.token, tokenUpdateTime: DateTime.now()));
      } else if (userRes.errCode == ErrCode.User_name_error) {
        return Left(SignUpFailure.invalidUserName());
      } else if (userRes.errCode == ErrCode.User_passwd_error) {
        return Left(SignUpFailure.invalidUserPassword());
      } else if (userRes.errCode == ErrCode.User_exists) {
        return Left(SignUpFailure.userAlreadyExists());
      }
      return Left(SignUpFailure.unknownError());
    } catch (e) {
      Logger.error('Sign up failed: $e');
    }
    return Left(SignUpFailure.unknownError());
  }

  Future<Either<SignUpFailure, User>> signUpWithNameAndPassword(
      String name, String password) {
    try {
      GetIt.I<NameValidator>().validate(name);
      GetIt.I<PasswordValidator>().validate(password);
    } on InvalidNameException catch (e) {
      return Future.value(Left(SignUpFailure.invalidUserName(e.message)));
    } on InvalidPasswordException catch (e) {
      return Future.value(Left(SignUpFailure.invalidUserPassword(e.message)));
    }
    return signUp(name: name, password: password);
  }

  Future<Either<ForgotPasswordFailure, bool>> submitForgotPasswordName(
      String forgotPasswordName) async {
    try {
      GetIt.I<NameValidator>().validate(forgotPasswordName);

      if (!ConnectivityUtil.instance.hasInternetConnection()) {
        return Left(ForgotPasswordFailure.noInternetConnection());
      }
      return const Right(true);
    } catch (e) {
      return Left(ForgotPasswordFailure.unknownError());
    }
  }
}
