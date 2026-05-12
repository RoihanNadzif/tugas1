import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/konfigurasi_app.dart';
import '../models/produk_detail_model.dart';
import 'token_vault.dart';

class ProdukServices {
  static const String _json = 'application/json';
  static const String _endpointProduk = '/api/products';
  static const String _endpointSubmit = '/api/products/submit';

  static Future<String> _ambilTokenWajib() async {
    final token = await TokenVault.ambilToken();
    if (token == null) {
      throw Exception('Token tidak tersedia. Silakan masuk terlebih dahulu.');
    }
    return token;
  }

  static Future<List<ProdukDetail>> ambilSemuaProduk() async {
    try {
      final token = await _ambilTokenWajib();
      final alamat = Uri.parse('${KonfigurasiApp.baseUrl}$_endpointProduk');

      print('Ambil produk...');

      final tanggapan = await http.get(
        alamat,
        headers: {
          'Content-Type': _json,
          'Accept': _json,
          'Authorization': 'Bearer $token',
        },
      );

      print('Status: ${tanggapan.statusCode}');

      if (tanggapan.statusCode == 200) {
        final data = jsonDecode(tanggapan.body);
        final daftarProduk = (data['data']['products'] as List)
            .map((item) => ProdukDetail.dariJson(item))
            .toList();
        print('Berhasil memuat ${daftarProduk.length} produk');
        return daftarProduk;
      }

      throw Exception(
        'Gagal memuat daftar produk: Status ${tanggapan.statusCode}',
      );
    } catch (kesalahan) {
      print('Gagal ambil produk: $kesalahan');
      rethrow;
    }
  }

  static Future<ProdukDetail> tambahProduk(
    String nama,
    int harga,
    String keterangan,
  ) async {
    try {
      final token = await _ambilTokenWajib();
      final alamat = Uri.parse('${KonfigurasiApp.baseUrl}$_endpointProduk');

      print('Tambah produk...');

      final tanggapan = await http.post(
        alamat,
        headers: {
          'Content-Type': _json,
          'Accept': _json,
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'name': nama,
          'price': harga,
          'description': keterangan,
        }),
      );

      print('Status: ${tanggapan.statusCode}');
      print('Respon: ${tanggapan.body}');

      if (tanggapan.statusCode == 201 || tanggapan.statusCode == 200) {
        final data = jsonDecode(tanggapan.body);
        return ProdukDetail.dariJson(data['data']);
      }

      throw Exception('Gagal menambahkan produk: ${tanggapan.body}');
    } catch (kesalahan) {
      print('Gagal tambah produk: $kesalahan');
      rethrow;
    }
  }

  static Future<void> submitTugas(
    String token,
    String name,
    String description,
    int price,
    String githubUrl,
  ) async {
    try {
      final alamat = Uri.parse('${KonfigurasiApp.baseUrl}$_endpointSubmit');

      print('Mengirim tugas...');

      final tanggapan = await http.post(
        alamat,
        headers: {
          'Content-Type': _json,
          'Accept': _json,
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'name': name,
          'description': description,
          'price': price,
          'github_url': githubUrl,
        }),
      );

      print('Status: ${tanggapan.statusCode}');

      if (tanggapan.statusCode == 200 || tanggapan.statusCode == 201) {
        print('Tugas berhasil dikirim!');
        return;
      }

      print('Gagal mengirim tugas: ${tanggapan.body}');
      throw Exception('Gagal mengirim tugas: ${tanggapan.body}');
    } catch (kesalahan) {
      print('Error kirim tugas: $kesalahan');
      rethrow;
    }
  }
}
