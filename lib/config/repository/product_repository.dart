// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print

import 'dart:convert';
import 'dart:developer';
import 'package:gostore_app/network_dio/network_dio.dart';
import 'package:gostore_app/utils/base_api.dart';
import 'package:http/http.dart'as http;
class ProductRepository {
  Future getProduct(id, page) async {
    String url = id == null
        ? API.productsUrl + "?page=$page"
        : API.productsUrl + API.categoryUrl + id + "&page=$page";
    var response = await NetworkHttps.getRequest(url);
    log("response==> $response");
    return response;
  }

  Future getProductDetail(productId) async {
    String url = '${API.productsUrl}/$productId';
    var response = await NetworkHttps.getRequest(url);
    log("response==> $response");
    return response;
  }
  Future getOnSaleProduct() async {
    String url = API.productsUrl + API.onSaleUrl +'1';
    var response = await NetworkHttps.getRequest(url);
    log("response==> $response");
    return response;
  }
  Future getRateProduct(String key) async {
    String url = API.productsUrl + API.orderByUrl +key;
    var response = await NetworkHttps.getRequest(url);
    log("response==> $response");
    return response;
  }
  Future getBestSellerData() async {
    String url = API.baseUrl + API.bestSellersUrl;
    print("GET API URL===> $url");
    var response = await http.get(Uri.parse(url));
    print("statusCode===> ${response.statusCode}");
    print("response body===> ${response.body}");

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
  }
  Future getWishlistProduct(String ids) async {
    String url =  API.productsUrl + API.includeUrl+ids;
    var response = await NetworkHttps.getRequest(url);
    log("response==> $response");
    return response;
  }
}
