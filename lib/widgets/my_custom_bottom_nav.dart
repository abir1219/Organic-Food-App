import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:organic_food_new/router/app_pages.dart';
import 'package:organic_food_new/utils/app_colors.dart';

class MyCustomBottomNav extends StatefulWidget {
  final int pageIndex;
  final int badgeCount;

  const MyCustomBottomNav(
      {super.key, required this.pageIndex, this.badgeCount = 0});

  @override
  State<MyCustomBottomNav> createState() => _State();
}

class _State extends State<MyCustomBottomNav> {
  int _currentIndex = 0;

  @override
  void initState() {
    setState(() {
      _currentIndex = widget.pageIndex;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // int _badgeCount = 15;
    var size = MediaQuery.sizeOf(context);

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 5.0,
      clipBehavior: Clip.antiAlias,
      color: Colors.transparent,
      //AppColors.LOGO_BACKGROUND_COLOR,
      elevation: 0,
      child: SizedBox(
          height: kBottomNavigationBarHeight, //size.height * 0.05,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.LOGO_BACKGROUND_COLOR,
            currentIndex: _currentIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              debugPrint("index--->$index");
              if(index == 0) {
                context.go(AppPages.PRODUCT_PAGE);
              }else if(index == 1) {
                context.go(AppPages.CART_PAGE);
              }else if(index == 2) {
                context.go(AppPages.PRODUCT_PAGE);
              }else if(index == 3) {
                context.go(AppPages.PRODUCT_PAGE);
              }
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Stack(
                  children: [
                    const Icon(Icons.shopping_cart_outlined),
                    if (widget.badgeCount > 0)
                      Positioned(
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(1),
                          decoration: const BoxDecoration(
                              color: AppColors.BADGE_COLOR,
                              // borderRadius: BorderRadius.circular(6),
                              shape: BoxShape.circle),
                          constraints: BoxConstraints(
                            minWidth: size.width * 0.035, //12,
                            minHeight: size.height * 0.015, //12,
                          ),
                          child: Center(
                            child: Text(
                              widget.badgeCount > 9
                                  ? '9+'
                                  : '${widget.badgeCount}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: widget.badgeCount > 9 ? 8 : 10,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Stack(children: [
                  SvgPicture.asset("assets/images/order.svg",
                    colorFilter: ColorFilter.mode(
                        _currentIndex == 2 ? Colors.white : Colors.grey,
                        BlendMode.srcIn),)
                ]), //Icon(Icons.favorite_border_outlined),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Stack(children: [
                  SvgPicture.asset(
                    "assets/images/logout.svg",
                    colorFilter: ColorFilter.mode(
                        _currentIndex == 3 ? Colors.white : Colors.grey,
                        BlendMode.srcIn),
                  )
                ]),
                //Icon(Icons.logout),
                label: '',
              ),
            ],
          )),
    );
  }
}
