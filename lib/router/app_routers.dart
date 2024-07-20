import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:organic_food_new/screens/cart_screen.dart';
import 'package:organic_food_new/screens/login_screen.dart';
import 'package:organic_food_new/screens/order_details_screen.dart';
import 'package:organic_food_new/screens/order_list_screen.dart';
import 'package:organic_food_new/screens/order_summery_screen.dart';
import 'package:organic_food_new/screens/product_page.dart';
import 'package:organic_food_new/screens/shipping_address_screen.dart';
import 'package:organic_food_new/screens/splash_screen.dart';
import 'app_pages.dart';

class AppRouters {
  static GoRouter routers =
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
  ]);
}
