import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:organic_food_new/utils/sharedpreference_utils.dart';

import '../router/app_pages.dart';
import '../utils/app_colors.dart';
import '../utils/app_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initSharedPref();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  void initSharedPref() async {
    await SharedPreferencesUtils.init();
    Future.delayed(
      const Duration(seconds: 2),
      () {
        if (SharedPreferencesUtils.containsKey(AppConstants.USERID)) {
          Get.offAllNamed(AppPages.PRODUCT_PAGE);
        }else{
          Get.offAllNamed(AppPages.LOGIN_PAGE);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: AppColors.LOGO_BACKGROUND_COLOR,
      body: SafeArea(
          child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/doodle_bg.png"),
          fit: BoxFit.cover,
        )),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SvgPicture.asset("assets/images/logo.svg"),
              ),
            ),
            Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.white, size: size.width * 0.08), //35
            ),
            Gap(MediaQuery.sizeOf(context).height * 0.01)
          ],
        ),
      )),
    );
  }
}
