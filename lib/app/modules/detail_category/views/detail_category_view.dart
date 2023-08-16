import 'package:flutter/material.dart';
import 'package:flutter_ecom/app/components/search_product_card.dart';
import 'package:flutter_ecom/app/models/category.dart';

import 'package:get/get.dart';

import '../controllers/detail_category_controller.dart';

class DetailCategoryView extends GetView<DetailCategoryController> {
  const DetailCategoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var category = Get.arguments as Category;
    return Scaffold(
        appBar: AppBar(
          title: Text(category.categoryTitle ?? ''),
          centerTitle: true,
        ),
        body: controller.products.isEmpty
            ? Center(
                child: Text(
                'No products found for the ${category.categoryTitle}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ))
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemCount: controller.products.length,
                  itemBuilder: (context, index) => SearchProductCard(
                    product: controller.products[index],
                  ),
                ),
              ));
  }
}
