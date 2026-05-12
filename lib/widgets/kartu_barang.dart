import 'package:flutter/material.dart';
import '../models/barang_dagangan_model.dart';

class KartuBarang extends StatelessWidget {
  final BarangDagangan barang;
  final VoidCallback onLihat;

  const KartuBarang({
    super.key,
    required this.barang,
    required this.onLihat,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.teal),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  barang.namaBarang,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text('Harga: ${barang.hargaBarang}'),
                const SizedBox(height: 2),
                Text(
                  barang.keteranganBarang,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(onPressed: onLihat, icon: const Icon(Icons.info_outline)),
        ],
      ),
    );
  }
}
