import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ecom/app/models/product.dart';
import 'package:flutter_ecom/app/utils/constants.dart';
import 'package:flutter_ecom/app/utils/memory_management.dart';
import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:http/http.dart' as http;

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

  void order() async {
    try {
      if (totalAmount.value < 1) {
        showCustomSnackBar(
          color: Colors.red,
          isTop: true,
          message: 'Cart is empty, add some products to cart',
        );
        return;
      }

      var orderId = await placeOrder();

      if (orderId == null) {
        return;
      }

      final config = PaymentConfig(
        amount: 10000, // Amount should be in paisa
        productIdentity: orderId.toString(),
        productName: 'Payment for order',
      );

      KhaltiScope.of(Get.context!).pay(
          preferences: [PaymentPreference.khalti],
          config: config,
          onSuccess: (v) {
            makePayment(
                amount: (v.amount / 100).toString(),
                orderId: orderId,
                otherData: v.toString());
          },
          onFailure: (v) {
            showCustomSnackBar(
              color: Colors.red,
              isTop: true,
              message: 'Payment Failed',
            );
          });
    } catch (e) {
      showCustomSnackBar(
        color: Colors.red,
        isTop: true,
        message: 'Something went wrong',
      );
    }
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

  Future<int?> placeOrder() async {
    try {
      var url = Uri.http(baseUrl, 'ecom_api/addOrder');

      var response = await http.post(url, body: {
        'token': MemoryManagement.getAccessToken(),
        'amount': totalAmount.value.toString(),
        'orders': jsonEncode(cart
            .map((e) => {
                  'product_id': e.product.productId,
                  'quantity': e.quantity,
                  'price': e.product.price
                })
            .toList())
      });

      var data = jsonDecode(response.body);
      if (data['status'] == 200) {
        showCustomSnackBar(message: data['message'], color: Colors.green);

        return data['order_id'];
      } else {
        showCustomSnackBar(
            message: data['message'], color: Colors.red, isTop: true);
      }
    } catch (e) {
      print(e.toString());
      showCustomSnackBar(
          message: 'Something went wrong', color: Colors.red, isTop: true);
    }
    return null;
  }

  void makePayment(
      {required String amount,
      required int orderId,
      required String otherData}) async {
    try {
      var url = Uri.http(baseUrl, 'ecom_api/makePayment');

      var response = await http.post(url, body: {
        'token': MemoryManagement.getAccessToken(),
        'amount': amount,
        'order_id': orderId.toString(),
        'other_data': otherData,
      });

      var data = jsonDecode(response.body);
      if (data['status'] == 200) {
        Get.back();
        showCustomSnackBar(message: data['message'], color: Colors.green);
        cart.clear();
      } else {
        showCustomSnackBar(
            message: data['message'], color: Colors.red, isTop: true);
      }
    } catch (e) {
      showCustomSnackBar(
          message: 'Something went wrong', color: Colors.red, isTop: true);
    }
    return null;
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
