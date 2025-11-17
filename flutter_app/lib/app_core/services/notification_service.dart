import 'dart:async';

class NotificationService {
  // Simula notificaciones internas dentro de la app
  final StreamController<String> _controller = StreamController.broadcast();

  Stream<String> get onNotification => _controller.stream;

  void notify(String message) {
    _controller.add(message);
  }

  void dispose() {
    _controller.close();
  }
}
