import 'package:flutter/material.dart';

class InputButton extends StatelessWidget {
  final TextEditingController pengendali;
  final String label;
  final String? petunjuk;
  final IconData? ikon;
  final bool rahasiakan;
  final Widget? aksiSufiks;
  final TextInputType? tipeInput;
  final int? barisMaksimal;
  final int? barisMinimal;

  const InputButton({
    super.key,
    required this.pengendali,
    required this.label,
    this.petunjuk,
    this.ikon,
    this.rahasiakan = false,
    this.aksiSufiks,
    this.tipeInput,
    this.barisMaksimal = 1,
    this.barisMinimal = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: pengendali,
      obscureText: rahasiakan,
      keyboardType: tipeInput,
      maxLines: barisMaksimal,
      minLines: barisMinimal,
      style: const TextStyle(fontSize: 15, color: Color(0xFF111827)),
      decoration: InputDecoration(
        labelText: label,
        hintText: petunjuk,
        labelStyle: const TextStyle(color: Color(0xFF1E293B), fontSize: 14),
        hintStyle: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 13),
        prefixIcon: ikon != null
            ? Icon(ikon, color: Color(0xFF1E293B), size: 22)
            : null,
        suffixIcon: aksiSufiks,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFD1D5DB), width: 1.5),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF1E293B), width: 2.5),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      ),
    );
  }
}
