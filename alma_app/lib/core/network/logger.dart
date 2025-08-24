import 'dart:developer' as developer;

class Logger {
  static void logRequest({
    required String method,
    required String url,
    Map<String, String>? headers,
    Object? body,
  }) {
    developer.log(
      '''
🌐 REQUEST ➡️
📍 URL: $url
📝 Method: $method
🔑 Headers: $headers
📦 Body: $body
''',
      name: 'HTTP_CLIENT',
    );
  }

  static void logResponse({
    required int statusCode,
    required String body,
    required Duration duration,
  }) {
    developer.log(
      '''
🌐 RESPONSE ⬅️
📊 Status Code: $statusCode
⏱️ Duration: ${duration.inMilliseconds}ms
📦 Body: $body
''',
      name: 'HTTP_CLIENT',
    );
  }

  static void logError(Object error) {
    developer.log(
      '''
❌ ERROR
📝 Message: $error
''',
      name: 'HTTP_CLIENT',
      level: 1000,
    );
  }
}

extension LoggerExtension on Logger {
  static void logRetry({
    required int attempt,
    required int maxRetries,
    required String url,
    required dynamic error,
  }) {
    developer.log(
      '''
🔄 RETRY
🔢 Attempt: $attempt/$maxRetries
📍 URL: $url
❌ Error: $error
''',
      name: 'HTTP_CLIENT',
      level: 800, // Warning level, consistent with developer.log
    );
  }
}
