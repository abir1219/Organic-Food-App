import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:organic_food_new/controllers/cart_controller.dart';
import 'package:organic_food_new/router/app_pages.dart';
import 'package:organic_food_new/utils/app_constants.dart';
import 'package:organic_food_new/utils/sharedpreference_utils.dart';
import 'package:organic_food_new/utils/utils.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

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
  String profileName = "";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    debugPrint("addressIndex-->${widget.controller.cartIds}");

    profileName = SharedPreferencesUtils.getString(AppConstants.USER_NAME)!;

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
                          Navigator.pop(context);
                          Razorpay razorpay = Razorpay();
                          var options = {
                            // 'key': 'rzp_live_azPrGD7BGOIuFj', //MotivateU Live key
                            'key': 'rzp_test_cWWpEDrhGv9EmU',  //MotivateU Test key
                            // 'amount': double.parse(controller.subscriptionModel.value.result![index].totalPrice.round().toString()).round() * 100,
                            // 'amount': (controller.subscriptionModel.value.result![index].totalPrice.round() - couponController.discountedPrice.value.round()) * 100,
                            'amount': (widget.controller.total.value) * 100,
                            'name': profileName,
                            // 'orderId' : orderId,
                            'description': 'Organic Food',
                            'retry': {'enabled': true, 'max_count': 1},
                            'send_sms_hash': true,
                            'theme': {
                              'color': '#580E0E'
                              //AppColors.BOTTOM_SHEET_BACKGROUND, // Set your desired color
                            },
                            // 'image': "https://motivateu.in/wp-content/uploads/2023/12/yoast-logo.jpg",
                            //"theme.color": AppColors.BOTTOM_SHEET_BACKGROUND,
                            // 'prefill': {'contact': '$phoneNo', 'email': 'test@razorpay.com'},
                            'prefill': {
                              'contact': '9999999999',
                              'email': 'abcd@gmail.com'
                              //'test@razorpay.com'
                            },
                            'external': {
                              'wallets': ['paytm']
                            }
                          };
                          razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
                              handlePaymentErrorResponse);
                          razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                              handlePaymentSuccessResponse);
                          razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                              handleExternalWalletSelected);
                          try {
                            razorpay.open(options);
                          } catch (e) {
                            print(e.toString());
                          }
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


  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    //showAlertDialog(context, "Payment Failed", "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    debugPrint(
        "~~~Payment Successful~~~\Order ID: ${response.orderId}\nPayment ID: ${response.paymentId}\nSignature: ${response.signature}");
    //showAlertDialog(context, "Payment Successful", "Payment ID: ${response.paymentId}");
    widget.controller.placeOrder(
        widget.addressId,
        paymentType,(value) {
      if (value[1] == 201) {
        // Navigator.pop(context);
        Get.offNamed(
            AppPages.ORDER_DETAILS_PAGE,
            parameters: {
              'orderId': value[0]['result']['_id']
            });
      }
    });
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    // showAlertDialog(
    //     context, "External Wallet Selected", "${response.walletName}");
  }
}
