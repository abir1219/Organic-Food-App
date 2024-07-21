import 'package:get/get.dart';
import 'package:organic_food_new/controllers/login_controller.dart';


class LoginBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController(),fenix: true);
  }
}