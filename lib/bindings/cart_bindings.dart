import 'package:get/get.dart';
import 'package:organic_food_new/controllers/cart_controller.dart';

class CartBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<CartController>(() => CartController(),fenix: true);
  }
}