import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organic_food_new/router/app_pages.dart';
import 'package:organic_food_new/router/app_routers.dart';


final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  //Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      getPages: AppRouters.pages,
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      initialRoute: AppPages.SPLASH_SCREEN,
      theme: ThemeData(
        fontFamily: "Montserrat",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
