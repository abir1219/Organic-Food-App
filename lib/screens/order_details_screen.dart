import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:organic_food_new/controllers/order_controller.dart';
import 'package:organic_food_new/utils/app_colors.dart';
import 'package:organic_food_new/utils/app_constants.dart';
import 'package:organic_food_new/utils/sharedpreference_utils.dart';
import 'package:organic_food_new/widgets/app_widgets.dart';
import 'package:organic_food_new/widgets/my_custom_bottom_nav.dart';

import '../router/app_pages.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  var controller = Get.isRegistered<OrderController>()
      ? Get.find<OrderController>()
      : Get.put(OrderController());

  @override
  void initState() {
    super.initState();
    controller.getOrdersDetails(Get.parameters['orderId'].toString());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        debugPrint("didPop-->$didPop");
        if (didPop) {
          return;
        }
        Get.offNamed(AppPages.ORDER_LIST_PAGE);
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
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: size.width * 0.02,
                      vertical: size.height * 0.005),
                  color: Colors.transparent,
                  child: Obx(
                    () => controller.isSingleOrderLoading.value
                        ? Center(
                            child: LoadingAnimationWidget.staggeredDotsWave(
                                color: AppColors.LOGO_BACKGROUND_COLOR,
                                size: size.width * 0.08), //35
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // shrinkWrap: true,
                            children: [
                              const Text(
                                "Order Details",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.LOGO_BACKGROUND_COLOR),
                              ),
                              const Divider(
                                color: AppColors.LOGO_BACKGROUND_COLOR,
                                thickness: 0.5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Order Reference",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.HINT_TEXT_COLOR),
                                  ),
                                  Text(
                                    DateFormat("d MMMM").format(DateTime.parse(
                                        controller
                                            .orderListModel
                                            .value
                                            .result![0]
                                            .orderItems![0]
                                            .createdAt!)),
                                    //"18th July",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.HINT_TEXT_COLOR),
                                  ),
                                ],
                              ),
                              Text(
                                "# ${controller.orderListModel.value.result![0].orderNumber}",
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              Gap(size.height * .01),
                              const Text(
                                "Shipment to",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              Gap(size.height * .002),
                              Text(
                                "${SharedPreferencesUtils.getString(AppConstants.USER_NAME)}",
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              Text(
                                controller.orderListModel.value.result![0]
                                    .address!.address!,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                              Text(
                                "${controller.orderListModel.value.result![0].address!.city!} - ${controller.orderListModel.value.result![0].address!.pincode!}",
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                              Text(
                                controller.orderListModel.value.result![0]
                                    .address!.state!,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                              Gap(size.height * .02),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: size.height *
                                      .01, /*vertical: size.height * .005*/
                                ),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.LOGO_BACKGROUND_COLOR,
                                        width: 0.5)),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Gap(size.height * 0.02),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Product Quantity",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          "${controller.orderListModel.value.result![0].orderItems!.length}",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      color: AppColors.LOGO_BACKGROUND_COLOR
                                          .withOpacity(0.3),
                                      thickness: 0.5,
                                    ),
                                    /*const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Product Quantity",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          "2",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),*/
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) => Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${controller.orderListModel.value.result![0].orderItems![index].productName} (${controller.orderListModel.value.result![0].orderItems![index].value})",
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                "₹ ${controller.orderListModel.value.result![0].orderItems![index].totalPrice}",
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                          if (index !=
                                              controller
                                                      .orderListModel
                                                      .value
                                                      .result![0]
                                                      .orderItems!
                                                      .length -
                                                  1)
                                            Divider(
                                              color: AppColors
                                                  .LOGO_BACKGROUND_COLOR
                                                  .withOpacity(0.3),
                                              thickness: 0.5,
                                            ),
                                        ],
                                      ),
                                      itemCount: controller.orderListModel.value
                                          .result![0].orderItems!.length,
                                    ),
                                    Divider(
                                      color: AppColors.LOGO_BACKGROUND_COLOR
                                          .withOpacity(0.3),
                                      thickness: 0.5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Total MRP",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          "₹ ${controller.total.value}",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      color: AppColors.LOGO_BACKGROUND_COLOR
                                          .withOpacity(0.3),
                                      thickness: 0.5,
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Shipping Fee",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          "₹ 00.00",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      color: AppColors.LOGO_BACKGROUND_COLOR
                                          .withOpacity(0.3),
                                      thickness: 0.5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Payment Mode",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          "${controller.orderListModel.value.result![0].paymentType}",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    /*Divider(
                                      color: AppColors.LOGO_BACKGROUND_COLOR
                                          .withOpacity(0.3),
                                      thickness: 0.5,
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Product Quantity",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          "2",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      color: AppColors.LOGO_BACKGROUND_COLOR
                                          .withOpacity(0.3),
                                      thickness: 0.5,
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Product Quantity",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          "2",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),*/
                                    Gap(size.height * 0.02),
                                    AppWidgets.customButton(
                                      size: size,
                                      btnName:
                                          "Total: ₹ ${controller.total.value}",
                                      color: AppColors.LOGO_BACKGROUND_COLOR,
                                      func: () {},
                                    ),
                                    Gap(size.height * 0.02),
                                  ],
                                ),
                              ),
                              Gap(size.height * .02),
                            ],
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: const MyCustomBottomNav(
          pageIndex: 2,
        ),
      ),
    );
  }
}
