import 'package:organic_food_new/helper/api_end_points.dart';
import 'package:organic_food_new/network/network_api_services.dart';

class LoginRepository{
  final _apiClient = NetworkApiServices();

  Future<dynamic> login(var body){
    String url = ApiEndPoints.BASE_LINK + ApiEndPoints.authEndpoints.login;
    dynamic response = _apiClient.postApi(url, body);
    return response;
  }
}