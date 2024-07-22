import 'package:organic_food_new/helper/api_end_points.dart';
import 'package:organic_food_new/network/network_api_services.dart';

class CartRepository{
  final _apiClient = NetworkApiServices();

  Future<dynamic> getCartList(){
    String url = ApiEndPoints.BASE_LINK + ApiEndPoints.authEndpoints.cart;
    dynamic response = _apiClient.getApi(url);
    return response;
  }

  Future<dynamic> updateCart(var body,String cartId){
    String url = "${ApiEndPoints.BASE_LINK}${ApiEndPoints.authEndpoints.cart}/$cartId";
    dynamic response = _apiClient.putApi(url,body);
    return response;
  }

  Future<dynamic> getAddressList(){
    String url = ApiEndPoints.BASE_LINK + ApiEndPoints.authEndpoints.addresses;
    dynamic response = _apiClient.getApi(url);
    return response;
  }

  Future<dynamic> placeOrder(var body){
    String url = "${ApiEndPoints.BASE_LINK}${ApiEndPoints.authEndpoints.placeOrder}";
    dynamic response = _apiClient.postApi(url,body);
    return response;
  }

}