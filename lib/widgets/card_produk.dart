import 'package:flutter/material.dart';
import '../models/produk_detail_model.dart';

class CardProduk extends StatelessWidget {
  final ProdukDetail produk;
  final VoidCallback onLihat;

  const CardProduk({super.key, required this.produk, required this.onLihat});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFF1E293B)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  produk.namaProduk,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 4),
                Text('Harga: ${produk.hargaProduk}'),
                const SizedBox(height: 2),
                Text(
                  produk.keteranganProduk,
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
