import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenVault {
  static const String _kunciToken = 'KUNCI_AKSES_SESI';
  static const _penyimpanan = FlutterSecureStorage();

  // Menyimpan token ke penyimpanan aman
  static Future<void> simpanToken(String token) async {
    try {
      await _penyimpanan.write(key: _kunciToken, value: token);
      print('Token tersimpan');
    } catch (kesalahan) {
      print('Gagal simpan token: $kesalahan');
    }
  }

  // Mengambil token dari penyimpanan aman
  static Future<String?> ambilToken() async {
    try {
      return await _penyimpanan.read(key: _kunciToken);
    } catch (kesalahan) {
      print('Gagal ambil token: $kesalahan');
      return null;
    }
  }

  // Menghapus token saat logout
  static Future<void> hapusToken() async {
    try {
      await _penyimpanan.delete(key: _kunciToken);
      print('Token dihapus');
    } catch (kesalahan) {
      print('Gagal hapus token: $kesalahan');
    }
  }

  // Memeriksa apakah token masih tersedia
  static Future<bool> adaToken() async {
    final token = await ambilToken();
    return token != null && token.isNotEmpty;
  }
}
