// Model data untuk representasi Pengguna dari API
// Digunakan saat parsing response login

// Model sederhana Pengguna
// Bagian ini bisa diubah untuk originalitas
class Pengguna {
  final int id;
  final String nama;
  final String username;
  final dynamic role;
  final dynamic kelas;

  Pengguna({
    required this.id,
    required this.nama,
    required this.username,
    required this.role,
    required this.kelas,
  });

  factory Pengguna.dariJson(Map<String, dynamic> json) => Pengguna(
    id: json['id'] ?? 0,
    nama: json['name'] ?? '',
    username: json['username'] ?? '',
    role: json['role'],
    kelas: json['class'],
  );

  Map<String, dynamic> keJson() => {
    'id': id,
    'name': nama,
    'username': username,
    'role': role,
    'class': kelas,
  };
}
