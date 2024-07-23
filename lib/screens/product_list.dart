import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:organic_food_new/controllers/products_controller.dart';
import 'package:organic_food_new/helper/api_end_points.dart';
import 'package:organic_food_new/utils/app_colors.dart';

import '../widgets/app_widgets.dart';

class ProductList extends StatelessWidget {
  // final String storeLocationId;
  final ProductsController controller;

  const ProductList({
    super.key,
    required this.controller,
    /*required this.storeLocationId*/
  });

  // List<String> productImage = [
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Obx(
        () => controller.isLoading.value
            ? Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
                color: AppColors.LOGO_BACKGROUND_COLOR, size: size.width * 0.08),
                          )
            : NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification notification) {
            notification.disallowIndicator();
            return false;
          },
              child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    debugPrint("LENGTH-->${controller.products.length}");
                    return Column(
                      children: [
                        _buildProductContainer(size, index),
                        if (index != controller.products.length - 1)
                          const Divider(
                            color: Colors.grey,
                            thickness: 1,
                          )
                      ],
                    );
                  },
                  itemCount: controller.products.length//productImage.length,
                ),
            ),
      ),
    );
  }

  Widget _buildProductContainer(Size size, int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
      child: Row(
        children: [
          SizedBox(
            height: size.height * 0.2,
            width: size.width * 0.32,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    // height: size.height * 0.15,
                    // width: size.width * 0.35,
                    // color: Colors.green,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(ApiEndPoints.BASE_LINK+controller.products[index].productvariant!.product!.imageUrl![0]),//imageUrl
                            // image: AssetImage(productImage[index]),
                            fit: BoxFit.fill)),
                  ),
                ),
                Container(
                  height: size.height * 0.04,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 1)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.decrementQuantity(index),
                          child: const SizedBox(
                            //width: size.width * .05,
                            child: Center(
                              child: Text(
                                "-",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border.symmetric(
                              vertical:
                                  BorderSide(width: 1, color: Colors.grey),
                            ),
                          ),
                          child: Center(
                            child: Obx(() => Text(
                                "${controller.quantity[index]}",
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.incrementQuantity(index),
                          child: const SizedBox(
                            //width: size.width * .05,
                            child: Center(
                              child: Text(
                                "+",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: Container(
            height: size.height * 0.2,
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        controller.products[index].productvariant!.product!.name!,
                        //productName[index],
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        controller.products[index].productvariant!.value!,
                        // productVariant[index],
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w300),
                      ),
                      Text(
                          controller.products[index].productvariant!.product!.description!,
                        // productDescription[index],
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w300),
                      ),
                      Text(
                        "₹${controller.products[index].productvariant!.price!}",
                        // "₹${productPrice[index].toString()}",
                        style: const TextStyle(
                            color: AppColors.LOGO_BACKGROUND_COLOR,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: size.width * 0.2),
                  child: Obx(() => AppWidgets.customButton(
                      size: size,
                      btnName: "Add to Cart",
                      color: AppColors.LOGO_BACKGROUND_COLOR,
                      isLoading: controller.isAddingCart[index],
                      func: () => controller.addToCart(controller.products[index].inventoryId!,index),
                    ),
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
