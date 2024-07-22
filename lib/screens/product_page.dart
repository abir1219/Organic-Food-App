import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:organic_food_new/controllers/products_controller.dart';
import 'package:organic_food_new/screens/product_list.dart';
import 'package:organic_food_new/utils/app_constants.dart';
import 'package:organic_food_new/utils/sharedpreference_utils.dart';

import '../utils/app_colors.dart';
import '../widgets/my_custom_bottom_nav.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  var controller = Get.find<ProductsController>();

  @override
  void initState() {
    super.initState();
    controller.getAllLocation();
  }

  // bool isClicked = false;

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
            Gap(size.height * 0.01),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.height * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => controller.selectedLocationName.value != ""
                          ? Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: size.height * 0.01),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.place,
                                    color: AppColors.LOGO_BACKGROUND_COLOR,
                                    size: 20,
                                  ),
                                  Expanded(
                                      child: Text(
                                    "${controller.selectedLocationName.value}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: AppColors.LOGO_BACKGROUND_COLOR,
                                        fontWeight: FontWeight.w600),
                                  ))
                                ],
                              ),
                            )
                          : Container(),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Search store location to add product",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                        Gap(size.height * 0.01),
                        Container(
                          // height: size.height * 0.05,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 0.5,
                                  blurRadius: 1,
                                  offset: const Offset(.5, 0.5),
                                )
                              ]),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Obx(
                                  () => TextField(
                                    controller:
                                        controller.locationController.value,
                                    // onTap: () {
                                    //   controller.isClicked.value =
                                    //       !controller.isClicked.value;
                                    // },
                                    onChanged: (value) {
                                      controller.isClicked.value = true;
                                      if (controller.locationController.value
                                          .text.isEmpty) {
                                        debugPrint("Clear");
                                        controller.findLocationResults.clear();
                                      } else {
                                        debugPrint("HAVE");
                                        controller.cityFilter(controller
                                            .locationController.value.text
                                            .trim()
                                            .toString());
                                      }
                                    },
                                    decoration: InputDecoration(
                                        hintText: "Search store location...",
                                        contentPadding: EdgeInsets.only(
                                            left: size.width * 0.02),
                                        hintStyle: const TextStyle(
                                          color: AppColors.HINT_TEXT_COLOR,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        border: InputBorder.none),
                                  ),
                                ),
                              ),
                              Container(
                                height: size.height * 0.06, //46,
                                width: size.width * 0.12,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                    ),
                                    color: AppColors.LOGO_BACKGROUND_COLOR),
                                child: const Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Stack(
                        // alignment: Alignment.center,
                        children: [
                          Obx(
                            () => controller.productsModel.value.result != null
                                ? ProductList(
                                    controller: controller,
                                    //storeLocationId: '1234',
                                  )
                                : const Center(
                                    child: Text(
                                      "No records found. Search location to continue...",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                          ),
                          Obx(
                            () => controller.isClicked.value &&
                                    controller.locationController.value.text
                                        .isNotEmpty &&
                                    controller.findLocationResults.isNotEmpty
                                ? ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxHeight: size.height * .3,
                                    ),
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: size.height * 0.01),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              offset: const Offset(0.5, 0.5),
                                              blurRadius: 1.2,
                                              spreadRadius: 1,
                                            ),
                                          ]),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          // debugPrint("hitttt--${controller.locationController.value.text.isNotEmpty}");
                                          return GestureDetector(
                                            onTap: () => controller
                                                .selectLocationId(index),
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: size.height * 0.01),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      size.height * 0.01),
                                              child: controller
                                                      .locationController
                                                      .value
                                                      .text
                                                      .isNotEmpty
                                                  ? Text(controller
                                                      .findLocationResults[
                                                          index]
                                                      .city!)
                                                  : Text(controller
                                                      .locations[index].city!),
                                            ),
                                          );
                                        },
                                        itemCount: controller.locationController
                                                .value.text.isNotEmpty
                                            ? controller
                                                .findLocationResults.length
                                            : controller.locations.length,
                                      ),
                                    ),
                                  )
                                : Container(),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const MyCustomBottomNav(
        pageIndex: 0,
        // badgeCount: SharedPreferencesUtils.containsKey(AppConstants.CART_COUNT)
        //     ? SharedPreferencesUtils.getInt(AppConstants.CART_COUNT)!
        //     : 0,
      ),
    );
  }
}
