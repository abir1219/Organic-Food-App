import 'package:get/get.dart';
import '../bindings/cart_bindings.dart';
import 'app_pages.dart';
import 'views.dart';

class AppRouters {

  static final List<GetPage> pages =[
    GetPage(
      name: AppPages.SPLASH_SCREEN,
      page: () =>const SplashScreen(),
    ),
    GetPage(
      name: AppPages.LOGIN_PAGE,
      page: () =>const LoginScreen(),
      binding: LoginBinding()
    ),
    GetPage(
      name: AppPages.PRODUCT_PAGE,
      page: () =>const ProductPage(),
        binding: ProductBinding(),
    ),
    GetPage(
      name: AppPages.CART_PAGE,
      page: () =>const CartScreen(),
        binding: CartBindings()
    ),
    GetPage(
      name: AppPages.SHIPPING_ADDRESS_PAGE,
      page: () =>const ShippingAddressScreen(),
    ),
    GetPage(
      name: AppPages.ORDER_SUMMARY_PAGE,
      page: () =>const OrderSummaryScreen(),
    ),
    GetPage(
      name: AppPages.ORDER_DETAILS_PAGE,
      page: () =>const OrderDetailsScreen(),
    ),
    GetPage(
      name: AppPages.ORDER_LIST_PAGE,
      page: () =>const OrderListScreen(),
    ),
  ];

      /*static GoRouter routers =
      GoRouter(initialLocation: AppPages.SPLASH_SCREEN, routes: [
    GoRoute(
        path: AppPages.SPLASH_SCREEN,
        builder: (context, state) => const SplashScreen(),
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const SplashScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
        name: "splash"),
    GoRoute(
        path: AppPages.LOGIN,
        builder: (context, state) => const LoginScreen(),
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const LoginScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
        name: "login"),
        GoRoute(
        path: AppPages.PRODUCT_PAGE,
        builder: (context, state) => const ProductPage(),
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const ProductPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
        name: "productPage"),
    GoRoute(
        path: AppPages.CART_PAGE,
        builder: (context, state) => const CartScreen(),
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const CartScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
        name: "cartPage"),
        GoRoute(
            path: AppPages.SHIPPING_ADDRESS_PAGE,
            builder: (context, state) => const ShippingAddressScreen(),
            pageBuilder: (context, state) => CustomTransitionPage(
              child: const ShippingAddressScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
            name: "shippingAddressPage"),
        GoRoute(
            path: AppPages.ORDER_SUMMERY_PAGE,
            builder: (context, state) => const OrderSummeryScreen(),
            pageBuilder: (context, state) => CustomTransitionPage(
              child: const OrderSummeryScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
            name: "orderSummeryPage"),
        GoRoute(
            path: AppPages.ORDER_DETAILS_PAGE,
            builder: (context, state) => const OrderDetailsScreen(),
            pageBuilder: (context, state) => CustomTransitionPage(
              child: const OrderDetailsScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
            name: "orderDetailsPage"),
        GoRoute(
            path: AppPages.ORDER_LIST_PAGE,
            builder: (context, state) => const OrderListScreen(),
            pageBuilder: (context, state) => CustomTransitionPage(
              child: const OrderListScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
            name: "orderListPage"),
  ]);*/
}
