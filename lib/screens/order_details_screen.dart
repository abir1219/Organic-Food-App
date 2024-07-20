import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:organic_food_new/utils/app_colors.dart';
import 'package:organic_food_new/widgets/app_widgets.dart';
import 'package:organic_food_new/widgets/my_custom_bottom_nav.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
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
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: size.width * 0.02,
                    vertical: size.height * 0.005),
                color: Colors.transparent,
                child: ListView(
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Order Reference",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: AppColors.HINT_TEXT_COLOR),
                        ),
                        Text(
                          "18th July",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: AppColors.HINT_TEXT_COLOR),
                        ),
                      ],
                    ),
                    const Text(
                      "# ORDE12345",
                      style: TextStyle(
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
                    const Text(
                      "A.K. Khanna",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    const Text(
                      "Flat 3A, Block B, Fiona Housing Estate",
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                    const Text(
                      "S.G.B. Street, Kasba Road",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                    const Text(
                      "Kolkata - 700033",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                    Gap(size.height * .01),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: size.height * .01,/*vertical: size.height * .005*/),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.LOGO_BACKGROUND_COLOR,
                          width: 0.5
                        )
                      ),
                      child: Column(
                        children: [
                          Gap(size.height*0.02),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Product Quantity",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                              Text(
                                "2",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          Divider(
                            color: AppColors.LOGO_BACKGROUND_COLOR.withOpacity(0.3),thickness: 0.5,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Product Quantity",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                              Text(
                                "2",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          Divider(
                            color: AppColors.LOGO_BACKGROUND_COLOR.withOpacity(0.3),thickness: 0.5,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Product Quantity",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                              Text(
                                "2",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          Divider(
                            color: AppColors.LOGO_BACKGROUND_COLOR.withOpacity(0.3),thickness: 0.5,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Product Quantity",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                              Text(
                                "2",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          Divider(
                            color: AppColors.LOGO_BACKGROUND_COLOR.withOpacity(0.3),thickness: 0.5,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Product Quantity",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                              Text(
                                "2",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          Divider(
                            color: AppColors.LOGO_BACKGROUND_COLOR.withOpacity(0.3),thickness: 0.5,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Product Quantity",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                              Text(
                                "2",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          Divider(
                            color: AppColors.LOGO_BACKGROUND_COLOR.withOpacity(0.3),thickness: 0.5,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Product Quantity",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                              Text(
                                "2",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          Gap(size.height*0.02),
                          AppWidgets.customButton(size: size, btnName: "Total: ₹621.98", color: AppColors.LOGO_BACKGROUND_COLOR, func: () {

                          },),
                          Gap(size.height*0.02),
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
        pageIndex: 2,
      ),
    );
  }
}
