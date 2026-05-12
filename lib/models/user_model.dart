class User {
  final int id;
  final String nama;
  final String username;
  final dynamic role;
  final dynamic kelas;

  User({
    required this.id,
    required this.nama,
    required this.username,
    required this.role,
    required this.kelas,
  });

  factory User.dariJson(Map<String, dynamic> json) => User(
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
