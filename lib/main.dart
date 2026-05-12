import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:device_preview/device_preview.dart';
import 'screens/cek_login.dart';
import 'screens/page_login.dart';
import 'services/token_vault.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const ProjekProduk(),
    ),
  );
}

class ProjekProduk extends StatelessWidget {
  const ProjekProduk({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PBM',
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData(primarySwatch: Colors.grey, useMaterial3: true),
      home: const CekSesi(),
      routes: {
        '/masuk': (context) => const CekLogin(),
        '/katalog': (context) => const HalamanLogin(),
      },
    );
  }
}

class CekSesi extends StatefulWidget {
  const CekSesi({super.key});

  @override
  State<CekSesi> createState() => _CekSesiState();
}

class _CekSesiState extends State<CekSesi> {
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
            backgroundColor: Color(0xFFFAFAFA),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Loading...',
                    style: TextStyle(fontSize: 13, color: Color(0xFF9CA3AF)),
                  ),
                ],
              ),
            ),
          );
        }

        if (snapshot.data == true) {
          return const HalamanLogin();
        } else {
          return const CekLogin();
        }
      },
    );
  }
}
