import 'package:flutter/material.dart';
import 'package:flutter_ecom/app/models/product.dart';
import 'package:flutter_ecom/app/utils/constants.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      height: 100,
      child: Column(
        children: [
          Image.network(getImageUrl(product.imageUrl ?? '')),
          Text(product.title ?? ''),
        ],
      ),
    );
  }
}
