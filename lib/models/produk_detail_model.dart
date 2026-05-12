class ProdukDetail {
  final int kodeProduk;
  final String namaProduk;
  final int hargaProduk;
  final String keteranganProduk;
  final String tanggalDibuat;

  ProdukDetail({
    required this.kodeProduk,
    required this.namaProduk,
    required this.hargaProduk,
    required this.keteranganProduk,
    required this.tanggalDibuat,
  });

  factory ProdukDetail.dariJson(Map<String, dynamic> json) {
    int harga = 0;
    if (json['price'] != null) {
      if (json['price'] is String) {
        harga = double.tryParse(json['price'])?.toInt() ?? 0;
      } else if (json['price'] is int) {
        harga = json['price'];
      } else if (json['price'] is double) {
        harga = (json['price'] as double).toInt();
      }
    }

    return ProdukDetail(
      kodeProduk: json['id'] ?? 0,
      namaProduk: json['name'] ?? '',
      hargaProduk: harga,
      keteranganProduk: json['description'] ?? '',
      tanggalDibuat: (json['created_at'] ?? '').toString(),
    );
  }

  Map<String, dynamic> keJson() => {
    'id': kodeProduk,
    'name': namaProduk,
    'price': hargaProduk,
    'description': keteranganProduk,
    'created_at': tanggalDibuat,
  };
}
