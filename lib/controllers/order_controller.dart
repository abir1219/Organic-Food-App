import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organic_food_new/models/order_list_model.dart';
import 'package:organic_food_new/repository/order_repository.dart';
import 'package:organic_food_new/utils/utils.dart';

class OrderController extends GetxController {
  final _repo = OrderRepository();
  final Rx<OrderHistoryModel> orderListModel = OrderHistoryModel().obs;

  final RxList<OrderHistoryResult> _orders = <OrderHistoryResult>[].obs;

  RxList<OrderHistoryResult> get orders => _orders;

  RxBool isLoading = false.obs;
  RxInt total = 0.obs;
  RxList<int> totalList = <int>[].obs;

  Future<void> getOrderList() async {
    _orders.clear();
    isLoading.value = true;
    _repo.getAllOrders().then(
      (value) {
        isLoading.value = false;
        if (value[1] == 200) {
          orderListModel.value = OrderHistoryModel.fromJson(value[0]);
          _orders.assignAll(List<OrderHistoryResult>.generate(
              orderListModel.value.result!.length,
              (index) => orderListModel.value.result![index]));

          for (int i = 0; i < orderListModel.value.result!.length; i++) {
            int totalPrice = 0;
            // Loop through each order item in the current order
            for (int j = 0;
                j < orderListModel.value.result![i].orderItems!.length;
                j++) {
              // Add the totalPrice of the current order item to totalPrice
              totalPrice +=
                  orderListModel.value.result![i].orderItems![j].totalPrice!;
              //debugPrint("TOTAL--->$totalPrice");
            }
            debugPrint("\n");
            // Add the current totalPrice to totalList
            totalList.add(totalPrice);
          }
        }
        isLoading.value = false;
      },
    ).onError(
      (error, stackTrace) {
        Utils.showToastMessage(error.toString());
        debugPrint("ORDER_LIST_ERROR-->$error");
        isLoading.value = false;
      },
    );
  }

  RxBool isSingleOrderLoading = false.obs;

  Future<void> getOrdersDetails(String orderId) async {
    isSingleOrderLoading.value = true;
    _repo.getOrderDetails(orderId).then(
      (value) {
        isLoading.value = false;
        if (value[1] == 200) {
          orderListModel.value = OrderHistoryModel.fromJson(value[0]);
          for (int i = 0; i < orderListModel.value.result!.length; i++) {
            for (int j = 0;
                j < orderListModel.value.result![i].orderItems!.length;
                j++) {
              total +=
                  orderListModel.value.result![i].orderItems![j].totalPrice!;
            }
          }
        }
        isSingleOrderLoading.value = false;
      },
    ).onError(
      (error, stackTrace) {
        Utils.showToastMessage(error.toString());
        debugPrint("ORDER_DETAILS_ERROR-->$error");
        isSingleOrderLoading.value = false;
      },
    );
  }
}
