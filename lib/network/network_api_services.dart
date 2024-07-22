import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
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
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization':
      SharedPreferencesUtils.containsKey(AppConstants.ACCESS_TOKEN)?'Bearer ${SharedPreferencesUtils.getString(AppConstants.ACCESS_TOKEN)}':'',
    };
    try {
      final response = await http.get(Uri.parse(url),headers: headers);
      debugPrint("GET--->$url ${response.body}");
      debugPrint("ACCESS_TOKEN--->${SharedPreferencesUtils.getString(AppConstants.ACCESS_TOKEN)}");
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
      'Content-Type': 'application/json',
      'Authorization':
      SharedPreferencesUtils.containsKey(AppConstants.ACCESS_TOKEN)?'Bearer ${SharedPreferencesUtils.getString(AppConstants.ACCESS_TOKEN)}':'',
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

  @override
  Future<dynamic> putApi(String url, body) async{
    debugPrint("url->$url\nbody=>${jsonEncode(body)}");
    Map<String, String> headers;

    headers = {
      'Content-Type': 'application/json',
      'Authorization': SharedPreferencesUtils.containsKey(AppConstants.ACCESS_TOKEN)?'Bearer ${SharedPreferencesUtils.getString(AppConstants.ACCESS_TOKEN)}':''
    };

    debugPrint("HEADER=>$headers");

    try {
      var response = await http
          .put(Uri.parse(url), body: jsonEncode(body), headers: headers);
      // .timeout(Duration(seconds: 10));

      debugPrint("$url ${jsonDecode(response.body)}");
      // if (kDebugMode) alice.onHttpResponse(response);
      // if (kDebugMode) alice.showInspector();
      responseJSON = returnResponse(response);
      debugPrint("PUT_responseJSON_TYPE=> ${responseJSON.runtimeType}");
    } on SocketException {
      throw InternetException();
    } on RequestTimeOut {
      throw RequestTimeOut();
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
        dynamic responseJSON = [response.body.isNotEmpty ? json.decode(response.body) : null,response.statusCode];
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