import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:device_preview/device_preview.dart';
import 'screens/halaman_masuk.dart';
import 'screens/halaman_katalog.dart';
import 'services/token_vault.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const AplikasiUtama(),
    ),
  );
}

class AplikasiUtama extends StatelessWidget {
  const AplikasiUtama({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugas PBM',
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      home: const PemeriksaSesi(),
      routes: {
        '/masuk': (context) => const HalamanMasuk(),
        '/katalog': (context) => const HalamanKatalog(),
      },
    );
  }
}

class PemeriksaSesi extends StatefulWidget {
  const PemeriksaSesi({super.key});

  @override
  State<PemeriksaSesi> createState() => _PemeriksaSesiState();
}

class _PemeriksaSesiState extends State<PemeriksaSesi> {
  late Future<bool> _cekSesi;

  @override
  void initState() {
    super.initState();
    _cekSesi = TokenVault.adaToken();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _cekSesi,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.teal,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Memuat...',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (snapshot.data == true) {
          return const HalamanKatalog();
        } else {
          return const HalamanMasuk();
        }
      },
    );
  }
}
