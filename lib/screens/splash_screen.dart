import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../router/app_pages.dart';
import '../utils/app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 2),
      () => context.go(AppPages.LOGIN),
    );



    return Scaffold(
      backgroundColor: AppColors.LOGO_BACKGROUND_COLOR,
      body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/doodle_bg.png"),
                fit: BoxFit.cover,
              )
            ),
            child: Column(
                    children: [
            Expanded(
              child: Center(
                child: SvgPicture.asset("assets/images/logo.svg"),
              ),
            ),
            Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.white, size: 35),
            ),
            Gap(MediaQuery.sizeOf(context).height * 0.01)
                    ],
                  ),
          )),
    );
  }
}
