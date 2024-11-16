import 'package:equatable/equatable.dart';

abstract class AppException extends Equatable implements Exception {
  const AppException({required this.message, required this.code});

  final String message;
  final int code;

  @override
  List<Object?> get props => [code, message];

  @override
  String toString() {
    return 'Exception $code: $message';
  }
}
