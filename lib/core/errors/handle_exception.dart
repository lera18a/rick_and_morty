class HandleException implements Exception {
  final String message;
  final int? statusCode;

  const HandleException({this.statusCode, required this.message});

  const HandleException.serverError({this.statusCode})
    : message = 'Server error $statusCode';
  const HandleException.cacheError({this.statusCode})
    : message = 'Cache error: $statusCode';
  const HandleException.networkError({this.statusCode})
    : message = 'Network error: $statusCode';
}
