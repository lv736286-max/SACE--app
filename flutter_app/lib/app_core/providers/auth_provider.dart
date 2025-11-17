import 'package:flutter/material.dart';
import '../models/user.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? _user;
  bool _loading = false;

  UserModel? get user => _user;
  bool get loading => _loading;

  Future<bool> login(String email, String password) async {
    _loading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1)); // simular llamada
    // En una app real, aquí consumirías un service de autenticación
    _user = UserModel(id: '1', name: 'Demo User', email: email, role: 'Docente');
    _loading = false;
    notifyListeners();
    return true;
  }

  Future<bool> register(String name, String email, String password, String role) async {
    _loading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    _user = UserModel(id: '2', name: name, email: email, role: role);
    _loading = false;
    notifyListeners();
    return true;
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
