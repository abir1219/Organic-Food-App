import 'package:get/get.dart';
import 'package:organic_food_new/controllers/order_controller.dart';

class OrdersBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<OrderController>(() => OrderController(),fenix: true);
  }
}