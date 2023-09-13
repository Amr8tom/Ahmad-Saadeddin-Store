// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';
import 'package:gostore_app/utils/base_api.dart';
import 'package:gostore_app/network_dio/network_dio.dart';
import 'package:gostore_app/utils/constant.dart';
import 'package:gostore_app/utils/prefer.dart';
import 'package:http/http.dart' as http;

class CartRepository {
  String userId = Prefs.getString(AppConstant.userId) ?? '';

  addToCart({required Map data}) async {
    String postUrl = API.baseUrl + API.coCartUrl + API.cartUrl + API.addItemUrl;
    // String postUrl = NetworkHttps.getOAuthURL(url);
    print("postUrl===> $postUrl");
    print("authHeaders1111===> ${NetworkHttps.authHeaders}");
    print("data===> ${jsonEncode(data)}");
    var response = await http.post(Uri.parse(postUrl),
        body: jsonEncode(data), headers: NetworkHttps.authHeaders);
    print("statusCode===> ${response.statusCode}");
    print("response body===> ${response.body}");

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    // var response = await NetworkHttps.postRequest(url, data);
    // log("response==> $response");
    // return response;
  }

  getCart() async {
    String url = API.baseUrl + API.coCartUrl + API.cartUrl+"/";
    print("getCart accessToken===> ${NetworkHttps.authHeaders}");
    // String url = NetworkHttps.getOAuthURL(endpoint);
    print("GEZT API URL===> $url");
    var response =
        await http.get(Uri.parse(url), headers: NetworkHttps.authHeaders);
    print("statusCode===> ${response.statusCode}");
    // print("response body===> ${response.body}");

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    // var response = await NetworkHttps.getRequest(url);
    // log("response==> $response");
    // return response;
  }

  updateCart({required String itemKey, required String quantity}) async {
    String postUrl =
        API.baseUrl + API.coCartUrl + API.cartUrl + API.itemUrl + itemKey;
    print("POST API URL===> $postUrl");
    print("data===> ${jsonEncode({"quantity": quantity})}");
    var response = await http.post(Uri.parse(postUrl),
        body: jsonEncode({"quantity": quantity}),
        headers: NetworkHttps.authHeaders);
    print("statusCode===> ${response.statusCode}");
    // print("response body===> ${response.body}");

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    // var response = await NetworkHttps.postRequest(url, {"quantity": quantity});
    // log("response==> $response");
    // return response;
  }

  clearCart() async {
    String postUrl = API.baseUrl + API.coCartUrl + API.cartUrl + API.clearUrl;
    print("POST API URL===> $postUrl");
    print("data===> ${jsonEncode({})}");
    var response = await http.post(Uri.parse(postUrl),
        body: jsonEncode({}), headers: NetworkHttps.authHeaders);
    print("statusCode===> ${response.statusCode}");
    print("response body===> ${response.body}");

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    // var response = await NetworkHttps.postRequest(url, {});
    // log("response==> $response");
    // return response;
  }

  removeCartItem(itemKey) async {
    String url =
        API.baseUrl + API.coCartUrl + API.cartUrl + API.itemUrl + itemKey;
    print("delete API URL===> $url");
    var response =
        await http.delete(Uri.parse(url), headers: NetworkHttps.authHeaders);
    print("statusCode===> ${response.statusCode}");
    print("response body===> ${response.body}");

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    // var response = await NetworkHttps.deleteRequest(url);
    // log("response==> $response");
    // return response;
  }

  applyCoupon(Map data) async {
    String postUrl = API.baseUrl + API.coCartUrl + API.applyCouponUrl;
    print("POST API URL===> $postUrl");
    print("data===> ${jsonEncode(data)}");
    var response = await http.post(Uri.parse(postUrl),
        body: jsonEncode(data), headers: NetworkHttps.authHeaders);
    print("statusCode===> ${response.statusCode}");
    print("response body===> ${response.body}");

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    // var response = await NetworkHttps.postRequest(url, data);
    // log("response==> $response");
    // return response;
  }
}
