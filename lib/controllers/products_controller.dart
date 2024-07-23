import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:organic_food_new/models/location_model.dart';
import 'package:organic_food_new/models/products_model.dart';
import 'package:organic_food_new/repository/products_repository.dart';
import 'package:organic_food_new/utils/app_constants.dart';
import 'package:organic_food_new/utils/sharedpreference_utils.dart';
import 'package:organic_food_new/utils/utils.dart';

class ProductsController extends GetxController {
  final _repo = ProductsRepository();
  final Rx<LocationModel> _locationModel = LocationModel().obs;
  final Rx<ProductsModel> productsModel = ProductsModel().obs;

  final RxList<ProductResult> _products = <ProductResult>[].obs;

  RxList<ProductResult> get products => _products;

  final RxList<LocationResult> _locations = <LocationResult>[].obs;

  RxList<LocationResult> get locations => _locations;

  RxList<LocationResult> findLocationResults = <LocationResult>[].obs;
  RxList<String>? cityNameList = <String>[].obs;

  Rx<TextEditingController> locationController = TextEditingController().obs;
  RxBool isClicked = false.obs;

  RxString selectedLocationId = "".obs;
  RxString selectedLocationName = "".obs;

  RxBool isLoading = false.obs;
  RxBool isCityLoading = false.obs;

  RxList<int> quantity = <int>[].obs;

  void selectLocationId(int index) {
    selectedLocationId.value = findLocationResults[index].sId!;
    selectedLocationName.value = findLocationResults[index].city!;
    locationController.value.text = selectedLocationName.value;
    isClicked.value = false;
    getAllProducts(selectedLocationId.value);
  }

  Future<void> getAllLocation() async {
    locations.clear();
    // findLocationResults.clear();
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

  void incrementQuantity(int index) {
    if (quantity[index] < products[index].quantity!) {
      quantity[index]++;
    }
  }

  void decrementQuantity(int index) {
    if (quantity[index] > 0) {
      quantity[index]--;
    }
  }

  Future<void> getAllProducts(String selectedLocationId) async {
    _products.clear();
    isLoading.value = true;
    _repo.getAllProducts(selectedLocationId).then(
      (value) {
        if (value[1] == 200) {
          productsModel.value = ProductsModel.fromJson(value[0]);
          // _products.assignAll(List<ProductResult>.generate(
          //     productsModel.value.result!.length,
          //     (index) => productsModel.value.result![index]));

          _products.assignAll(productsModel.value.result!
              .where((product) => product.quantity! > 0)
              .toList());

          // quantity.assignAll(List<int>.generate(
          //     productsModel.value.result!.length, (index) => 1));

          quantity.assignAll(List<int>.generate(_products.length,
                  (index) => 1));

          // isAddingCart.assignAll(List<bool>.generate(
          //     productsModel.value.result!.length, (index) => false));

          isAddingCart.assignAll(List<bool>.generate(_products.length,
                  (index) => false));
        }
        isLoading.value = false;
      },
    ).onError(
      (error, stackTrace) {
        Utils.showToastMessage(error.toString());
        isLoading.value = false;
      },
    );
  }

  RxList<bool> isAddingCart = <bool>[].obs;

  Future<void> addToCart(String inventoryId,int index) async{
    isAddingCart[index] = true;
    Map<String,dynamic> body = {
    "productId":inventoryId,
    "quantity": quantity[index]
    };
    _repo.addToCart(body).then((value) {
      if(value[1] == 200){
        SharedPreferencesUtils.saveInt(AppConstants.CART_COUNT, value[0]["cartItemCount"]);
        Utils.showToastMessage(value[0]["message"]);
      }else{
        Utils.showToastMessage(value[0]["message"]);
      }
      isAddingCart[index] = false;
    },).onError((error, stackTrace) {
      Utils.showToastMessage(error.toString());
      isAddingCart[index] = false;
    },);
  }
}
//{"message":"Added to cart","cartItemCount":10}