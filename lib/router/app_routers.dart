import 'package:get/get.dart';
import 'package:organic_food_new/bindings/orders_bindings.dart';
import 'app_pages.dart';
import 'views.dart';

class AppRouters {
  static final List<GetPage> pages = [
    GetPage(
      name: AppPages.SPLASH_SCREEN,
      page: () => const SplashScreen(),
    ),
    GetPage(
        name: AppPages.LOGIN_PAGE,
        page: () => const LoginScreen(),
        binding: LoginBinding()),
    GetPage(
      name: AppPages.PRODUCT_PAGE,
      page: () => const ProductPage(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: AppPages.CART_PAGE,
      page: () => const CartScreen(),
      binding: CartBindings(),
    ),
    GetPage(
      name: AppPages.SHIPPING_ADDRESS_PAGE,
      page: () => const ShippingAddressScreen(),
    ),
    GetPage(
      name: AppPages.ORDER_SUMMARY_PAGE,
      page: () => const OrderSummaryScreen(),
    ),
    GetPage(
      name: AppPages.ORDER_DETAILS_PAGE,
      page: () => const OrderDetailsScreen(),
    ),
    GetPage(
      name: AppPages.ORDER_LIST_PAGE,
      page: () => const OrderListScreen(),
      binding: OrdersBindings()
    ),
  ];
}
