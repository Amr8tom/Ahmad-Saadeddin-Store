import 'dart:developer';

import 'package:gostore_app/network_dio/network_dio.dart';
import 'package:gostore_app/utils/base_api.dart';

class SearchRepository {
  Future searchProduct(String string) async {
    String url = API.productsUrl + API.searchUrl + string;
    var response = await NetworkHttps.getRequest(url);
    log("response==> $response");
    return response;
  }
}
