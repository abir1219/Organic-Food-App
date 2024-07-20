import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:organic_food_new/screens/product_list.dart';

import '../utils/app_colors.dart';
import '../widgets/my_custom_bottom_nav.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

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
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.height * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
                    child: const Row(
                      children: [
                        Icon(Icons.place,color: AppColors.LOGO_BACKGROUND_COLOR,size: 20,),
                        Expanded(child: Text("Kolkata",maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 14,color: AppColors.LOGO_BACKGROUND_COLOR,fontWeight: FontWeight.w600),))
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          "Search store location to add product",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ),
                      Gap(size.height * 0.01),
                      Container(
                        // height: size.height * 0.05,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 0.5,
                                blurRadius: 1,
                                offset: const Offset(.5, 0.5),
                              )
                            ]),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                    hintText: "Search store location...",
                                    contentPadding: EdgeInsets.only(
                                        left: size.width * 0.02),
                                    hintStyle: const TextStyle(
                                      color: AppColors.HINT_TEXT_COLOR,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    border: InputBorder.none),
                              ),
                            ),
                            Container(
                              height: size.height * 0.06, //46,
                              width: size.width * 0.12,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                  ),
                                  color: AppColors.LOGO_BACKGROUND_COLOR),
                              child: const Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Expanded(
                    child: ProductList(storeLocationId: '1234',)
                    /*Center(
                      child: Text("No records found. Search location to continue...",textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14,color: Colors.black),),
                    ),*/
                  )
                ],
              ),
            ))
          ],
        ),
      ),
      bottomNavigationBar: const MyCustomBottomNav(pageIndex: 0,),
    );
  }
}
