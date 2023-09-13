import 'dart:developer';

import 'package:gostore_app/network_dio/network_dio.dart';
import 'package:gostore_app/utils/base_api.dart';

class ReviewRepository {
  Future getReview(id) async {
    String url = API.productsUrl + API.reviewsUrl +API.productKeyUrl +id;

    var response = await NetworkHttps.getRequest(url);
    log("response==> $response");
    return response;
  }
  Future addReview(data) async {
    String url = API.productsUrl + API.reviewsUrl;
    var response = await NetworkHttps.postRequest(url,data);
    log("response==> $response");
    return response;
  }
}
