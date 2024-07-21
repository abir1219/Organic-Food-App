import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:organic_food_new/models/login_model.dart';
import 'package:organic_food_new/repository/login_repository.dart';
import 'package:organic_food_new/router/app_pages.dart';
import 'package:organic_food_new/utils/app_constants.dart';
import 'package:organic_food_new/utils/sharedpreference_utils.dart';
import 'package:organic_food_new/utils/utils.dart';

class LoginController extends GetxController{
  final _loginRepo = LoginRepository();
  Rx<LoginModel> loginData = LoginModel().obs;

  Rx<bool> isLoading = false.obs;

  void validateForm(TextEditingController? _emailControllerl,TextEditingController? _passwordController){
    if(_emailControllerl!.text.trim().toString().isNotEmpty && _passwordController!.text.trim().toString().isNotEmpty){
      login(_emailControllerl.text.trim().toString(), _passwordController.text.trim().toString());
    }else{
      Utils.showSnackBarMsg("Invalid Credentials.");
    }
  }

  Future<void> login(String? email,String? password) async {
    isLoading.value = true;
    try {
      // String url = ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.login;
      // debugPrint("LOGIN_URL======>$url");

      Map<String, dynamic> body = {
        'email': email,
        'password': password
      };

      _loginRepo.login(body).then((value) async {
        if (value[1] == 200) {
          loginData.value = LoginModel.fromJson(value[0]);
          SharedPreferencesUtils.saveString(AppConstants.USERID, loginData.value.data!.sId!);
          SharedPreferencesUtils.saveString(AppConstants.USER_NAME, loginData.value.data!.name!);
          Get.offNamed(AppPages.PRODUCT_PAGE);
        }else{
          Utils.showSnackBarMsg("Invalid Credentials.");
        }
        isLoading.value = false;
      }).onError((error, stackTrace) {
        // if (kDebugMode) alice.showInspector();
        //Utils.showToastMessage(error.toString());
        debugPrint("LOGIN_ERROR===>$error");
        isLoading.value = false;
      });

      // var response = await post(url,jsonEncode(body));
      /*var response = await post(Uri.parse(url), body: jsonEncode(body));
      debugPrint("LOGIN_RESPONSE======>${response.body}");
      debugPrint("LOGIN_statusCode======>${response.statusCode}");
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        debugPrint("Login RES => $json");
      } else {
        //throw jsonDecode(response.body)["message"] ?? "Unknown Error Occurred";
        //Get.snackbar("Login Failed", "",snackPosition: SnackPosition.BOTTOM);
      }*/
    } catch (error) {
      debugPrint("ERROR======>$error");
      isLoading.value = false;
      // Get.back();
    }
  }

}