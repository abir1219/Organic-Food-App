import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:organic_food_new/controllers/order_controller.dart';
import 'package:organic_food_new/helper/api_end_points.dart';
import 'package:organic_food_new/router/app_pages.dart';
import 'package:organic_food_new/utils/app_colors.dart';
import 'package:organic_food_new/widgets/my_custom_bottom_nav.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  var controller = Get.find<OrderController>();

  @override
  void initState() {
    super.initState();
    controller.getOrderList();
  }

  List<String> productImage = [
    "assets/images/chicken.png",
    "assets/images/pea.png",
    "assets/images/sausage.png",
  ];

  List<String> productName = ["Frozen Chicken", "Frozen pea Packet", "Sausage"];

  List<String> productVariant = ["500gm", "1Kg", "500gm"];

  List<String> productDescription = [
    "Lorem ipsum dolor sit  amet, consectetur adipiscing elit, sed do eiusmod tempor...",
    "Lorem ipsum dolor sit  amet, consectetur adipiscing elit, sed do eiusmod tempor...",
    "Lorem ipsum dolor sit  amet, consectetur adipiscing elit, sed do eiusmod tempor...",
  ];

  List<double> productPrice = [196.39, 425.59, 450.00];

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
        Get.offNamed(AppPages.PRODUCT_PAGE);
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
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(
                    horizontal: size.width * 0.02,
                    vertical: size.height * 0.005),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order List",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.LOGO_BACKGROUND_COLOR),
                    ),
                    Divider(
                      color: AppColors.LOGO_BACKGROUND_COLOR,
                      thickness: 0.5,
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: size.width * 0.02,
                    vertical: size.height * 0.005),
                color: Colors.transparent,
                child: Obx(
                  () => controller.isLoading.value
                      ? Center(
                          child: LoadingAnimationWidget.staggeredDotsWave(
                              color: AppColors.LOGO_BACKGROUND_COLOR,
                              size: size.width * 0.08), //35
                        )
                      : NotificationListener<OverscrollIndicatorNotification>(
                          onNotification:
                              (OverscrollIndicatorNotification notification) {
                            notification.disallowIndicator();
                            return false;
                          },
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return _orderContainerBuilder(size, index);
                            },
                            itemCount:
                                controller.orders.length, //productPrice.length,
                          ),
                        ),
                ),
              ))
            ],
          ),
        ),
        bottomNavigationBar: const MyCustomBottomNav(
          pageIndex: 2,
        ),
      ),
    );
  }

  Widget _orderContainerBuilder(Size size, int index) {
    return GestureDetector(
      onTap: () => Get.offNamed(AppPages.ORDER_DETAILS_PAGE,
          parameters: {'orderId': controller.orders[index].sId!}),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1.2,
                offset: const Offset(0.5, 0.5),
                blurRadius: 0.5,
              )
            ]),
        height: size.height * 0.16,
        margin: EdgeInsets.symmetric(
            horizontal: size.width * 0.02, vertical: size.height * 0.005),
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.02, vertical: size.height * 0.005),
        child: Row(
          children: [
            Container(
              height: size.height * 0.16,
              width: size.width * 0.35,
              // color: Colors.green,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                      // image: AssetImage(productImage[index]), fit: BoxFit.fill)),
                      image: NetworkImage(ApiEndPoints.BASE_LINK +
                          controller.orders[index].orderItems![0].imageUrl![0]),
                      fit: BoxFit.fill)),
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    controller.orders[index].orderItems![0].productName!,
                    //productName[index],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                  Gap(size.height * 0.005),
                  Text(
                    controller.orders[index].orderItems![0].value!,
                    // productVariant[index],
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Colors.black),
                  ),
                  Gap(size.height * 0.005),
                  Text(
                    controller.orders[index].orderItems![0].productDescription!,
                    //productDescription[index],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Colors.black),
                  ),
                  Gap(size.height * 0.005),
                  Text(
                    "₹ ${controller.orders[index].orderItems![0].totalPrice!.toString()}",
                    //"₹${productPrice[index]}",
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: AppColors.LOGO_BACKGROUND_COLOR),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
