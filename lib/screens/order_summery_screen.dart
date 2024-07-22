import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:organic_food_new/controllers/cart_controller.dart';
import 'package:organic_food_new/screens/cart_product_list.dart';
import 'package:organic_food_new/screens/payment_mode_screen.dart';
import 'package:organic_food_new/utils/app_colors.dart';
import 'package:organic_food_new/utils/sharedpreference_utils.dart';
import 'package:organic_food_new/utils/utils.dart';
import 'package:organic_food_new/widgets/app_widgets.dart';
import 'package:organic_food_new/widgets/my_custom_bottom_nav.dart';

import '../router/app_pages.dart';
import '../utils/app_constants.dart';

class OrderSummaryScreen extends StatefulWidget {
  const OrderSummaryScreen({super.key});

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  // bool x = Get.isRegistered<CartController>();
  var controller = Get.find<CartController>();

  @override
  void initState() {
    super.initState();
    controller.getAllCarts().then((value) => controller.getAllAddress(),);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    debugPrint("Enter-->${Get.parameters['addressId']}");
    debugPrint("Enter-->${Get.parameters['selectedAddressIndex']}");
    // debugPrint("Enter-->$x");

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        debugPrint("didPop-->$didPop");
        if (didPop) {
          return;
        }
        Get.offNamed(AppPages.SHIPPING_ADDRESS_PAGE);
      },
      child: Scaffold(
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
                child: Obx(
                  () {
                    // controller.isAddressLoading.value?null:debugPrint("LENGTH==>${controller.addresses.length}");
                    return controller.isAddressLoading.value ?
                    Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                          color: AppColors.LOGO_BACKGROUND_COLOR,
                          size: size.width * 0.08), //35
                    ) :
                    Container(
                      margin:
                      EdgeInsets.symmetric(horizontal: size.width * 0.01),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /*const Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
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
                                  ))
                                ],
                              ),*/
                          Container(
                            color: Colors.transparent,
                            width: size.width,
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Ship to",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color:
                                        AppColors.LOGO_BACKGROUND_COLOR),
                                  ),
                                  Text(
                                    "${SharedPreferencesUtils.getString(AppConstants.USER_NAME)}",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    "${controller.addresses[int.parse(Get.parameters['selectedAddressIndex']!)].address!},",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    "${controller.addresses[int.parse(Get.parameters['selectedAddressIndex']!)].city!}-${controller.addresses[int.parse(Get.parameters['selectedAddressIndex']!)].pincode!}",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    controller.addresses[int.parse(Get.parameters[
                                    'selectedAddressIndex']!)]
                                        .state!,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Gap(size.height * 0.01),
                          Expanded(
                            child: CartProductList(
                              result: controller.cartProducts,
                              controller: controller,
                            ),
                          ),
                          Container(
                            // margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                            height: size.height * 0.17,
                            width: size.height * 0.45,
                            padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.01,
                                horizontal: size.height * 0.01),
                            decoration: BoxDecoration(
                              color: AppColors.LOGIN_BACKGROUND_COLOR
                                  .withOpacity(0.3),
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
                                        color:
                                        AppColors.LOGO_BACKGROUND_COLOR,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                // const Divider(
                                //   color: AppColors.LOGO_BACKGROUND_COLOR,
                                // ),
                                Obx(
                                      () => _buildPricingDetails(
                                      size,
                                      "Total MRP",
                                      "₹ ${controller.total.value}",
                                      false,
                                      Colors.black),
                                ),
                                _buildPricingDetails(size, "Discount on MRP",
                                    " ₹ -00.00", false, Colors.black),
                                _buildPricingDetails(size, "Shipping Fee",
                                    " ₹ 00.00", false, Colors.black),
                                const Divider(
                                  color: AppColors.LOGO_BACKGROUND_COLOR,
                                ),
                                Obx(
                                      () => _buildPricingDetails(
                                      size,
                                      "Total Amount",
                                      "₹ ${controller.total.value}",
                                      true,
                                      Colors.black),
                                ),
                              ],
                            ),
                          ),
                          Gap(size.height * 0.01),
                          Container(
                            color: Colors.transparent,
                            alignment: Alignment.center,
                            width: size.width * 0.8,
                            child: AppWidgets.customButton(
                              size: size,
                              btnName: "Place Order",
                              color: AppColors.LOGO_BACKGROUND_COLOR,
                              func: () {
                                if(controller.cartProducts.isNotEmpty){
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return PaymentModeScreen(
                                        controller: controller,
                                        addressId: Get.parameters['addressId']
                                            .toString(),
                                      );
                                    },
                                  );
                                }else{
                                  Utils.showToastMessage("Your cart is empty");
                                }
                              },
                            ),
                          ),
                          Gap(size.height * 0.01),
                        ],
                      ),
                    );
                  }),
              )
            ],
          ),
        ),
        bottomNavigationBar: const MyCustomBottomNav(pageIndex: 1,),
      ),
    );
  }

  Widget _buildPricingDetails(
      Size size, String key, String value, bool isBold, Color color) {
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.symmetric(vertical: size.height * 0.003),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              textAlign: TextAlign.start,
              key,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
                color: color,
              ),
            ),
          ),
          Expanded(
            child: Text(
                textAlign: TextAlign.end,
                value,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
                  color: Colors.black,
                )),
          ),
        ],
      ),
    );
  }
}
