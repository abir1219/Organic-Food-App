import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:organic_food_new/controllers/cart_controller.dart';
import 'package:organic_food_new/helper/api_end_points.dart';
import 'package:organic_food_new/models/cart_model.dart';
import 'package:organic_food_new/utils/utils.dart';

import '../utils/app_colors.dart';

class CartProductList extends StatelessWidget {
  final CartController controller;
  final List<CartResult> result;

  const CartProductList(
      {super.key, required this.result, required this.controller});

  // List<String> productImage = [
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Obx(
        () => controller.isLoading.value
            ? Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                    color: AppColors.LOGO_BACKGROUND_COLOR, size: size.width * 0.08), //35
              )
            : result.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          _buildCartProductContainer(size, index,context),
                          if (index != result.length - 1)
                            const Divider(
                              color: Colors.grey,
                              thickness: 1,
                            )
                        ],
                      );
                    },
                    itemCount: result.length,
                  )
                : const Center(
                    child: Text(
                      "Cart is empty",
                      style: TextStyle(
                          color: AppColors.LOGO_BACKGROUND_COLOR,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
      ),
    );
  }

  Widget _buildCartProductContainer(Size size, int index,BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
      child: Row(
        children: [
          SizedBox(
            height: size.height * 0.16,
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
                            image: NetworkImage(ApiEndPoints.BASE_LINK +
                                result[index].imageUrl![0]),
                            // image: AssetImage(productImage[index]),
                            fit: BoxFit.fill)),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Container(
            height: size.height * 0.16,
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            result[index].name!,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                          GestureDetector(
                            onTap: () {
                              AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.question,
                                  animType: AnimType.rightSlide,
                                  // title: 'Dialog Title',
                                  desc: 'Remove cart?',
                                  btnCancelOnPress: () {
                                    // Navigator.pop(context);
                                  },
                              btnOkOnPress: () {
                                    controller.updateCart(result[index].sId!, 0);
                                    result.removeAt(index);
                              },
                              ).show();
                            },
                            child: const Icon(
                              Icons.delete,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            result[index].value!,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              height: size.height * 0.04,
                              margin: EdgeInsets.symmetric(
                                  vertical: size.height * 0.01),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: Colors.grey, width: 1)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        if (controller
                                                .cartProdQuantity[index] >
                                            0) {
                                          controller
                                              .cartProdQuantity[index]--;
                                          controller.updateCart(
                                              controller
                                                  .cartProducts[index].sId!,
                                              (controller
                                                      .cartProdQuantity[index] ));
                                        }
                                      },
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
                                          vertical: BorderSide(
                                              width: 1, color: Colors.grey),
                                        ),
                                      ),
                                      child: Center(
                                        child: Obx(() => Text(
                                            "${controller.cartProdQuantity[index]}",
                                            // "${widget.result[index].cartQuantity!}",
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
                                      onTap: () {
                                        if(controller
                                            .cartProducts[index].inStock! >  controller
                                            .cartProdQuantity[index]){
                                          controller
                                              .cartProdQuantity[index]++;
                                          controller.updateCart(
                                              controller
                                                  .cartProducts[index].sId!,
                                              (controller
                                                  .cartProdQuantity[index]));
                                        }else{
                                          Utils.showToastMessage("Not enough quantity to update cart");
                                        }
                                      },
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
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "₹${int.parse(result[index].pricePerUnit!) * (result[index].cartQuantity!)}",
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                  color: AppColors.LOGO_BACKGROUND_COLOR,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
