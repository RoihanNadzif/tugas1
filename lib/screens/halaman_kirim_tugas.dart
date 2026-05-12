import 'package:flutter/material.dart';
import '../models/barang_dagangan_model.dart';
import '../services/produk_services.dart';
import '../services/token_vault.dart';
import '../widgets/tombol_aksi.dart';

class HalamanKirimTugas extends StatefulWidget {
  final List<BarangDagangan> daftarBarang;

  const HalamanKirimTugas({super.key, required this.daftarBarang});

  @override
  State<HalamanKirimTugas> createState() => _HalamanKirimTugasState();
}

class _HalamanKirimTugasState extends State<HalamanKirimTugas> {
  BarangDagangan? _barangTerpilih;
  final TextEditingController _inputUrlGithub = TextEditingController();
  bool _sedangMemuat = false;
  bool _sudahTerkirim = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Kirim Tugas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
        backgroundColor: Colors.teal,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _sudahTerkirim ? _tampilanSukses() : SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Peringatan penting
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
                  Row(children: [
                    const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 22),
                    const SizedBox(width: 8),
                    const Text('PERINGATAN PENTING', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.orange)),
                  ]),
                  const SizedBox(height: 10),
                  Text(
                    '• Pengiriman HANYA BISA dilakukan SATU KALI\n'
                    '• Data tidak dapat diubah setelah terkirim\n'
                    '• Pastikan semua informasi BENAR\n'
                    '• Waktu pengiriman tercatat HINGGA DETIK',
                    style: const TextStyle(fontSize: 12, color: Colors.black87, height: 1.6),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Pilih barang
            const Text('Pilih Barang untuk Dikirim', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.teal.shade200),
              ),
              child: DropdownButton<BarangDagangan>(
                isExpanded: true,
                underline: const SizedBox(),
                hint: const Text('Pilih barang...', style: TextStyle(fontSize: 13, color: Colors.black54)),
                value: _barangTerpilih,
                items: widget.daftarBarang.map((b) => DropdownMenuItem<BarangDagangan>(
                  value: b,
                  child: Text(b.namaBarang, style: const TextStyle(fontSize: 14)),
                )).toList(),
                onChanged: (val) { setState(() { _barangTerpilih = val; }); },
              ),
            ),
            const SizedBox(height: 20),

            // Detail barang terpilih
            if (_barangTerpilih != null) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.teal.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Detail Barang Terpilih:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.teal)),
                    const SizedBox(height: 12),
                    _barisInfo('Nama', _barangTerpilih!.namaBarang),
                    _barisInfo('Harga', '${_barangTerpilih!.hargaBarang}'),
                    _barisInfo('Keterangan', _barangTerpilih!.keteranganBarang),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],

            // Input GitHub URL
            const Text('URL Repository GitHub', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
            const SizedBox(height: 10),
            TextField(
              controller: _inputUrlGithub,
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                hintText: 'https://github.com/username/repo',
                hintStyle: const TextStyle(fontSize: 13, color: Colors.black45),
                prefixIcon: const Icon(Icons.link_rounded, color: Colors.teal),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.teal.shade200)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.teal, width: 1.5)),
              ),
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 28),

            // Tombol kirim
            TombolAksi(
              onTap: _prosesKirim,
              judul: 'Kirim Tugas Akhir',
              ikon: Icons.send_rounded,
              warnaLatar: Colors.green,
              sedangMemuat: _sedangMemuat,
              tinggi: 54,
            ),
            const SizedBox(height: 12),
            TombolAksi(
              onTap: () => Navigator.pop(context),
              judul: 'Kembali',
              ikon: Icons.arrow_back_rounded,
              warnaLatar: Colors.teal.shade50,
              warnaTeks: Colors.teal,
            ),
          ],
        ),
      ),
    );
  }

  Widget _barisInfo(String label, String nilai) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          width: 85,
          child: Text(
            '$label:',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: Colors.black87,
            ),
          ),
        ),
        Expanded(child: Text(nilai, style: const TextStyle(fontSize: 12))),
      ]),
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
              width: 88, height: 88,
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green.shade50),
              child: const Icon(Icons.check_circle_rounded, size: 52, color: Colors.green),
            ),
            const SizedBox(height: 24),
            const Text('Tugas Berhasil Dikirim!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green)),
            const SizedBox(height: 14),
            const Text('Pengiriman tugas Anda telah tercatat oleh sistem.\nWaktu submit telah direkam.\nTerima kasih!', textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: Colors.black54, height: 1.6)),
            const SizedBox(height: 32),
            TombolAksi(onTap: () { Navigator.of(context).popUntil((route) => route.isFirst); }, judul: 'Kembali ke Beranda', ikon: Icons.home_rounded),
          ],
        ),
      ),
    );
  }

  void _prosesKirim() async {
    if (_barangTerpilih == null) { _tampilkanPesan('Silakan pilih barang terlebih dahulu', galat: true); return; }
    final urlGithub = _inputUrlGithub.text.trim();
    if (urlGithub.isEmpty) { _tampilkanPesan('Silakan masukkan URL GitHub', galat: true); return; }
    if (!urlGithub.startsWith('https://github.com/')) { _tampilkanPesan('Format URL GitHub tidak valid', galat: true); return; }

    showDialog(context: context, builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text('Konfirmasi Pengiriman', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      content: const Text('Apakah Anda yakin? Pengiriman hanya dapat dilakukan SATU KALI dan tidak dapat dibatalkan!', style: TextStyle(fontSize: 13)),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Batal')),
        TextButton(
          onPressed: () { Navigator.pop(ctx); _eksekusiKirim(urlGithub); },
          child: const Text('Ya, Kirim Sekarang', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    ));
  }

  void _eksekusiKirim(String urlGithub) async {
    setState(() { _sedangMemuat = true; });
    try {
      final token = await TokenVault.ambilToken();
      if (token == null) throw Exception('Token tidak ditemukan');
      
      await ProdukServices.submitTugas(
        token,
        _barangTerpilih!.namaBarang,
        urlGithub,
      );
      setState(() { _sudahTerkirim = true; });
    } catch (e) {
      _tampilkanPesan('Pengiriman gagal: $e', galat: true);
    } finally {
      if (mounted) { setState(() { _sedangMemuat = false; }); }
    }
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
  void dispose() { _inputUrlGithub.dispose(); super.dispose(); }
}
