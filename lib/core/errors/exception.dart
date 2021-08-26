class ServerException implements Exception {
  final String message;
  ServerException({
    required this.message,
  });
}

class FailException implements Exception {
  final String message;
  FailException({required this.message});
}

class CacheException implements Exception {
  final String message;
  CacheException({required this.message});
}
