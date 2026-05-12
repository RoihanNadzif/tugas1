import 'package:flutter/material.dart';
import '../services/auth_services.dart';
import '../widgets/tombol_aksi.dart';
import '../widgets/input_teks.dart';

class HalamanMasuk extends StatefulWidget {
  const HalamanMasuk({super.key});

  @override
  State<HalamanMasuk> createState() => _HalamanMasukState();
}

class _HalamanMasukState extends State<HalamanMasuk> {
  final TextEditingController _inputNomorInduk = TextEditingController();
  final TextEditingController _inputKataSandi = TextEditingController();
  bool _sedangMemuat = false;
  bool _sembunyikanSandi = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.teal),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tugas PBM Produk',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Masuk dengan NIM',
                    style: TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 16),
                  InputTeks(
                    pengendali: _inputNomorInduk,
                    label: 'Username / NIM',
                    petunjuk: 'contoh: 23241010xxxx',
                  ),
                  const SizedBox(height: 12),
                  InputTeks(
                    pengendali: _inputKataSandi,
                    label: 'Password',
                    rahasiakan: _sembunyikanSandi,
                    aksiSufiks: IconButton(
                      icon: Icon(
                        _sembunyikanSandi
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _sembunyikanSandi = !_sembunyikanSandi;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  TombolAksi(
                    onTap: _prosesLogin,
                    judul: 'Login',
                    sedangMemuat: _sedangMemuat,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _prosesLogin() async {
    final nomorInduk = _inputNomorInduk.text.trim();
    final kataSandi = _inputKataSandi.text.trim();
    if (nomorInduk.isEmpty || kataSandi.isEmpty) {
      _tampilkanPesan('Nomor Induk dan Kata Sandi wajib diisi', galat: true);
      return;
    }
    setState(() {
      _sedangMemuat = true;
    });
    try {
      await AuthServices.masuk(nomorInduk, kataSandi);
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/katalog');
      }
    } catch (e) {
      _tampilkanPesan(
        'Gagal masuk. Periksa kembali NIM dan kata sandi Anda.',
        galat: true,
      );
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
            Icon(
              galat ? Icons.error_outline : Icons.check_circle_outline,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 10),
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

  @override
  void dispose() {
    _inputNomorInduk.dispose();
    _inputKataSandi.dispose();
    super.dispose();
  }
}
