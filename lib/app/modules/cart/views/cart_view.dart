import 'package:flutter/material.dart';
import 'package:flutter_ecom/app/utils/constants.dart';

import 'package:get/get.dart';

import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Cart'),
          centerTitle: true,
        ),
        body: GetBuilder<CartController>(
          builder: (controller) => Column(
            children: [
              SizedBox(
                height: 400,
                child: ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: controller.cart.length,
                  itemBuilder: (context, index) => CartItemCard(
                    cartItem: controller.cart[index],
                    index: index,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.all(5),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Your total amount:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => Text(
                          'Rs.${controller.totalAmount}',
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class CartItemCard extends StatelessWidget {
  final CartItem cartItem;
  final int index;
  const CartItemCard({super.key, required this.cartItem, required this.index});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 150,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Image.network(
              getImageUrl(
                cartItem.product.imageUrl,
              ),
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.product.title ?? '',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Rs.${cartItem.product.price ?? ''}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          controller.decreaseQuantity(index);
                          // controller.decrementQuantity(cartItem);
                        },
                        icon: const Icon(Icons.remove),
                      ),
                      Text(
                        cartItem.quantity.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          controller.increaseQuantity(index);
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
