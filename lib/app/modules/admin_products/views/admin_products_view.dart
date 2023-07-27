import 'package:flutter/material.dart';
import 'package:flutter_ecom/app/components/my_button.dart';
import 'package:flutter_ecom/app/components/my_textfield.dart';
import 'package:flutter_ecom/app/models/product.dart';
import 'package:flutter_ecom/app/modules/home/controllers/home_controller.dart';

import 'package:get/get.dart';

import '../controllers/admin_products_controller.dart';

class AdminProductsView extends GetView<AdminProductsController> {
  const AdminProductsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        centerTitle: true,
      ),
      body: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (controller) {
            if (controller.categories == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.products!.length,
                  itemBuilder: (context, index) => ProductCard(
                        product: controller.products![index],
                      )),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddProductPopup(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 15,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            product.title ?? '',
            style: const TextStyle(
              fontSize: 17,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ))
        ],
      ),
    );
  }
}

class AddProductPopup extends StatelessWidget {
  const AddProductPopup({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    return Dialog(
        insetPadding: const EdgeInsets.all(15),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: controller.addCategoryKey,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Text(
                'Add Product',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              MyTextField(
                controller: controller.titleController,
                labelText: 'Product Name',
                hintText: 'Enter Product Name',
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: controller.descriptionController,
                labelText: 'Product Description',
                hintText: 'Enter Product Description',
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: controller.priceController,
                labelText: 'Product price',
                hintText: 'Enter Product price',
              ),
              const SizedBox(height: 10),
              Obx(
                () => controller.imageBytes.value.isEmpty
                    ? ElevatedButton(
                        onPressed: controller.pickImage,
                        child: const Text('Upload Image'),
                      )
                    : SizedBox(
                        height: 200,
                        width: 200,
                        child: Image.memory(controller.imageBytes.value),
                      ),
              ),
              const SizedBox(height: 10),
              MyButton(
                title: 'Add Product',
                onPressed: controller.addCategory,
              )
            ]),
          ),
        ));
  }
}
