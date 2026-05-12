import 'package:flutter/material.dart';
import '../services/produk_services.dart';
import '../services/token_vault.dart';
import '../models/produk_detail_model.dart';
import '../widgets/card_produk.dart';
import '../widgets/info_produk.dart';
import '../widgets/input_button.dart';
import 'page_submittugas.dart';

class HalamanLogin extends StatefulWidget {
  const HalamanLogin({super.key});

  @override
  State<HalamanLogin> createState() => _HalamanLoginState();
}

class _HalamanLoginState extends State<HalamanLogin> {
  List<ProdukDetail> _daftarProduk = [];
  bool _sedangMemuat = true;
  bool _tampilkanFormulir = false;
  String _namaSapaan = '';

  final TextEditingController _inputNamaProduk = TextEditingController();
  final TextEditingController _inputHargaProduk = TextEditingController();
  final TextEditingController _inputDeskripsiProduk = TextEditingController();

  @override
  void initState() {
    super.initState();
    _muatDaftarProduk();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Produk Inventaris',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            if (_namaSapaan.isNotEmpty)
              Text(
                'Selamat Datang Kembali Boss $_namaSapaan',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white70,
                  fontWeight: FontWeight.w400,
                ),
              ),
          ],
        ),
        backgroundColor: Color(0xFF1E293B),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: Colors.white),
            tooltip: 'Muat Ulang',
            onPressed: () {
              setState(() {
                _sedangMemuat = true;
              });
              _muatDaftarProduk();
            },
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app_rounded, color: Colors.white),
            tooltip: 'Keluar',
            onPressed: _prosesKeluar,
          ),
        ],
      ),
      body: _sedangMemuat
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${_daftarProduk.length} Produk',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.refresh_rounded,
                          color: Color(0xFF1E293B),
                        ),
                        tooltip: 'Muat Ulang',
                        onPressed: () {
                          setState(() {
                            _sedangMemuat = true;
                          });
                          _muatDaftarProduk();
                        },
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _tampilkanFormulir = !_tampilkanFormulir;
                          });
                        },
                        child: Text(
                          _tampilkanFormulir ? 'Tutup Form' : 'Tambah',
                        ),
                      ),
                    ],
                  ),
                ),
                if (_tampilkanFormulir)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        border: Border.all(color: Color(0xFF1E293B)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          InputButton(
                            pengendali: _inputNamaProduk,
                            label: 'Nama Produk',
                          ),
                          const SizedBox(height: 8),
                          InputButton(
                            pengendali: _inputHargaProduk,
                            label: 'Harga Produk',
                            tipeInput: TextInputType.number,
                          ),
                          const SizedBox(height: 8),
                          InputButton(
                            pengendali: _inputDeskripsiProduk,
                            label: 'Deskripsi',
                            barisMinimal: 2,
                            barisMaksimal: 3,
                          ),
                          const SizedBox(height: 12),
                          InfoProduk(
                            onTap: _prosesTambahProduk,
                            judul: 'Tambah',
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 8),
                Expanded(
                  child: _daftarProduk.isEmpty
                      ? const Center(child: Text('Belum ada data'))
                      : ListView.builder(
                          itemCount: _daftarProduk.length,
                          itemBuilder: (context, index) {
                            final produk = _daftarProduk[index];
                            return CardProduk(
                              produk: produk,
                              onLihat: () => _tampilkanDetailProduk(produk),
                            );
                          },
                        ),
                ),
              ],
            ),
      floatingActionButton: _daftarProduk.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const HalamanSubmit()),
                );
              },
              icon: const Icon(Icons.send_rounded),
              label: const Text(
                'Submit Tugasnya',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              backgroundColor: Color(0xFF1E293B),
              foregroundColor: Colors.white,
            )
          : null,
    );
  }

  Future<void> _muatDaftarProduk() async {
    try {
      // Mengambil nama untuk sapaan
      final namaLengkap = await TokenVault.ambilNama();
      if (namaLengkap != null && namaLengkap.isNotEmpty) {
        // Ambil 3 huruf pertama
        final potongan = namaLengkap.length > 3
            ? namaLengkap.substring(0, 3)
            : namaLengkap;
        setState(() {
          _namaSapaan = potongan;
        });
      }

      final data = await ProdukServices.ambilSemuaProduk();
      setState(() {
        _daftarProduk = data;
        _sedangMemuat = false;
      });
    } catch (e) {
      setState(() {
        _sedangMemuat = false;
      });
      _tampilkanPesan('Gagal refresh produk', galat: true);
    }
  }

  void _prosesTambahProduk() async {
    final nama = _inputNamaProduk.text.trim();
    final hargaStr = _inputHargaProduk.text.trim();
    final deskripsi = _inputDeskripsiProduk.text.trim();
    if (nama.isEmpty || hargaStr.isEmpty || deskripsi.isEmpty) {
      _tampilkanPesan('Semua kolom wajib diisi', galat: true);
      return;
    }
    final harga = int.tryParse(hargaStr);
    if (harga == null) {
      _tampilkanPesan('Harga harus diisi angka', galat: true);
      return;
    }
    try {
      setState(() {
        _sedangMemuat = true;
      });
      await ProdukServices.tambahProduk(nama, harga, deskripsi);
      _tampilkanPesan('Produk berhasil ditambahkan');
      _inputNamaProduk.clear();
      _inputHargaProduk.clear();
      _inputDeskripsiProduk.clear();
      setState(() {
        _tampilkanFormulir = false;
      });
      await _muatDaftarProduk();
    } catch (e) {
      _tampilkanPesan('Gagal menambahkan produk: $e', galat: true);
      setState(() {
        _sedangMemuat = false;
      });
    }
  }

  void _tampilkanDetailProduk(ProdukDetail produk) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          produk.namaProduk,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _barisDetail('Harga', '${produk.hargaProduk}'),
            _barisDetail('Keterangan', produk.keteranganProduk),
            _barisDetail('Dibuat', produk.tanggalDibuat),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  Widget _barisDetail(String label, String nilai) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.teal,
            ),
          ),
          const SizedBox(height: 2),
          Text(nilai, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }

  void _prosesKeluar() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Konfirmasi Keluar',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Anda akan keluar dari aplikasi.',
          style: TextStyle(fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await TokenVault.hapusToken();
              if (mounted) Navigator.of(context).pushReplacementNamed('/masuk');
            },
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
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
    _inputNamaProduk.dispose();
    _inputHargaProduk.dispose();
    _inputDeskripsiProduk.dispose();
    super.dispose();
  }
}
