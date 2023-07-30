import 'package:flutter/material.dart';
import 'package:flutter_ecom/app/models/product.dart';
import 'package:flutter_ecom/app/utils/constants.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  List<CartItem> cart = [];

  void addToCart({required Product product, int quantity = 1}) {
    cart.add(CartItem(product: product, quantity: quantity));
    showCustomSnackBar(
      color: Colors.green,
      isTop: true,
      message: 'Product added to cart',
    );
    update();
  }

  void increaseQuantity(int index) {
    cart[index].quantity++;

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

    update();
  }

  void removeFromCart({required CartItem cartItem}) {
    cart.remove(cartItem);
    showCustomSnackBar(
      color: Colors.red,
      isTop: true,
      message: 'Product removed from cart',
    );
    update();
  }

  void clearCart() {
    cart.clear();
    showCustomSnackBar(
      color: Colors.red,
      isTop: true,
      message: 'Cart cleared',
    );
    update();
  }
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}
