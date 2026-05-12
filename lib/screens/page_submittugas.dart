import 'package:flutter/material.dart';
import '../services/produk_services.dart';
import '../services/token_vault.dart';
import '../widgets/info_produk.dart';

class HalamanSubmit extends StatefulWidget {
  const HalamanSubmit({super.key});

  @override
  State<HalamanSubmit> createState() => _HalamanSubmitState();
}

class _HalamanSubmitState extends State<HalamanSubmit> {
  final TextEditingController _inputNamaProduk = TextEditingController();
  final TextEditingController _inputHargaProduk = TextEditingController();
  final TextEditingController _inputDeskripsiProduk = TextEditingController();
  final TextEditingController _inputUrlGithub = TextEditingController();
  bool _sedangMemuat = false;
  bool _sudahTerkirim = false;

  @override
  void dispose() {
    _inputNamaProduk.dispose();
    _inputHargaProduk.dispose();
    _inputDeskripsiProduk.dispose();
    _inputUrlGithub.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text(
          'SubmitTugasnya',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF1E293B),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _sudahTerkirim
          ? _tampilanSukses()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      border: Border.all(color: Colors.orange, width: 1.5),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Catatan menghindari spamming',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '1. Cek kembali semua data sebelum di submit\n'
                          '2. Cek kembali link githubnya\n'
                          '3. Cek kembali logika aplikasi sebelum di submit\n'
                          '4. Kembali ke nomer 1',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF111827),
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    'Data Produk',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 10),

                  const Text(
                    'Nama Produk',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _inputNamaProduk,
                    style: const TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Masukkan nama produk',
                      hintStyle: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFFCBD5E1),
                      ),
                      filled: true,
                      fillColor: Color(0xFFFFFFFF),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFF1E293B),
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  const Text(
                    'Harga Produk',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _inputHargaProduk,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Masukkan harga produk',
                      hintStyle: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFFCBD5E1),
                      ),
                      filled: true,
                      fillColor: Color(0xFFFFFFFF),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFF1E293B),
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  const Text(
                    'Deskripsi Produk',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _inputDeskripsiProduk,
                    maxLines: 3,
                    style: const TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Masukkan deskripsi produk',
                      hintStyle: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFFCBD5E1),
                      ),
                      filled: true,
                      fillColor: Color(0xFFFFFFFF),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFF1E293B),
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Input GitHub URL
                  const Text(
                    'URL Repository GitHub',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _inputUrlGithub,
                    style: const TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'https://github.com/username/repo',
                      hintStyle: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFFCBD5E1),
                      ),
                      filled: true,
                      fillColor: Color(0xFFFFFFFF),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFF1E293B),
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 28),

                  // Tombol kirim
                  InfoProduk(
                    onTap: _prosesKirim,
                    judul: 'SubmitTugas',
                    warnaLatar: Color(0xFF1E293B),
                    sedangMemuat: _sedangMemuat,
                    tinggi: 54,
                  ),
                  const SizedBox(height: 12),
                  InfoProduk(
                    onTap: () => Navigator.pop(context),
                    judul: 'Kembali',
                    warnaLatar: Color(0xFFF1F5F9),
                    warnaTeks: Color(0xFF1E293B),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _tampilanSukses() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFF0FDF4),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Tugas Berhasil Disubmit!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF10B981),
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'Submit Tugas Tercatat oleh Sistem.\nWaktu submit telah direkam.\nTerima kasih!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF9CA3AF),
                height: 1.6,
              ),
            ),
            const SizedBox(height: 32),
            InfoProduk(
              onTap: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              judul: 'Kembali ke Beranda',
            ),
          ],
        ),
      ),
    );
  }

  void _prosesKirim() async {
    final nama = _inputNamaProduk.text.trim();
    final harga = _inputHargaProduk.text.trim();
    final deskripsi = _inputDeskripsiProduk.text.trim();
    final urlGithub = _inputUrlGithub.text.trim();

    if (nama.isEmpty) {
      _tampilkanPesan('Silakan masukkan nama produk', galat: true);
      return;
    }
    if (harga.isEmpty) {
      _tampilkanPesan('Silakan masukkan harga produk', galat: true);
      return;
    }
    if (deskripsi.isEmpty) {
      _tampilkanPesan('Silakan masukkan deskripsi produk', galat: true);
      return;
    }
    if (urlGithub.isEmpty) {
      _tampilkanPesan('Silakan masukkan URL GitHub', galat: true);
      return;
    }
    if (!urlGithub.startsWith('https://github.com/')) {
      _tampilkanPesan('Format URL GitHub tidak valid', galat: true);
      return;
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Konfirmasi Submit Tugas',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Apakah Anda yakin? Cek peringatan sebelum submit tugas',
          style: TextStyle(fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _eksekusiKirim(nama, deskripsi, int.parse(harga), urlGithub);
            },
            child: const Text(
              'Submit Tugas',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  void _eksekusiKirim(String nama, String deskripsi, int harga, String urlGithub) async {
    setState(() {
      _sedangMemuat = true;
    });
    try {
      final token = await TokenVault.ambilToken();
      if (token == null) throw Exception('Token tidak ditemukan');

      await ProdukServices.submitTugas(token, nama, deskripsi, harga, urlGithub);
      setState(() {
        _sudahTerkirim = true;
      });
    } catch (e) {
      _tampilkanPesan('Submit gagal: $e', galat: true);
    } finally {
      if (mounted) {
        setState(() {
          _sedangMemuat = false;
        });
      }
    }
  }

  void _tampilkanPesan(String pesan, {bool galat = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Expanded(child: Text(pesan, style: const TextStyle(fontSize: 13))),
          ],
        ),
        backgroundColor: galat ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}
