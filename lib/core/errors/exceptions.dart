class DatabasesException implements Exception {
  final String message;

  DatabasesException(this.message);

  @override
  String toString() => 'DatabasesException: $message';
}

class NotFoundException implements Exception {
  final String message;

  NotFoundException(this.message);

  @override
  String toString() => 'NotFoundException: $message';
}
