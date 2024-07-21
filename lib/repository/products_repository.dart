import 'package:organic_food_new/helper/api_end_points.dart';
import 'package:organic_food_new/network/network_api_services.dart';

class ProductsRepository{
  final _apiClient = NetworkApiServices();

  Future<dynamic> getAllLocation(){
    String url = ApiEndPoints.BASE_LINK + ApiEndPoints.authEndpoints.warehouse;
    dynamic response = _apiClient.getApi(url);
    return response;
  }

  Future<dynamic> getAllProducts(String warehouseId){
    String url = "${ApiEndPoints.BASE_LINK}${ApiEndPoints.authEndpoints.products}/$warehouseId";
    dynamic response = _apiClient.getApi(url);
    return response;
  }
}