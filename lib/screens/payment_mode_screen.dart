import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:organic_food_new/controllers/cart_controller.dart';
import 'package:organic_food_new/router/app_pages.dart';
import 'package:organic_food_new/utils/utils.dart';

import '../utils/app_colors.dart';
import '../widgets/app_widgets.dart';

class PaymentModeScreen extends StatefulWidget {
  final CartController controller;
  final String addressId;

  const PaymentModeScreen(
      {super.key, required this.controller, required this.addressId});

  @override
  State<PaymentModeScreen> createState() => _PaymentModeScreenState();
}

class _PaymentModeScreenState extends State<PaymentModeScreen> {
  int _selectedIndex = -1;
  String paymentType = "";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    debugPrint("addressIndex-->${widget.controller.cartIds}");

    return Dialog(
      child: StatefulBuilder(builder: (stfContext, stfSetState) {
        return SizedBox(
          height: size.height * 0.3,
          child: Stack(
            children: [
              Column(
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.05),
                    alignment: Alignment.center,
                    child: const Text(
                      "Mode of payment",
                      style: TextStyle(
                          color: AppColors.LOGO_BACKGROUND_COLOR,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildPaymentModeRadio("COD", 1, size, stfSetState),
                        _buildPaymentModeRadio("Online", 2, size, stfSetState),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.5,
                    child: AppWidgets.customButton(
                      isLoading: _selectedIndex == 1
                          ? widget.controller.isOrdering.value
                          : false,
                      size: size,
                      btnName: "Make Payment",
                      color: AppColors.LOGO_BACKGROUND_COLOR,
                      func: () {
                        debugPrint("---$_selectedIndex");
                        if (_selectedIndex == 1) {
                          widget.controller.placeOrder(
                            widget.addressId,
                            paymentType,
                            (value) {
                              if (value[1] == 201) {
                                Navigator.pop(context);
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    Future.delayed(
                                      const Duration(seconds: 3),
                                      () {
                                        Navigator.of(context)
                                            .pop(true); // Close the dialog
                                        Get.offNamed(
                                            AppPages.ORDER_DETAILS_PAGE,
                                            parameters: {
                                              'orderId': value[0]['result']['_id']
                                            });
                                      },
                                    );
                                    return Dialog(
                                      child: Container(
                                        height: size.height * 0.3,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.3),
                                                  offset:
                                                      const Offset(0.5, 0.5),
                                                  blurRadius: 1.2,
                                                  spreadRadius: 1)
                                            ]),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              "assets/images/celebrate.svg",
                                              height: size.height * 0.15,
                                            ),
                                            Gap(size.height * 0.02),
                                            const Text(
                                              "Order Successfully Placed",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: AppColors
                                                      .LOGO_BACKGROUND_COLOR,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                          );
                          // Future.delayed(const Duration(seconds: 3),() {
                          //   Navigator.pop(context); // Close the dialog
                          //   Get.offNamed(AppPages.ORDER_DETAILS_PAGE);
                          // },);
                        } else if (_selectedIndex == 2) {
                        } else if (_selectedIndex == -1) {
                          Utils.showToastMessage("Select payment mode");
                        }
                      },
                    ),
                  ),
                  Gap(size.height * 0.02)
                ],
              ),
              Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    icon: const Stack(alignment: Alignment.center, children: [
                      Icon(
                        Icons.circle_outlined,
                        size: 28,
                      ),
                      Icon(
                        Icons.close,
                        size: 22,
                      ),
                    ]),
                    onPressed: () {
                      // debugPrint("Exit");
                      Navigator.pop(context);
                    },
                  ))
            ],
          ),
        );
      }),
    );
  }

  Widget _buildPaymentModeRadio(
      String value, int index, Size size, StateSetter stfSetState) {
    return GestureDetector(
      onTap: () {
        setState(() {
          debugPrint("~~~~~TAP~~~~~$_selectedIndex");
          _selectedIndex = index;
        });
        if (index == 1) {
          paymentType = "cod";
        } else if (index == 2) {
          paymentType = "online";
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.height * 0.02),
        height: size.height * 0.06,
        // width: 50,
        // alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  offset: const Offset(0.5, 0.5),
                  blurRadius: 1.2,
                  spreadRadius: 1)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(alignment: Alignment.center, children: [
              const Icon(
                Icons.circle_outlined,
                color: AppColors.LOGO_BACKGROUND_COLOR,
                size: 24,
              ),
              Icon(
                Icons.circle,
                color: _selectedIndex == index
                    ? AppColors.LOGO_BACKGROUND_COLOR
                    : Colors.white,
                size: 18,
              ),
            ]),
            Container(
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.01),
                child: Text(
                  value,
                  style: TextStyle(
                      fontWeight: _selectedIndex == index
                          ? FontWeight.w600
                          : FontWeight.w400,
                      color: _selectedIndex == index
                          ? AppColors.LOGO_BACKGROUND_COLOR
                          : Colors.black,
                      fontSize: 14),
                ))
          ],
        ),
      ),
    );
  }
}
