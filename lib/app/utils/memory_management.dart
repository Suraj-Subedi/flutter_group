import 'package:shared_preferences/shared_preferences.dart';

class MemoryManagement {
  static SharedPreferences? prefs;
  static Future<bool> init() async {
    prefs = await SharedPreferences.getInstance();
    return true;
  }

  static String? getAccessToken() {
    return prefs != null ? prefs!.getString('token') : null;
  }

  static void setAccessToken(String token) {
    prefs!.setString('token', token);
  }

  static void removeAccessToken() {
    prefs!.remove('token');
  }

  static String? getRole() {
    return prefs != null ? prefs!.getString('role') : null;
  }

  static void setRole(String role) {
    prefs!.setString('role', role);
  }

  static String? getCart() {
    return prefs != null ? prefs!.getString('cart') : null;
  }

  static void setCart(String cart) {
    prefs!.setString('cart', cart);
  }

  static void removeRole() {
    prefs!.remove('role');
  }

  static void removeAll() async {
    prefs!.remove('token');
    prefs!.remove('role');
  }
}
