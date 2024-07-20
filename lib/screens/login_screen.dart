import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:organic_food_new/utils/app_colors.dart';

import '../router/app_pages.dart';
import '../widgets/app_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.sizeOf(context);
    final userIdController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: Column(
        children: [
          Container(
            height: size.height * 0.25,
            width: size.width,
            decoration: const BoxDecoration(
                color: AppColors.LOGO_BACKGROUND_COLOR,
                image: DecorationImage(
                  image: AssetImage("assets/images/doodle_bg.png"),
                  fit: BoxFit.cover,
                ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SvgPicture.asset("assets/images/logo.svg",height: size.height * 0.12,),
                ),
                Gap(size.height * 0.01),
                const Text("WELCOME",style: TextStyle(color: Colors.white,fontSize: 14),),
                const Text("Please login to continue",style: TextStyle(color: Colors.white,fontSize: 12),),
              ],
            ),
          ),
          Expanded(child: Center(child: Container(
            margin: EdgeInsets.symmetric(horizontal: size.height * 0.01),
            padding: EdgeInsets.symmetric(horizontal: size.height * 0.02),
            height: size.height * 0.35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.LOGIN_BACKGROUND_COLOR.withOpacity(0.3),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildField(size: size, hint: 'User id', controller: userIdController, icon:const Icon(Icons.person), obscureText: false),
                _buildField(size: size, hint: 'Password', controller: passwordController, icon:const Icon(Icons.visibility), obscureText: true),
                Gap(size.height * 0.02),
                AppWidgets.customButton(size: size, btnName: 'Login', color: AppColors.LOGO_BACKGROUND_COLOR, func: () {
                  context.go(AppPages.PRODUCT_PAGE);
                })
              ],
            ),
          ),),)
        ],
      ),),
    );
  }

  Widget _buildField({required Size size,required String hint,required TextEditingController controller,required Icon icon,required bool obscureText}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * .005),
      padding: EdgeInsets.symmetric(horizontal: size.height * .008), //,vertical: 2
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.LOGO_BACKGROUND_COLOR,
            width: 0.5,
          )),
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
            icon: icon,
            hintText: hint,
            hintStyle: const TextStyle(
              color: AppColors.HINT_TEXT_COLOR,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            border: InputBorder.none),
      ),
    );
  }

}
