import 'package:flutter/material.dart';
import '../services/auth_services.dart';
import '../widgets/info_produk.dart';
import '../widgets/input_button.dart';

class CekLogin extends StatefulWidget {
  const CekLogin({super.key});

  @override
  State<CekLogin> createState() => _CekLoginState();
}

class _CekLoginState extends State<CekLogin> {
  final TextEditingController _inputNomorInduk = TextEditingController();
  final TextEditingController _inputKataSandi = TextEditingController();
  bool _sedangMemuat = false;
  bool _sembunyikanSandi = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFF1E293B)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tugas Produk PBM Roihan Nadzif',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Masukkan NIM dan Password untuk masuk',
                    style: TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 16),
                  InputButton(
                    pengendali: _inputNomorInduk,
                    label: 'NIM',
                    petunjuk: 'Masukkan NIM Anda',
                  ),
                  const SizedBox(height: 12),
                  InputButton(
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
                  InfoProduk(
                    onTap: _prosesLogin,
                    judul: 'Masuk',
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
      _tampilkanPesan('NIM dan Kata Sandi wajib diisi', galat: true);
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
        'Error.Cek NIM dan Password sebelum klik Masuk.',
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
        backgroundColor: galat ? Color(0xFFEF4444) : Color(0xFF10B981),
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
