// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class Localization {
  Localization();

  static Localization? _current;

  static Localization get current {
    assert(_current != null,
        'No instance of Localization was loaded. Try to initialize the Localization delegate before accessing Localization.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<Localization> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = Localization();
      Localization._current = instance;

      return instance;
    });
  }

  static Localization of(BuildContext context) {
    final instance = Localization.maybeOf(context);
    assert(instance != null,
        'No instance of Localization present in the widget tree. Did you add Localization.delegate in localizationsDelegates?');
    return instance!;
  }

  static Localization? maybeOf(BuildContext context) {
    return Localizations.of<Localization>(context, Localization);
  }

  /// `English`
  String get language {
    return Intl.message(
      'English',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get language_en {
    return Intl.message(
      'English',
      name: 'language_en',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about_app {
    return Intl.message(
      'About',
      name: 'about_app',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language_setting_title {
    return Intl.message(
      'Language',
      name: 'language_setting_title',
      desc: '',
      args: [],
    );
  }

  /// `主题`
  String get theme_setting_theme_title {
    return Intl.message(
      '主题',
      name: 'theme_setting_theme_title',
      desc: '',
      args: [],
    );
  }

  /// `Dark mode`
  String get theme_setting_dark_mode {
    return Intl.message(
      'Dark mode',
      name: 'theme_setting_dark_mode',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get theme_setting_dark_mode_dark {
    return Intl.message(
      'Dark',
      name: 'theme_setting_dark_mode_dark',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get theme_setting_dark_mode_light {
    return Intl.message(
      'Light',
      name: 'theme_setting_dark_mode_light',
      desc: '',
      args: [],
    );
  }

  /// `System`
  String get theme_setting_dark_mode_system {
    return Intl.message(
      'System',
      name: 'theme_setting_dark_mode_system',
      desc: '',
      args: [],
    );
  }

  /// `Primary color`
  String get theme_setting_primary_color_title {
    return Intl.message(
      'Primary color',
      name: 'theme_setting_primary_color_title',
      desc: '',
      args: [],
    );
  }

  /// `Use system color`
  String get theme_setting_system_primary_color_title {
    return Intl.message(
      'Use system color',
      name: 'theme_setting_system_primary_color_title',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get page_home_title {
    return Intl.message(
      'Home',
      name: 'page_home_title',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get page_setting_title {
    return Intl.message(
      'Setting',
      name: 'page_setting_title',
      desc: '',
      args: [],
    );
  }

  /// `Select Language`
  String get select_lang {
    return Intl.message(
      'Select Language',
      name: 'select_lang',
      desc: '',
      args: [],
    );
  }

  /// `No internet`
  String get error_no_internet {
    return Intl.message(
      'No internet',
      name: 'error_no_internet',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message(
      'Success',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get general_close {
    return Intl.message(
      'Close',
      name: 'general_close',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get log_in {
    return Intl.message(
      'Log In',
      name: 'log_in',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get log_out {
    return Intl.message(
      'Log out',
      name: 'log_out',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get sign_up {
    return Intl.message(
      'Sign Up',
      name: 'sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get already_have_account {
    return Intl.message(
      'Already have an account?',
      name: 'already_have_account',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get dont_have_account {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dont_have_account',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password`
  String get forgot_password {
    return Intl.message(
      'Forgot password',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get new_password {
    return Intl.message(
      'New Password',
      name: 'new_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm new password`
  String get confirm_new_password {
    return Intl.message(
      'Confirm new password',
      name: 'confirm_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get settings {
    return Intl.message(
      'Setting',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Enter new email`
  String get enter_new_email {
    return Intl.message(
      'Enter new email',
      name: 'enter_new_email',
      desc: '',
      args: [],
    );
  }

  /// `Enter Registered Email`
  String get enter_registered_email {
    return Intl.message(
      'Enter Registered Email',
      name: 'enter_registered_email',
      desc: '',
      args: [],
    );
  }

  /// `Enter current password`
  String get enter_current_password {
    return Intl.message(
      'Enter current password',
      name: 'enter_current_password',
      desc: '',
      args: [],
    );
  }

  /// `Reset password`
  String get reset_password {
    return Intl.message(
      'Reset password',
      name: 'reset_password',
      desc: '',
      args: [],
    );
  }

  /// `Enable fingerprint login`
  String get enable_fingerprint_login {
    return Intl.message(
      'Enable fingerprint login',
      name: 'enable_fingerprint_login',
      desc: '',
      args: [],
    );
  }

  /// `Fingerprint auth should be enabled in settings`
  String get fingerprint_auth_should_be_enabled {
    return Intl.message(
      'Fingerprint auth should be enabled in settings',
      name: 'fingerprint_auth_should_be_enabled',
      desc: '',
      args: [],
    );
  }

  /// `Fingerprint login failed`
  String get fingerprint_login_failed {
    return Intl.message(
      'Fingerprint login failed',
      name: 'fingerprint_login_failed',
      desc: '',
      args: [],
    );
  }

  /// `Too many wrong attempts, please login with password`
  String get too_many_wrong_attempts {
    return Intl.message(
      'Too many wrong attempts, please login with password',
      name: 'too_many_wrong_attempts',
      desc: '',
      args: [],
    );
  }

  /// `Email updated successfully, please login again`
  String get email_updated_success {
    return Intl.message(
      'Email updated successfully, please login again',
      name: 'email_updated_success',
      desc: '',
      args: [],
    );
  }

  /// `Password reset email sent`
  String get password_reset_mail_sent {
    return Intl.message(
      'Password reset email sent',
      name: 'password_reset_mail_sent',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect password`
  String get incorrect_password {
    return Intl.message(
      'Incorrect password',
      name: 'incorrect_password',
      desc: '',
      args: [],
    );
  }

  /// `Password verified`
  String get password_verified {
    return Intl.message(
      'Password verified',
      name: 'password_verified',
      desc: '',
      args: [],
    );
  }

  /// `Passwords don't match`
  String get password_not_match {
    return Intl.message(
      'Passwords don\'t match',
      name: 'password_not_match',
      desc: '',
      args: [],
    );
  }

  /// `Password reset successful`
  String get password_reset_success {
    return Intl.message(
      'Password reset successful',
      name: 'password_reset_success',
      desc: '',
      args: [],
    );
  }

  /// `Unexpected error`
  String get unexpected_error {
    return Intl.message(
      'Unexpected error',
      name: 'unexpected_error',
      desc: '',
      args: [],
    );
  }

  /// `Close the App?`
  String get close_app {
    return Intl.message(
      'Close the App?',
      name: 'close_app',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Finding local server`
  String get finding_server {
    return Intl.message(
      'Finding local server',
      name: 'finding_server',
      desc: '',
      args: [],
    );
  }

  /// `Setup server`
  String get setup_server {
    return Intl.message(
      'Setup server',
      name: 'setup_server',
      desc: '',
      args: [],
    );
  }

  /// `Local Server Found`
  String get local_server_found {
    return Intl.message(
      'Local Server Found',
      name: 'local_server_found',
      desc: '',
      args: [],
    );
  }

  /// `Use local server`
  String get use_local_server {
    return Intl.message(
      'Use local server',
      name: 'use_local_server',
      desc: '',
      args: [],
    );
  }

  /// `Backup`
  String get backup_title {
    return Intl.message(
      'Backup',
      name: 'backup_title',
      desc: '',
      args: [],
    );
  }

  /// `Backup Settings`
  String get backup_settings {
    return Intl.message(
      'Backup Settings',
      name: 'backup_settings',
      desc: '',
      args: [],
    );
  }

  /// `Automatic Backup`
  String get auto_backup {
    return Intl.message(
      'Automatic Backup',
      name: 'auto_backup',
      desc: '',
      args: [],
    );
  }

  /// `Automatically backup new photos and videos`
  String get auto_backup_desc {
    return Intl.message(
      'Automatically backup new photos and videos',
      name: 'auto_backup_desc',
      desc: '',
      args: [],
    );
  }

  /// `Background Backup`
  String get background_backup {
    return Intl.message(
      'Background Backup',
      name: 'background_backup',
      desc: '',
      args: [],
    );
  }

  /// `Continue backup when app is in background`
  String get background_backup_desc {
    return Intl.message(
      'Continue backup when app is in background',
      name: 'background_backup_desc',
      desc: '',
      args: [],
    );
  }

  /// `Storage Permission Required`
  String get permission_required {
    return Intl.message(
      'Storage Permission Required',
      name: 'permission_required',
      desc: '',
      args: [],
    );
  }

  /// `Grant Permission`
  String get grant_permission {
    return Intl.message(
      'Grant Permission',
      name: 'grant_permission',
      desc: '',
      args: [],
    );
  }

  /// `Permission limited. To let Immich backup and manage your entire gallery collection, grant photo and video permissions in Settings.`
  String get permission_onboarding_permission_limited {
    return Intl.message(
      'Permission limited. To let Immich backup and manage your entire gallery collection, grant photo and video permissions in Settings.',
      name: 'permission_onboarding_permission_limited',
      desc: '',
      args: [],
    );
  }

  /// `Go to settings`
  String get permission_onboarding_go_to_settings {
    return Intl.message(
      'Go to settings',
      name: 'permission_onboarding_go_to_settings',
      desc: '',
      args: [],
    );
  }

  /// `Continue anyway`
  String get permission_onboarding_continue_anyway {
    return Intl.message(
      'Continue anyway',
      name: 'permission_onboarding_continue_anyway',
      desc: '',
      args: [],
    );
  }

  /// `Permission denied. To use Immich, grant photo and video permissions in Settings.`
  String get permission_onboarding_permission_denied {
    return Intl.message(
      'Permission denied. To use Immich, grant photo and video permissions in Settings.',
      name: 'permission_onboarding_permission_denied',
      desc: '',
      args: [],
    );
  }

  /// `Choose backup albums`
  String get choose_backup_albums {
    return Intl.message(
      'Choose backup albums',
      name: 'choose_backup_albums',
      desc: '',
      args: [],
    );
  }

  /// `No albums selected`
  String get no_albums_selected {
    return Intl.message(
      'No albums selected',
      name: 'no_albums_selected',
      desc: '',
      args: [],
    );
  }

  /// `albums selected`
  String get albums_selected {
    return Intl.message(
      'albums selected',
      name: 'albums_selected',
      desc: '',
      args: [],
    );
  }

  /// `No albums found`
  String get no_albums_found {
    return Intl.message(
      'No albums found',
      name: 'no_albums_found',
      desc: '',
      args: [],
    );
  }

  /// `Select All`
  String get select_all {
    return Intl.message(
      'Select All',
      name: 'select_all',
      desc: '',
      args: [],
    );
  }

  /// `Deselect All`
  String get deselect_all {
    return Intl.message(
      'Deselect All',
      name: 'deselect_all',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<Localization> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<Localization> load(Locale locale) => Localization.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
