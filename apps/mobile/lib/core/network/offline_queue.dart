import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class OfflineQueue {
  final SharedPreferences _prefs;
  final Dio _dio;
  static const String _queueKey = 'darb_offline_queue';

  OfflineQueue(this._prefs, this._dio);

  Future<void> enqueueRequest(String url, String method, Map<String, dynamic> data) async {
    final queue = _prefs.getStringList(_queueKey) ?? [];
    queue.add(jsonEncode({
      'url': url,
      'method': method,
      'data': data,
      'timestamp': DateTime.now().toIso8601String(),
    }));
    await _prefs.setStringList(_queueKey, queue);
  }

  Future<void> syncQueue() async {
    final queue = _prefs.getStringList(_queueKey);
    if (queue == null || queue.isEmpty) return;

    List<String> failedRequests = [];

    for (String item in queue) {
      try {
        final request = jsonDecode(item);
        if (request['method'] == 'POST') {
          await _dio.post(request['url'], data: request['data']);
        }
      } catch (e) {
        // Keep failed requests to retry later
        failedRequests.add(item);
      }
    }

    await _prefs.setStringList(_queueKey, failedRequests);
  }
}
