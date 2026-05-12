// Model data untuk representasi Barang Dagangan (Product) dari API
// Menyimpan informasi lengkap satu item barang

// Model sederhana Barang Dagangan
// Bagian ini bisa diubah untuk originalitas
class BarangDagangan {
  final int kodeBarang;
  final String namaBarang;
  final int hargaBarang;
  final String keteranganBarang;
  final String tanggalDibuat;

  BarangDagangan({
    required this.kodeBarang,
    required this.namaBarang,
    required this.hargaBarang,
    required this.keteranganBarang,
    required this.tanggalDibuat,
  });

  // Factory dari JSON
  factory BarangDagangan.dariJson(Map<String, dynamic> json) => BarangDagangan(
    kodeBarang: json['id'] ?? 0,
    namaBarang: json['name'] ?? '',
    hargaBarang: json['price'] ?? 0,
    keteranganBarang: json['description'] ?? '',
    tanggalDibuat: (json['created_at'] ?? '').toString(),
  );

  // Konversi ke JSON
  Map<String, dynamic> keJson() => {
    'id': kodeBarang,
    'name': namaBarang,
    'price': hargaBarang,
    'description': keteranganBarang,
    'created_at': tanggalDibuat,
  };
}
