import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organic_food_new/models/location_model.dart';
import 'package:organic_food_new/repository/products_repository.dart';
import 'package:organic_food_new/utils/utils.dart';

class ProductsController extends GetxController {
  final _repo = ProductsRepository();
  final Rx<LocationModel> _locationModel = LocationModel().obs;

  final RxList<LocationResult> _locations = <LocationResult>[].obs;

  RxList<LocationResult> get locations => _locations;

  RxList<LocationResult> findLocationResults = <LocationResult>[].obs;
  RxList<String>? cityNameList = <String>[].obs;

  RxBool isLoading = false.obs;
  RxBool isCityLoading = false.obs;

  Future<void> getAllLocation() async {
    locations.clear();
    isCityLoading.value = true;
    // Utils.showSnackBarMessageWithLoader("Loading Schools...");
    // Utils.showToastMessage("Loading Schools...");
    _repo.getAllLocation().then((value) {
      debugPrint("data-->${value[1]}");
      if (value[1] == 200) {
        isCityLoading.value = false;
        _locationModel.value = LocationModel.fromJson(value[0]);
        _locations.assignAll(List<LocationResult>.generate(
            _locationModel.value.result!.length,
            (index) => _locationModel.value.result![index]));
        cityNameList!.assignAll(List<String>.generate(
            _locationModel.value.result!.length,
            (index) => _locationModel.value.result![index].city!));
      }
      // ScaffoldMessenger.of(navigatorKey67.currentContext!).hideCurrentSnackBar();
    }).onError((error, stackTrace) {
      isCityLoading.value = false;
      // ScaffoldMessenger.of(navigatorKey.currentContext!).hideCurrentSnackBar();
      Utils.showToastMessage(error.toString());
    });
  }

  void cityFilter(String enteredKeyword) {
    debugPrint("enteredKeyword--->$enteredKeyword");
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      //results = _allUsers;
    } else {
      debugPrint("cityResult--Length ===> ${locations.length}");
      findLocationResults.clear();
      findLocationResults.value = locations
          .where((user) =>
              // user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
              user.city!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    debugPrint("findCityResults--Length ===> ${findLocationResults.length}");
  }
}
