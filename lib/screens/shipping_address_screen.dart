import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:organic_food_new/router/app_pages.dart';
import 'package:organic_food_new/widgets/app_widgets.dart';

import '../utils/app_colors.dart';

class ShippingAddressScreen extends StatefulWidget {
  const ShippingAddressScreen({super.key});

  @override
  State<ShippingAddressScreen> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {


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
  String? _selectedAddress;

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
              child: ListView(
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
              ),
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
