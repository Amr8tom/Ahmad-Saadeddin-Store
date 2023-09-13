import 'dart:developer';

import 'package:gostore_app/network_dio/network_dio.dart';
import 'package:gostore_app/utils/base_api.dart';

class CategoryRepository {
  Future getCategories() async {
    String url = API.productsUrl + API.categoriesUrl;
    var response = await NetworkHttps.getRequest(url);
    log("response==> $response");
    return response;
  }
}
