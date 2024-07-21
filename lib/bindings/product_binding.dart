import 'package:get/get.dart';

import '../controllers/products_controller.dart';



class ProductBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ProductsController>(() => ProductsController(),fenix: true);
  }
}