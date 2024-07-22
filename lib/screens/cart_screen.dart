import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:organic_food_new/controllers/cart_controller.dart';
import 'package:organic_food_new/router/app_pages.dart';
import 'package:organic_food_new/screens/cart_product_list.dart';
import 'package:organic_food_new/utils/app_colors.dart';
import 'package:organic_food_new/widgets/app_widgets.dart';
import 'package:organic_food_new/widgets/my_custom_bottom_nav.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var controller = Get.find<CartController>();

  @override
  void initState() {
    super.initState();
    controller.getAllCarts();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: size.height * 0.15,
              width: size.width,
              decoration: const BoxDecoration(
                color: AppColors.LOGO_BACKGROUND_COLOR,
                image: DecorationImage(
                  image: AssetImage("assets/images/doodle_bg.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: SvgPicture.asset(
                  "assets/images/logo.svg",
                  height: size.height * 0.12,
                ),
              ),
            ),
            Container(
              height: size.height * 0.04,
              color: AppColors.LOGIN_BACKGROUND_COLOR.withOpacity(0.3),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.shopping_cart_outlined,
                    color: AppColors.LOGO_BACKGROUND_COLOR,
                    size: 22,
                  ),
                  Gap(size.width * 0.02),
                  Obx(
                    () => Text(
                      "Cart (${controller.cartProducts.length})",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.LOGO_BACKGROUND_COLOR,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Gap(size.height * 0.01),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.height * 0.02),
                child: Column(
                  children: [
                    /*Container(
                      margin:
                          EdgeInsets.symmetric(vertical: size.height * 0.01),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.place,
                            color: AppColors.LOGO_BACKGROUND_COLOR,
                            size: 20,
                          ),
                          Expanded(
                              child: Text(
                            "Kolkata",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14,
                                color: AppColors.LOGO_BACKGROUND_COLOR,
                                fontWeight: FontWeight.w600),
                          )),
                        ],
                      ),
                    ),*/
                    Expanded(
                        child: CartProductList(
                      result: controller.cartProducts,
                      controller: controller,
                    ))
                  ],
                ),
              ),
            ),
            Container(
              // margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              height: size.height * 0.12,
              width: size.height * 0.4,
              padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.01, horizontal: size.height * 0.01),
              decoration: BoxDecoration(
                color: AppColors.LOGIN_BACKGROUND_COLOR.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Text(
                      "Price Details (${controller.cartProducts.length} items)",
                      style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.LOGO_BACKGROUND_COLOR,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const Divider(
                    color: AppColors.LOGO_BACKGROUND_COLOR,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "Total: ",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.LOGO_BACKGROUND_COLOR,
                                  fontWeight: FontWeight.w400),
                            ),
                            Obx(
                              () => Text(
                                "₹${controller.total.value}",
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: AppColors.LOGO_BACKGROUND_COLOR,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: size.width * 0.4,
                          child: AppWidgets.customButton(
                            size: size,
                            btnName: "Place Order",
                            color: AppColors.LOGO_BACKGROUND_COLOR,
                            func: () {
                              Get.offNamed(AppPages.SHIPPING_ADDRESS_PAGE);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MyCustomBottomNav(
        pageIndex: 1,
      ),
    );
  }
}
