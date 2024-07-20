import 'package:flutter/material.dart';
import 'package:organic_food_new/utils/app_colors.dart';

import '../widgets/app_widgets.dart';

class ProductList extends StatefulWidget {
  final String storeLocationId;

  const ProductList({super.key, required this.storeLocationId});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<String> productImage = [
    "assets/images/chicken.png",
    "assets/images/pea.png",
    "assets/images/sausage.png",
  ];

  List<String> productName = ["Frozen Chicken", "Frozen pea Packet", "Sausage"];

  List<String> productVariant = ["500gm", "1Kg", "500gm"];

  List<String> productDescription = [
    "Lorem ipsum dolor sit  amet, consectetur adipiscing elit, sed do eiusmod tempor...",
    "Lorem ipsum dolor sit  amet, consectetur adipiscing elit, sed do eiusmod tempor...",
    "Lorem ipsum dolor sit  amet, consectetur adipiscing elit, sed do eiusmod tempor...",
  ];

  List<double> productPrice = [196.39, 425.59, 450.00];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Column(
            children: [
              _buildProductContainer(size, index),
              if (index != productImage.length - 1)
                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                )
            ],
          );
        },
        itemCount: productImage.length,
      ),
    );
  }

  Widget _buildProductContainer(Size size, int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
      child: Row(
        children: [
          SizedBox(
            height: size.height * 0.2,
            width: size.width * 0.32,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    // height: size.height * 0.15,
                    // width: size.width * 0.35,
                    // color: Colors.green,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(productImage[index]),
                            fit: BoxFit.fill)),
                  ),
                ),
                Container(
                  height: size.height * 0.04,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 1)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: SizedBox(
                          //width: size.width * .05,
                          child: Center(
                            child: Text("-",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.black),),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border.symmetric(
                              vertical:
                                  BorderSide(width: 1, color: Colors.grey),
                            ),
                          ),
                          child: const Center(
                            child: Text("1",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.black),),
                          ),
                        ),
                      ),
                      const Expanded(
                        child: SizedBox(
                          //width: size.width * .05,
                          child: Center(
                            child: Text("+",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.black),),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: Container(
            height: size.height * 0.2,
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        productName[index],
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        productVariant[index],
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w300),
                      ),
                      Text(
                        productDescription[index],
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w300),
                      ),
                      Text(
                        "₹${productPrice[index].toString()}",
                        style: const TextStyle(
                            color: AppColors.LOGO_BACKGROUND_COLOR,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: size.width * 0.2),
                  child: AppWidgets.customButton(size: size, btnName: "Add to Cart", color: AppColors.LOGO_BACKGROUND_COLOR, func: () => null,),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
