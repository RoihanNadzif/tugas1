import 'user_model.dart';

class HasilAutentikasi {
  final bool success;
  final String message;
  final String token;
  final User user;

  HasilAutentikasi({
    required this.success,
    required this.message,
    required this.token,
    required this.user,
  });

  factory HasilAutentikasi.dariJson(Map<String, dynamic> json) =>
      HasilAutentikasi(
        success: json['success'] ?? false,
        message: json['message'] ?? '',
        token: json['data']?['token'] ?? '',
        user: User.dariJson(json['data']?['user'] ?? {}),
      );

  // Alias agar pemanggilan di service tetap sederhana dan konsisten.
  String get tokenAkses => token;
}
