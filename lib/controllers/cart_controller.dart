import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organic_food_new/models/cart_model.dart';
import 'package:organic_food_new/models/shipping_address_model.dart';
import 'package:organic_food_new/repository/cart_repository.dart';

import '../utils/utils.dart';

class CartController extends GetxController {
  final _repo = CartRepository();

  final Rx<CartModel> cartModel = CartModel().obs;
  final Rx<ShippingAddressModel> shippingAddressModel =
      ShippingAddressModel().obs;

  final RxList<CartResult> _cartProducts = <CartResult>[].obs;

  RxList<CartResult> get cartProducts => _cartProducts;

  final RxList<ShippingAddressResult> _addresses =
      <ShippingAddressResult>[].obs;

  RxList<ShippingAddressResult> get addresses => _addresses;

  RxString addressId = "".obs;
  RxInt selectedAddressIndex = 0.obs;

  final RxList<String> _cartIds = <String>[].obs;

  RxList<String> get cartIds => _cartIds;

  RxBool isLoading = false.obs;

  RxInt total = 0.obs;
  RxList<int> cartProdQuantity = <int>[].obs;

  Future<void> getAllCarts() async {
    _cartProducts.clear();
    cartProducts.clear();
    total.value = 0;
    isLoading.value = true;
    _repo.getCartList().then(
      (value) {
        if (value[1] == 200) {
          cartModel.value = CartModel.fromJson(value[0]);
          //_cartProducts.assignAll(List<CartResult>.generate(cartModel.value.result!.length, (index) => cartModel.value.result![index]).where((product) => product.cartQuantity! > 0).toList());
          _cartProducts.assignAll(cartModel.value.result!
              .where((product) => product.cartQuantity! >= 1)
              .toList());

          for (int i = 0; i < _cartProducts.length; i++) {
            _cartIds.add(_cartProducts[i].sId!);
          }
          debugPrint("LENGTH001-->$_cartIds");

          // debugPrint("LENGTH001-->${cartModel.value.result!.length}");
          // debugPrint("LENGTH-->${_cartProducts.length}");
          cartProdQuantity.assignAll(List<int>.generate(_cartProducts.length,
              (index) => _cartProducts[index].cartQuantity!));
          for (int i = 0; i < _cartProducts.length; i++) {
            total.value +=
                int.parse(_cartProducts[i].pricePerUnit!) * cartProdQuantity[i];
          }
        }
        isLoading.value = false;
      },
    ).onError(
      (error, stackTrace) {
        Utils.showToastMessage(error.toString());

        debugPrint("GET_CART-->$error");
        isLoading.value = false;
      },
    );
  }

  Future<void> updateCart(String cartId, int quantity) async {
    // isLoading.value = true;
    Map<String, dynamic> body = {"quantity": quantity};
    _repo.updateCart(body, cartId).then(
      (value) {
        if (value[1] == 200) {
          getAllCarts();
          Utils.showToastMessage("Cart updated successfully.");
        }
      },
    ).onError(
      (error, stackTrace) {
        Utils.showToastMessage(error.toString());
        debugPrint("UPDATE_CART-->$error");
        // isLoading.value = false;
      },
    );
  }

  RxBool isAddressLoading = false.obs;

  Future<void> getAllAddress() async {
    _addresses.clear();
    addresses.clear();
    isAddressLoading.value = true;
    _repo.getAddressList().then(
      (value) {
        if (value[1] == 200) {
          shippingAddressModel.value = ShippingAddressModel.fromJson(value[0]);
          _addresses.assignAll(List<ShippingAddressResult>.generate(
              shippingAddressModel.value.result!.length,
              (index) => shippingAddressModel.value.result![index]));
        }
        isAddressLoading.value = false;
      },
    ).onError(
      (error, stackTrace) {
        isAddressLoading.value = false;
        Utils.showToastMessage(error.toString());
        debugPrint("GET_SHIPPING_ADDRESS_ERROR-->$error");
      },
    );
  }

  RxBool isOrdering = false.obs;
  Future<void> placeOrder(String addressId,String paymentMode,void Function(dynamic value) func) async{
    isOrdering.value = true;
    Map<String,dynamic> body = {
      "cartItems": cartIds,
      "addressId": addressId,
      "paymentType": paymentMode
    };

    debugPrint("PAYMENT_BODY-->$body");
    _repo.placeOrder(body).then((value) {
      func(value);
      isOrdering.value = false;
    },).onError((error, stackTrace) {
      isOrdering.value = false;
      Utils.showToastMessage(error.toString());
      debugPrint("GET_SHIPPING_ADDRESS-->$error");
    },);
  }
}
