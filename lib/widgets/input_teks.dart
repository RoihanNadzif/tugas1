import 'package:flutter/material.dart';

class InputTeks extends StatelessWidget {
  final TextEditingController pengendali;
  final String label;
  final String? petunjuk;
  final IconData? ikon;
  final bool rahasiakan;
  final Widget? aksiSufiks;
  final TextInputType? tipeInput;
  final int? barisMaksimal;
  final int? barisMinimal;

  const InputTeks({
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
      style: const TextStyle(
        fontSize: 15,
        color: Colors.black87,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: petunjuk,
        labelStyle: TextStyle(
          color: Colors.teal,
          fontSize: 14,
        ),
        hintStyle: TextStyle(
          color: Colors.black45,
          fontSize: 13,
        ),
        prefixIcon: ikon != null
            ? Icon(
                ikon,
                color: Colors.teal,
                size: 22,
              )
            : null,
        suffixIcon: aksiSufiks,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.teal.shade200,
            width: 1.5,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.teal,
            width: 2.5,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      ),
    );
  }
}
