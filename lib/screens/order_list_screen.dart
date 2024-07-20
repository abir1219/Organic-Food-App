import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:organic_food_new/utils/app_colors.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
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
          ],
        ),
      ),
    );
  }
}
