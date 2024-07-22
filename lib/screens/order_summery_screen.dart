import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:organic_food_new/screens/payment_mode_screen.dart';
import 'package:organic_food_new/utils/app_colors.dart';
import 'package:organic_food_new/widgets/app_widgets.dart';

import 'cart_product_list.dart';

class OrderSummaryScreen extends StatefulWidget {
  const OrderSummaryScreen({super.key});

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  List<String> productImage = [
    "assets/images/chicken.png",
    "assets/images/pea.png",
    "assets/images/sausage.png",
  ];

  List<String> productName = ["Frozen Chicken", "Frozen pea Packet", "Sausage"];

  List<String> productVariant = ["500gm", "1Kg", "500gm"];

  List<double> productPrice = [196.39, 425.59, 450.00];


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    debugPrint("Enter");

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
                  const Text(
                    "Cart (3)",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.LOGO_BACKGROUND_COLOR,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Gap(size.height * 0.01),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Row(
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
                    ),
                    Container(
                      color: Colors.transparent,
                      width: size.width,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ship to",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.LOGO_BACKGROUND_COLOR),
                            ),
                            Text(
                              "A.K. Khanna",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            Text(
                              "Flat 3A, Block B, Fiona Housing Estate",
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                            Text(
                              "S.G.B. Street, Kasba Road",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                            Text(
                              "Kolkata - 700033",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Gap(size.height * 0.01),
                    // Expanded(
                    //   child: CartProductList(result: [],),
                    // ),
                    Container(
                      // margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                      height: size.height * 0.17,
                      width: size.height * 0.45,
                      padding: EdgeInsets.symmetric(
                          vertical: size.height * 0.01,
                          horizontal: size.height * 0.01),
                      decoration: BoxDecoration(
                        color:
                            AppColors.LOGIN_BACKGROUND_COLOR.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Price Details (2 items)",
                            style: TextStyle(
                                fontSize: 14,
                                color: AppColors.LOGO_BACKGROUND_COLOR,
                                fontWeight: FontWeight.w600),
                          ),
                          // const Divider(
                          //   color: AppColors.LOGO_BACKGROUND_COLOR,
                          // ),
                          _buildPricingDetails(size, "Total MRP", "₹ 621.98",
                              false, Colors.black),
                          _buildPricingDetails(size, "Discount on MRP",
                              " ₹ -00.00", false, Colors.black),
                          _buildPricingDetails(size, "Shipping Fee", " ₹ 00.00",
                              false, Colors.black),
                          const Divider(
                            color: AppColors.LOGO_BACKGROUND_COLOR,
                          ),
                          _buildPricingDetails(size, "Total Amount", "₹ 621.98",
                              true, Colors.black),
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
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const PaymentModeScreen();
                            },
                          );
                        },
                      ),
                    ),
                    Gap(size.height * 0.01),
                  ],
                ),
              ),
            )
          ],
        ),
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
