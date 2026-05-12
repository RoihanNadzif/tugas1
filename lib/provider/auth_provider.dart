import 'dart:developer';
import 'package:flutter/foundation.dart';
import '../services/auth_services.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> login(String nim, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      await AuthServices.masuk(nim, password);
      return true;
    } catch (e) {
      log('AuthProvider login error: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
