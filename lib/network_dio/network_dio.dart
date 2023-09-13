// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:gostore_app/utils/base_api.dart';
import 'package:gostore_app/utils/prefer.dart';
import 'package:gostore_app/view/widget/common_snak_bar_widget.dart';
import 'package:http/http.dart' as http;

class NetworkHttps {
  String accessToken = Prefs.getToken();

  NetworkHttps._privateConstructor();

  static final NetworkHttps getInstance = NetworkHttps._privateConstructor();
  static final Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    HttpHeaders.cacheControlHeader: "no-cache",
  };
  static final Map<String, String> authHeaders = {
    "Authorization": 'Bearer ${NetworkHttps.getInstance.accessToken}',
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.cacheControlHeader: "no-cache",
  };

  static String getOAuthURL(String endpoint) {
    String consumerKey = API.consumerKey;
    String consumerSecret = API.consumerSecret;
    String cocartUrl = endpoint.contains(API.cartUrl) == true || endpoint.contains(API.applyCouponUrl) == true
        ? API.coCartUrl
        : API.wcUrl;

    String url = API.baseUrl + cocartUrl + endpoint;
    bool containsQueryParams = url.contains("?");
    String requestUrl = "";

    requestUrl = url +
        (containsQueryParams == true
            ? "&consumer_key=" + consumerKey + "&consumer_secret=" + consumerSecret
            : "?consumer_key=" + consumerKey + "&consumer_secret=" + consumerSecret);
    return requestUrl;
  }

  static Future getRequest(String endPoint) async {
    String postUrl = getOAuthURL(endPoint);
    print("GET API URL===> $postUrl");
    try {
      var response = await http.get(Uri.parse(postUrl));
      print("statusCode===> ${response.statusCode}");
      print("response body===> ${response.body}");
      // return response;
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      _handleError(response);
    } on SocketException {
      commonToast("No Internet connection.");
      throw Exception('No Internet connection.');
    }
  }

  static Future postRequest(String endPoint, Map data) async {
    String postUrl = getOAuthURL(endPoint);
    print("POST API URL===> $postUrl");
    print("data===> ${jsonEncode(data)}");
    try {
      var response = await http.post(Uri.parse(postUrl), body: jsonEncode(data), headers: headers);
      print("statusCode===> ${response.statusCode}");
      print("response body===> ${response.body}");
      print("response c===> ${response.statusCode == 200 || response.statusCode == 201}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      }
      _handleError(response);
    } on SocketException {
      commonToast("No Internet connection.");
      throw Exception('No Internet connection.');
    }
  }

  static Future deleteRequest(String endPoint) async {
    String deleteUrl = getOAuthURL(endPoint);
    print(" delete API URL===> $deleteUrl");
    try {
      var response = await http.delete(Uri.parse(deleteUrl), headers: headers);
      print("statusCode===> ${response.statusCode}");
      print("response body===> ${response.body}");
      print("response c===> ${response.statusCode == 200 || response.statusCode == 201}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      }
      _handleError(response);
    } on SocketException {
      commonToast("No Internet connection.");
      throw Exception('No Internet connection.');
    }
  }

  static Exception _handleError(http.Response response) {
    switch (response.statusCode) {
      case 400:
      case 401:
      case 404:
      case 500:
        commonToast(json.decode(response.body).toString());
        throw Exception(json.decode(response.body).toString());
      default:
        throw Exception("An error occurred, status code: ${response.statusCode}");
    }
  }
}
