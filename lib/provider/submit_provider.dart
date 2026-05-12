import 'dart:developer';
import 'package:flutter/foundation.dart';
import '../models/produk_detail_model.dart';
import '../services/produk_services.dart';
import '../services/token_vault.dart';

class SubmitProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> submit({
    required ProdukDetail produk,
    required String githubUrl,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      final token = await TokenVault.ambilToken();
      if (token == null) throw Exception('Token tidak ditemukan');

      await ProdukServices.submitTugas(
        token,
        produk.namaProduk,
        produk.keteranganProduk,
        produk.hargaProduk,
        githubUrl,
      );
      return true;
    } catch (e) {
      log('SubmitProvider submit error: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
