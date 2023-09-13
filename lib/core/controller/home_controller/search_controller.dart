import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gostore_app/config/repository/search_repository.dart';
import 'package:gostore_app/core/model/product_model.dart';
import 'package:gostore_app/utils/images.dart';
import 'package:gostore_app/view/widget/loading_widget.dart';

class SearchProductController extends GetxController {
  SearchRepository searchRepository = SearchRepository();
  TextEditingController searchTextEditingController = TextEditingController();
  RxList<ProductsModel> searchProductList = <ProductsModel>[].obs;

  searchProduct(String string) async {
    Loader.showLoader();
    var response = await searchRepository.searchProduct(string);
    log("/*/-/-------------/*--------> $response");
    Get.back();
    if (response != null) {
      searchProductList.clear();
      for (int i = 0; i < response.length; i++) {
        searchProductList.add(ProductsModel.fromJson(response[i]));
      }
      searchProductList.refresh();
    }
  }
}
