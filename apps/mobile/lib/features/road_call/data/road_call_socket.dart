import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

class RoadCallSocket {
  final String _url = 'ws://localhost:3000/road-call'; // Change to dev/prod URL
  WebSocketChannel? _channel;

  void connect() {
    _channel = WebSocketChannel.connect(Uri.parse(_url));
    _channel!.stream.listen(
      (message) {
        // Handle incoming messages (e.g. driverCountUpdated)
        print('Road Call Message: $message');
      },
      onError: (error) => print('Road Call Socket Error: $error'),
      onDone: () => print('Road Call Socket Closed'),
    );
  }

  void joinSegment(String segmentId) {
    if (_channel != null) {
      final payload = jsonEncode({
        'event': 'joinRoadSegment',
        'data': {'segmentId': segmentId}
      });
      _channel!.sink.add(payload);
    }
  }

  void askQuestion(String segmentId, String question) {
    if (_channel != null) {
      final payload = jsonEncode({
        'event': 'askQuestion',
        'data': {'segmentId': segmentId, 'question': question}
      });
      _channel!.sink.add(payload);
    }
  }

  void answerQuestion(String segmentId, String questionId, String answer) {
    if (_channel != null) {
      final payload = jsonEncode({
        'event': 'answerQuestion',
        'data': {
          'segmentId': segmentId,
          'questionId': questionId,
          'answer': answer
        }
      });
      _channel!.sink.add(payload);
    }
  }

  void disconnect() {
    _channel?.sink.close();
  }
}
