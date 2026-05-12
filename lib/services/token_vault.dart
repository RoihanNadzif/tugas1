import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenVault {
  static const String _kunciToken = 'KUNCI_AKSES_SESI';
  static const String _kunciNama = 'NAMA_PENGGUNA';
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

  // Menyimpan nama ke penyimpanan aman
  static Future<void> simpanNama(String nama) async {
    try {
      await _penyimpanan.write(key: _kunciNama, value: nama);
    } catch (kesalahan) {
      print('Gagal simpan nama: $kesalahan');
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

  // Mengambil nama dari penyimpanan aman
  static Future<String?> ambilNama() async {
    try {
      return await _penyimpanan.read(key: _kunciNama);
    } catch (kesalahan) {
      print('Gagal ambil nama: $kesalahan');
      return null;
    }
  }

  // Menghapus token saat logout
  static Future<void> hapusToken() async {
    try {
      await _penyimpanan.delete(key: _kunciToken);
      await _penyimpanan.delete(key: _kunciNama);
      print('Sesi dihapus');
    } catch (kesalahan) {
      print('Gagal hapus sesi: $kesalahan');
    }
  }

  // Memeriksa apakah token masih tersedia
  static Future<bool> adaToken() async {
    final token = await ambilToken();
    return token != null && token.isNotEmpty;
  }
}
