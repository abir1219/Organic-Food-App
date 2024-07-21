import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:organic_food_new/network/base_api_services.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:organic_food_new/utils/app_constants.dart';
import 'package:organic_food_new/utils/sharedpreference_utils.dart';

import 'app_exceptions.dart';

class NetworkApiServices extends BaseApiServices{
  dynamic responseJSON;
  final dio = Dio();

  @override
  Future<dynamic> getApi(String url) async {
    try {
      final response = await http.get(Uri.parse(url),);
      responseJSON = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }

    return responseJSON;
  }

  @override
  Future<dynamic> postApi(String url, dynamic body) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json'
    };

    try {
      // final response = await dio.post(url, data: jsonEncode(body), options: Options(headers: headers));
      var response = await http.post(Uri.parse(url), body: jsonEncode(body), headers: headers);
      debugPrint("POST--->$url ${response.body}");
      debugPrint("HEADERS--->$url ${response.headers}");
      /*if(response.headers.containsKey('set-cookie')){
        debugPrint("COOKIE--->${response.headers['set-cookie']!}");
        Map<String, dynamic> decodedToken = JwtDecoder.decode(response.headers['set-cookie']!);
        debugPrint("COOKIE--->${decodedToken['_id']}");
        await SharedPreferencesUtils.init();
        SharedPreferencesUtils.saveString(AppConstants.USERID, decodedToken['_id']);

      }*/

      responseJSON = returnResponse(response);
    } on SocketException {
      throw InternetException('Internet Exception');
    } on RequestTimeOut {
      throw RequestTimeOut('Request Timeout');
    }

    return responseJSON;
  }

  dynamic returnResponse(http.Response response) async {
    debugPrint("response.statusCode--->${response.statusCode}");
    switch (response.statusCode) {
      case 200:
      // dynamic responseJSON = response.body.isNotEmpty ? json.decode(response.body) : null;
        dynamic responseJSON = [response.body.isNotEmpty ? json.decode(response.body) : null,response.statusCode];
        // jsonDecode(response.body);
        return responseJSON;
      case 201:
        dynamic responseJSON = jsonDecode(response.body);
        return responseJSON;
      case 400:
        throw InvalidUrlException("Invalid Url");
      case 401:
      // throw UnAuthorizeAccessException;
      // await _refreshAndRetry(() => apiCall());
        //await _refreshAndRetry(() => apiCall());
      case 500:
        throw ServerException;
      case 502:
        throw BadGatewayException();
      default:
        throw FetchDataException(
            'Error occurred while communicating with the server ${response.statusCode}');
    }
  }
}