import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../main.dart';
import 'app_colors.dart';

class Utils {
  static void fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static showToastMessage(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        backgroundColor: AppColors.LOGO_BACKGROUND_COLOR,
        toastLength: Toast.LENGTH_LONG);
  }

  static showSnackBarMsg(String msg) {
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: 10.sp),
            //   height: 15.sp,width: 15.sp,child: const Center(child: CircularProgressIndicator(color: Colors.white,)),),
            Text(msg),
          ],
        ),
        // duration: Duration(seconds: 2), // Adjust the duration as per your requirement
        backgroundColor: Colors.black87,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        dismissDirection: DismissDirection.down,
        duration:const Duration(milliseconds: 1000),
      ),
    );
  }
}
