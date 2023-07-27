import 'package:flutter/material.dart';
import 'package:flutter_ecom/app/components/my_button.dart';
import 'package:flutter_ecom/app/components/my_textfield.dart';
import 'package:flutter_ecom/app/models/product.dart';
import 'package:flutter_ecom/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ecom/app/utils/constants.dart';

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
            if (controller.products == null) {
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
          Image(width: 75, image: NetworkImage(getImageUrl(product.imageUrl))),
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
    var controller = Get.put(HomeController());
    return Dialog(
        insetPadding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: controller.addProductKey,
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
                  controller: controller.nameController,
                  labelText: 'Product Name',
                  hintText: 'Enter Product Name',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter product name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: controller.descriptionController,
                  labelText: 'Product Description',
                  hintText: 'Enter Product Description',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter product description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                MyTextField(
                  isNumber: true,
                  controller: controller.priceController,
                  labelText: 'Product price',
                  hintText: 'Enter Product price',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter product price';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                controller.categories == null
                    ? const CircularProgressIndicator()
                    : DropdownButtonFormField(
                        validator: (value) {
                          if (value == null) {
                            return 'Please select category';
                          }
                          return null;
                        },
                        menuMaxHeight: 400,
                        decoration: const InputDecoration(
                          labelText: 'Select Category',
                          border: OutlineInputBorder(),
                        ),
                        items: controller.categories!
                            .map((e) => DropdownMenuItem(
                                  value: e.categoryId,
                                  child: Text(e.title ?? ''),
                                ))
                            .toList(),
                        hint: const Text('Select Category'),
                        onChanged: (value) {
                          controller.selectedCategory.value = value ?? '';
                        }),
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
                  onPressed: controller.addProduct,
                )
              ]),
            ),
          ),
        ));
  }
}
