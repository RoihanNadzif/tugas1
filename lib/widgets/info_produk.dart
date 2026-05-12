import 'package:flutter/material.dart';

class InfoProduk extends StatelessWidget {
  final VoidCallback onTap;
  final String judul;
  final Color? warnaLatar;
  final Color? warnaTeks;
  final IconData? ikon;
  final bool sedangMemuat;
  final double tinggi;

  const InfoProduk({
    super.key,
    required this.onTap,
    required this.judul,
    this.warnaLatar,
    this.warnaTeks,
    this.ikon,
    this.sedangMemuat = false,
    this.tinggi = 50,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: tinggi,
      child: MaterialButton(
        onPressed: sedangMemuat ? null : onTap,
        color: warnaLatar ?? Color(0xFF1E293B),
        disabledColor: (warnaLatar ?? Color(0xFF1E293B)).withValues(alpha: 0.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 2,
        child: sedangMemuat
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (ikon != null) ...[
                    Icon(ikon, color: warnaTeks ?? Colors.white, size: 20),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    judul,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: warnaTeks ?? Colors.white,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
