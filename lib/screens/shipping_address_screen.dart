import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:organic_food_new/controllers/cart_controller.dart';
import 'package:organic_food_new/router/app_pages.dart';
import 'package:organic_food_new/utils/app_constants.dart';
import 'package:organic_food_new/utils/sharedpreference_utils.dart';
import 'package:organic_food_new/widgets/app_widgets.dart';

import '../utils/app_colors.dart';

class ShippingAddressScreen extends StatefulWidget {
  const ShippingAddressScreen({super.key});

  @override
  State<ShippingAddressScreen> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {

  var controller = Get.find<CartController>();
  @override
  void initState() {
    super.initState();
    controller.getAllAddress();
  }

/*
  final List<String> addresses = [
    '123 Main St, Springfield, IL 62704',
    '456 Elm St, Chicago, IL 60616',
    '789 Maple Ave, Evanston, IL 60201',
    '123 Main St, Springfield, IL 62704',
    '456 Elm St, Chicago, IL 60616',
    '789 Maple Ave, Evanston, IL 60201',
    '123 Main St, Springfield, IL 62704',
    '456 Elm St, Chicago, IL 60616',
    '789 Maple Ave, Evanston, IL 60201',
    '123 Main St, Springfield, IL 62704',
    '456 Elm St, Chicago, IL 60616',
    '789 Maple Ave, Evanston, IL 60201',
  ];
  String? _selectedAddress;*/

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
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Select Address",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.LOGO_BACKGROUND_COLOR),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(() => controller.isAddressLoading.value?
              Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                    color: AppColors.LOGO_BACKGROUND_COLOR, size: size.width * 0.08), //35
              )
              :ListView.builder(itemBuilder: (context, index) {
                  return RadioListTile<String>(
                    title: Text("${SharedPreferencesUtils.getString(AppConstants.USER_NAME)}",style: const TextStyle(
                      color: Colors.black,fontWeight: FontWeight.w600,fontSize: 14,
                    ),),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${controller.addresses[index].address!},",style: const TextStyle(
                          fontWeight: FontWeight.w400,fontSize: 14,
                        ),),
                        Text("${controller.addresses[index].city!}-${controller.addresses[index].pincode!},",style: const TextStyle(
                          fontWeight: FontWeight.w400,fontSize: 14,
                        ),),
                        Text(controller.addresses[index].state!,style: const TextStyle(
                          fontWeight: FontWeight.w400,fontSize: 14,
                        ),),
                      ],
                    ),
                    value: controller.addresses[index].sId!,
                    groupValue: controller.addressId.value,//controller.addressId[0],//controller.addressId.value,
                    onChanged: (value) {
                      controller.addressId.value = value!;
                      debugPrint("VALUE-->$value");
                      // controller.addressId.add(value!);
                    },
                  );
                },itemCount: controller.addresses.length,),
              ),
              /*ListView(
                children: addresses.map((address) => RadioListTile<String>(
                  title: Text(address),
                  value: address,
                  groupValue: _selectedAddress,
                  onChanged: (value) {
                    setState(() {
                      _selectedAddress = value;
                    });
                  },
                )).toList(),
              ),*/
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: AppWidgets.customButton(size: size, btnName: "DELIVER HERE", color: AppColors.LOGO_BACKGROUND_COLOR, func: () {
                Get.offNamed(AppPages.ORDER_SUMMARY_PAGE);
              },),
            ),
            Gap(size.height * 0.02),
          ],
        ),
      ),
    );
  }
}
