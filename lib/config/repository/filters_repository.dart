// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:gostore_app/network_dio/network_dio.dart';
import 'package:gostore_app/utils/base_api.dart';
import 'dart:developer';

class FiltersRepository {
  Future getCategory(String id) async {
    String url = API.productsUrl + API.categoriesUrl + API.parentUrl + id;
    var response = await NetworkHttps.getRequest(url);
    log("response==> $response");
    return response;
  }

  Future getTagData() async {
    String url = API.productsUrl + API.tagUrl;
    var response = await NetworkHttps.getRequest(url);
    log("response==> $response");
    return response;
  }

  Future getAllAttributes() async {
    String url = API.productsUrl + API.attributesUrl;
    var response = await NetworkHttps.getRequest(url);
    log("response==> $response");
    return response;
  }

  Future getAttributes(id) async {
    String url = API.productsUrl + API.attributesUrl + "/$id" + API.termsUrl;
    var response = await NetworkHttps.getRequest(url);
    log("response==> $response");
    return response;
  }

  Future getDateFilter(String endPoint) async {
    String url = API.productsUrl + endPoint;
    var response = await NetworkHttps.getRequest(url);
    log("response==> $response");
    return response;
  }

  Future getFilterProduct({
    required String categoryId,
    required String minPrice,
    required String maxPrice,
    required String tagID,
    required String attribute,
    required String attributeTerm,
  }) async {
    String url = API.productsUrl +
        "?category=$categoryId&min_price=$minPrice&max_price=$maxPrice&tag=$tagID&attribute=$attribute&attribute_term=$attributeTerm";
    var response = await NetworkHttps.getRequest(url);
    log("response==> $response");
    return response;
  }
}
