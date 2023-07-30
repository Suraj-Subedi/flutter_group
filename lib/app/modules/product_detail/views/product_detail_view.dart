import 'package:flutter/material.dart';
import 'package:flutter_ecom/app/models/product.dart';
import 'package:flutter_ecom/app/utils/constants.dart';

import 'package:get/get.dart';

import '../controllers/product_detail_controller.dart';

class ProductDetailView extends GetView<ProductDetailController> {
  const ProductDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var product = Get.arguments as Product;
    return Scaffold(
        appBar: AppBar(
          title: Text(product.title ?? ''),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Image.network(
                getImageUrl(product.imageUrl),
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(),
            ),
          ],
        ));
  }
}
