import 'package:organic_food_new/helper/api_end_points.dart';
import 'package:organic_food_new/network/network_api_services.dart';

class OrderRepository{
  final _apiClient = NetworkApiServices();

  Future<dynamic> getAllOrders(){
    String url = ApiEndPoints.BASE_LINK + ApiEndPoints.authEndpoints.orderList;
    dynamic response = _apiClient.getApi(url);
    return response;
  }

  Future<dynamic> getOrderDetails(String orderId){
    String url = "${ApiEndPoints.BASE_LINK}${ApiEndPoints.authEndpoints.orderDetail}/$orderId";
    dynamic response = _apiClient.getApi(url);
    return response;
  }
}