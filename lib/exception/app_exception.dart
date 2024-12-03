abstract class AppException implements Exception {
  final String message;
  final int code;

  const AppException({required this.message, required this.code});
}
