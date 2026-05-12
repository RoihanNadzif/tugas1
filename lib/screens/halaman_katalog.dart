import 'package:flutter/material.dart';
import '../services/produk_services.dart';
import '../services/token_vault.dart';
import '../models/barang_dagangan_model.dart';
import '../widgets/kartu_barang.dart';
import '../widgets/tombol_aksi.dart';
import '../widgets/input_teks.dart';
import 'halaman_kirim_tugas.dart';

class HalamanKatalog extends StatefulWidget {
  const HalamanKatalog({super.key});

  @override
  State<HalamanKatalog> createState() => _HalamanKatalogState();
}

class _HalamanKatalogState extends State<HalamanKatalog> {
  List<BarangDagangan> _daftarBarang = [];
  bool _sedangMemuat = true;
  bool _tampilkanFormulir = false;

  final TextEditingController _inputNamaBarang = TextEditingController();
  final TextEditingController _inputHargaBarang = TextEditingController();
  final TextEditingController _inputDeskripsiBarang = TextEditingController();

  @override
  void initState() {
    super.initState();
    _muatDaftarBarang();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Katalog Inventaris', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
        backgroundColor: Colors.teal,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(icon: const Icon(Icons.exit_to_app_rounded, color: Colors.white), tooltip: 'Keluar', onPressed: _prosesKeluar),
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
                          '${_daftarBarang.length} Produk',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _tampilkanFormulir = !_tampilkanFormulir;
                          });
                        },
                        child: Text(_tampilkanFormulir ? 'Tutup Form' : 'Tambah'),
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
                        color: Colors.white,
                        border: Border.all(color: Colors.teal),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          InputTeks(
                            pengendali: _inputNamaBarang,
                            label: 'Nama Produk',
                          ),
                          const SizedBox(height: 8),
                          InputTeks(
                            pengendali: _inputHargaBarang,
                            label: 'Harga',
                            tipeInput: TextInputType.number,
                          ),
                          const SizedBox(height: 8),
                          InputTeks(
                            pengendali: _inputDeskripsiBarang,
                            label: 'Deskripsi',
                            barisMinimal: 2,
                            barisMaksimal: 3,
                          ),
                          const SizedBox(height: 12),
                          TombolAksi(
                            onTap: _prosesTambahBarang,
                            judul: 'Simpan',
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 8),
                Expanded(
                  child: _daftarBarang.isEmpty
                      ? const Center(child: Text('Belum ada data'))
                      : ListView.builder(
                          itemCount: _daftarBarang.length,
                          itemBuilder: (context, index) {
                            final barang = _daftarBarang[index];
                            return KartuBarang(
                              barang: barang,
                              onLihat: () => _tampilkanDetailBarang(barang),
                            );
                          },
                        ),
                ),
              ],
            ),
      floatingActionButton: _daftarBarang.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => HalamanKirimTugas(daftarBarang: _daftarBarang)));
              },
              icon: const Icon(Icons.send_rounded),
              label: const Text('Kirim Tugas', style: TextStyle(fontWeight: FontWeight.w600)),
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            )
          : null,
    );
  }

  void _muatDaftarBarang() async {
    try {
      final data = await ProdukServices.ambilSemuaBarang();
      setState(() {
        _daftarBarang = data;
        _sedangMemuat = false;
      });
    } catch (e) {
      setState(() { _sedangMemuat = false; });
      _tampilkanPesan('Gagal memuat daftar barang', galat: true);
    }
  }

  void _prosesTambahBarang() async {
    final nama = _inputNamaBarang.text.trim();
    final hargaStr = _inputHargaBarang.text.trim();
    final deskripsi = _inputDeskripsiBarang.text.trim();
    if (nama.isEmpty || hargaStr.isEmpty || deskripsi.isEmpty) {
      _tampilkanPesan('Semua kolom wajib diisi', galat: true); return;
    }
    final harga = int.tryParse(hargaStr);
    if (harga == null) { _tampilkanPesan('Harga harus berupa angka', galat: true); return; }
    try {
      await ProdukServices.tambahBarang(nama, harga, deskripsi);
      _tampilkanPesan('Barang berhasil ditambahkan');
      _inputNamaBarang.clear(); _inputHargaBarang.clear(); _inputDeskripsiBarang.clear();
      setState(() { _tampilkanFormulir = false; });
      _muatDaftarBarang();
    } catch (e) { _tampilkanPesan('Gagal menambahkan barang', galat: true); }
  }

  void _tampilkanDetailBarang(BarangDagangan barang) {
    showDialog(context: context, builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(barang.namaBarang, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      content: Column(
        mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _barisDetail('Harga', '${barang.hargaBarang}'),
          _barisDetail('Keterangan', barang.keteranganBarang),
          _barisDetail('Dibuat', barang.tanggalDibuat),
        ],
      ),
      actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Tutup'))],
    ));
  }

  Widget _barisDetail(String label, String nilai) {
    return Padding(padding: const EdgeInsets.only(bottom: 8), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.teal)),
      const SizedBox(height: 2),
      Text(nilai, style: const TextStyle(fontSize: 13)),
    ]));
  }

  void _prosesKeluar() {
    showDialog(context: context, builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text('Konfirmasi Keluar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      content: const Text('Anda akan keluar dari aplikasi.', style: TextStyle(fontSize: 13)),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Batal')),
        TextButton(onPressed: () async {
          Navigator.pop(ctx);
          await TokenVault.hapusToken();
          if (mounted) Navigator.of(context).pushReplacementNamed('/masuk');
        }, child: const Text('Keluar')),
      ],
    ));
  }

  void _tampilkanPesan(String pesan, {bool galat = false}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(children: [
        Icon(galat ? Icons.error_outline : Icons.check_circle_outline, color: Colors.white, size: 20),
        const SizedBox(width: 10),
        Expanded(child: Text(pesan, style: const TextStyle(fontSize: 13))),
      ]),
      backgroundColor: galat ? Colors.red : Colors.green,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(16),
    ));
  }

  @override
  void dispose() { _inputNamaBarang.dispose(); _inputHargaBarang.dispose(); _inputDeskripsiBarang.dispose(); super.dispose(); }
}
