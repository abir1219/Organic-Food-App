import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CartProductList extends StatefulWidget {
  const CartProductList({super.key});

  @override
  State<CartProductList> createState() => _CartProductListState();
}

class _CartProductListState extends State<CartProductList> {
  List<String> productImage = [
    "assets/images/chicken.png",
    "assets/images/pea.png",
    "assets/images/sausage.png",
  ];

  List<String> productName = ["Frozen Chicken", "Frozen pea Packet", "Sausage"];

  List<String> productVariant = ["500gm", "1Kg", "500gm"];

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
              _buildCartProductContainer(size, index),
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

  Widget _buildCartProductContainer(Size size, int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
      child: Row(
        children: [
          SizedBox(
            height: size.height * 0.16,
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
              ],
            ),
          ),
          Expanded(
              child: Container(
            height: size.height * 0.16,
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            productName[index],
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                          GestureDetector(
                            onTap: () {

                            },
                            child: const Icon(
                              Icons.delete,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            productVariant[index],
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              height: size.height * 0.04,
                              margin: EdgeInsets.symmetric(
                                  vertical: size.height * 0.01),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: Colors.grey, width: 1)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Expanded(
                                    child: SizedBox(
                                      //width: size.width * .05,
                                      child: Center(
                                        child: Text(
                                          "-",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        border: Border.symmetric(
                                          vertical: BorderSide(
                                              width: 1, color: Colors.grey),
                                        ),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "1",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Expanded(
                                    child: SizedBox(
                                      //width: size.width * .05,
                                      child: Center(
                                        child: Text(
                                          "+",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "₹${productPrice[index].toString()}",
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                  color: AppColors.LOGO_BACKGROUND_COLOR,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
