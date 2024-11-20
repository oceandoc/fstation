import 'dart:async';

import 'package:dartz/dartz.dart';
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
import '../util/validator/email_validator.dart';
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

  bool get isAuth => _currentUser?.name != null && _currentUser?.token != null;

  String? get lastLoginUser => _currentUser?.name;

  bool isFingerPrintAuthActivated = false;
  StreamSubscription<FingerPrintAuthState?>? fingerPrintAuthStreamSubscription;
  final LocalAuthentication auth = LocalAuthentication();

  Future<void> init() async {
    // First try to get current user from database
    final currentUser = await Store.instance.getCurrentUser();
    if (currentUser == null) {
      return;
    }
    _currentUser = User.fromJson(currentUser);
    await updateToken();
  }

  Future<void> updateToken() async {
    if (_currentUser == null) {
      return;
    }
    if (!isAuth) {
      return;
    }

    try {
      final response = await GrpcClient.instance.updateToken(_currentUser!);
      if (response.errCode == ErrCode.Success) {
        _currentUser!.token = response.token;
        _currentUser!.tokenUpdateTime = DateTime.now();
        await updateUser(_currentUser);
      }
    } catch (e, s) {
      Logger.error('Failed to update token:', e, s);
    }
  }

  Future<void> updateUser(User? user, {bool updateCurrentUser = false}) async {
    if (user == null || user.name == null) return;
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
            .add(UserLoggedIn(lastLoggedInUserId: lastLoginUser));
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

  /// Updates or inserts the current user in the database
  Future<void> updateCurrentUser(User user) async {
    // Update user data first
    await updateUser(user);

    // Set as current user
    await Store.instance.setCurrentUser(user.name!);

    // Update local state
    _currentUser = user;
  }

  Future<Either<SignUpFailure, User>> signUp({
    required String email,
    required String password,
  }) async {
    Logger.info('signUpWithEmailAndPassword - [$email, $password]');
    if (!ConnectivityUtil.instance.hasInternetConnection()) {
      return Left(SignUpFailure.noInternetConnection());
    }

    final userRes = await GrpcClient.instance.register(email, password);
    if (userRes.errCode == ErrCode.Success) {
      return Right(User(
          name: email, token: userRes.token, tokenUpdateTime: DateTime.now()));
    }
    return Left(SignUpFailure.unknownError('check user name or password'));
  }

  Future<Either<SignInFailure, User>> signIn({
    required String email,
    required String password,
  }) async {
    Logger.info('signInWithEmailAndPassword - [$email]');
    if (!ConnectivityUtil.instance.hasInternetConnection()) {
      return Left(SignInFailure.noInternetConnection());
    }

    try {
      final userRes = await GrpcClient.instance.login(email, password);
      if (userRes.errCode == ErrCode.Success) {
        final user = User(
          name: email,
          token: userRes.token,
          tokenUpdateTime: DateTime.now(),
        );

        // Store user data in database
        await UserManager.instance.updateUser(user);

        return Right(user);
      }
      return Left(SignInFailure.invalidUserPasswordCombination());
    } catch (e) {
      Logger.error('Sign in failed: $e');
      return Left(SignInFailure.unknownError());
    }
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

  Future<Either<SignUpFailure, User>> signUpWithEmailAndPassword(
      String name, String password) {
    try {
      GetIt.I<EmailValidator>().validate(name);
      GetIt.I<PasswordValidator>().validate(password);
    } on InvalidPasswordException catch (e) {
      return Future.value(
          Left(SignUpFailure.invalidUserPasswordCombination(e.message)));
    }
    return signUp(email: name, password: password);
  }

  Future<Either<ForgotPasswordFailure, bool>> submitForgotPasswordEmail(
      String forgotPasswordEmail) async {
    try {
      GetIt.I<EmailValidator>().validate(forgotPasswordEmail);

      if (!ConnectivityUtil.instance.hasInternetConnection()) {
        return Left(ForgotPasswordFailure.noInternetConnection());
      }
      return const Right(true);
    } catch (e) {
      return Left(ForgotPasswordFailure.unknownError());
    }
  }
}
