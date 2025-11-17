import 'package:flutter/material.dart';
import '../models/emergency.dart';
import '../services/emergency_service.dart';
import '../services/notification_service.dart';

class EmergencyProvider extends ChangeNotifier {
  final List<Emergency> _items = [];
  bool _sending = false;

  List<Emergency> get items => List.unmodifiable(_items);
  bool get sending => _sending;

  final EmergencyService service;
  final NotificationService notifier;

  EmergencyProvider({required this.service, required this.notifier});

  Future<bool> send(Emergency e) async {
    _sending = true;
    notifyListeners();
    bool success = await service.sendEmergency(e);
    if (success) {
      _items.insert(0, e);
      notifier.notify('Nueva emergencia enviada: ${e.type}');
    }
    _sending = false;
    notifyListeners();
    return success;
  }
}
