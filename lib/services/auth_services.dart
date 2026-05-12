import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/konfigurasi_app.dart';
import '../models/hasil_autentikasi_model.dart';
import 'token_vault.dart';

class AuthServices {
  static const String _json = 'application/json';
  static const String _endpointMasuk = '/api/auth/login';

  static Future<HasilAutentikasi> masuk(String nomorInduk, String kataSandi) async {
    try {
      final alamat = Uri.parse('${KonfigurasiApp.baseUrl}$_endpointMasuk');

      print('Login ke: $alamat');

      final tanggapan = await http.post(
        alamat,
        headers: {
          'Content-Type': _json,
          'Accept': _json,
        },
        body: jsonEncode({
          'username': nomorInduk,
          'password': kataSandi,
        }),
      );

      print('Status: ${tanggapan.statusCode}');
      print('Respon: ${tanggapan.body}');

      if (tanggapan.statusCode == 200) {
        final data = jsonDecode(tanggapan.body);
        final hasilLogin = HasilAutentikasi.dariJson(data);
        await TokenVault.simpanToken(hasilLogin.tokenAkses);
        print('Login Berhasil!');
        return hasilLogin;
      }

      throw Exception('Autentikasi gagal: ${tanggapan.body}');
    } catch (kesalahan) {
      print('Login Error: $kesalahan');
      rethrow;
    }
  }
}
