import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ecom/app/models/product.dart';
import 'package:flutter_ecom/app/utils/constants.dart';
import 'package:flutter_ecom/app/utils/memory_management.dart';
import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class CartController extends GetxController {
  List<CartItem> cart = [];
  Rx<double> totalAmount = 0.0.obs;

  @override
  void onInit() {
    super.onInit();

    getCart();
  }

  void updateTotalAmount() {
    totalAmount.value = 0.0;
    for (var element in cart) {
      if (element.product.price == null) {
        return;
      }

      totalAmount.value = totalAmount.value +
          double.parse(element.product.price!) * element.quantity;
    }
  }

  void getCart() {
    String? cart = MemoryManagement.getCart();
    if (cart != null) {
      var decodedCart = jsonDecode(cart) as List;
      this.cart = decodedCart
          .map((e) => CartItem(
              product: Product(
                  productId: e['productId'],
                  price: e['price'],
                  title: e['title'],
                  imageUrl: e['imageUrl']),
              quantity: e['quantity']))
          .toList();
    }
    updateTotalAmount();
  }

  void order() {
    try {
      final config = PaymentConfig(
        amount: 10000, // Amount should be in paisa
        productIdentity: 'dell-g5-g5510-2021',
        productName: 'Dell G5 G5510 2021',
      );

      KhaltiScope.of(Get.context!).pay(
          preferences: [PaymentPreference.khalti],
          config: config,
          onSuccess: (v) {
            showCustomSnackBar(
              color: Colors.green,
              isTop: true,
              message: 'Payment successful',
            );
          },
          onFailure: (v) {
            showCustomSnackBar(
              color: Colors.green,
              isTop: true,
              message: 'Payment successful',
            );
          });
    } catch (e) {}
  }

  void addToCart({required Product product, int quantity = 1}) {
    cart.add(CartItem(product: product, quantity: quantity));
    showCustomSnackBar(
      color: Colors.green,
      isTop: true,
      message: 'Product added to cart',
    );
    updateMemory();
    update();
  }

  void updateMemory() {
    MemoryManagement.setCart(
      jsonEncode(cart.map((e) {
        return {
          'productId': e.product.productId,
          'title': e.product.title,
          'price': e.product.price,
          'imageUrl': e.product.imageUrl,
          'quantity': e.quantity,
        };
      }).toList()),
    );
    updateTotalAmount();
  }

  void increaseQuantity(int index) {
    cart[index].quantity++;
    updateMemory();
    update();
  }

  void decreaseQuantity(int index) {
    if (cart[index].quantity <= 1) {
      showCustomSnackBar(
        color: Colors.red,
        isTop: true,
        message: 'Quantity cannot be less than 1',
      );
      return;
    }
    cart[index].quantity--;

    updateMemory();
    update();
  }

  void removeFromCart({required CartItem cartItem}) {
    cart.remove(cartItem);
    showCustomSnackBar(
      color: Colors.red,
      isTop: true,
      message: 'Product removed from cart',
    );
    updateMemory();
    update();
  }

  void clearCart() {
    cart.clear();
    showCustomSnackBar(
      color: Colors.red,
      isTop: true,
      message: 'Cart cleared',
    );
    updateMemory();
    update();
  }
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}
