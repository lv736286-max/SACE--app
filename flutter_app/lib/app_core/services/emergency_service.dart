import '../models/emergency.dart';
import 'api_service.dart';

class EmergencyService {
  final ApiService api;
  EmergencyService(this.api);

  /// Envía una emergencia al servidor (endpoint simulado)
  Future<bool> sendEmergency(Emergency e) async {
    try {
      final res = await api.post('/emergencies', e.toJson());
      return res.statusCode == 200 || res.statusCode == 201;
    } catch (err) {
      // manejar errors adecuadamente
      return false;
    }
  }
}
