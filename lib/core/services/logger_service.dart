import 'package:flutter/foundation.dart';

class LoggerService {
  void info(String message, {Map<String, dynamic>? data}) {
    final dataStr = data != null ? ' | data: $data' : '';
    debugPrint('[EF][INFO] $message$dataStr');
  }

  void warn(String message, {Map<String, dynamic>? data}) {
    final dataStr = data != null ? ' | data: $data' : '';
    debugPrint('[EF][WARN] $message$dataStr');
  }

  void error(String message, {Object? error, StackTrace? stackTrace}) {
    debugPrint('[EF][ERROR] $message | error: $error');
    if (stackTrace != null) {
      debugPrint('[EF][STACK] $stackTrace');
    }
  }

  void firestore(String operation, String collection,
      {String? docId, Map<String, dynamic>? data, Object? error}) {
    final docStr = docId != null ? '/$docId' : '';
    final dataStr = data != null ? ' | data: $data' : '';
    final errStr = error != null ? ' | error: $error' : '';
    debugPrint(
        '[EF][FIRESTORE] $operation $collection$docStr$dataStr$errStr');
  }
}
