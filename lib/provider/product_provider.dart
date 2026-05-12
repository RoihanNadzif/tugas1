import 'dart:developer';
import 'package:flutter/foundation.dart';
import '../models/produk_detail_model.dart';
import '../services/produk_services.dart';

class ProductProvider with ChangeNotifier {
  bool _isLoading = false;
  List<ProdukDetail> _products = [];

  bool get isLoading => _isLoading;
  List<ProdukDetail> get products => _products;

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();
    try {
      _products = await ProdukServices.ambilSemuaProduk();
    } catch (e) {
      log('ProductProvider fetch error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createProduct({
    required String name,
    required int price,
    required String description,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      await ProdukServices.tambahProduk(name, price, description);
      await fetchProducts();
      return true;
    } catch (e) {
      log('ProductProvider create error: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
