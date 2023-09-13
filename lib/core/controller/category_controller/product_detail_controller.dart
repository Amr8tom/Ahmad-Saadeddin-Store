// ignore_for_file: avoid_print

import 'dart:developer';
import 'package:get/get.dart';
import 'package:gostore_app/config/repository/product_repository.dart';
import 'package:gostore_app/core/controller/home_controller/home_controller.dart';
import 'package:gostore_app/core/model/product_model.dart';
import 'package:gostore_app/utils/images.dart';

class ProductDetailController extends GetxController {
  ProductRepository productRepository = ProductRepository();

  RxString productImage = ''.obs;
  RxString size = ''.obs;
  RxString color = ''.obs;
  RxBool isSize = false.obs;
  RxBool isColor = false.obs;
  RxInt productIndex = 0.obs;
  RxInt currantIndex = 0.obs;
  RxInt tabIndex = 0.obs;
  RxInt quantity = 1.obs;
  RxBool isDataAvailable = false.obs;
  RxBool isRelatedDataAvailable = false.obs;

  RxList relatedProductList = <ProductsModel>[].obs;
  ProductsModel? products;

  ProductsModel? get resultProducts => products;

  set resultProducts(ProductsModel? value) {
    products = value;
    update();
  }

  getProductDetail(id) async {
    isDataAvailable.value = true;
    var response = await productRepository.getProductDetail(id);
    log("response--------==> $response");
    if (response != null) {
      resultProducts = ProductsModel.fromJson(response);
      productImage.value = products!.images!.first.src.toString();
      getRelatedProduct();
      isDataAvailable.value = false;
    }
    isDataAvailable.value = false;
  }

  getRelatedProduct() async {
    isRelatedDataAvailable.value=true;
    print('relatedIds---------------------${resultProducts!.relatedIds!.length}');
    String ids = resultProducts!.relatedIds!.map((c) => c).toList().join(',');
    print('relatedIds---------------------ids:($ids)');
    relatedProductList.clear();
    // for (int i = 0; i < resultProducts!.relatedIds!.length; i++) {
      var response = await productRepository.getWishlistProduct(
          ids,);
      log("relatedProductList--------==> $response");
      if (response != null) {
        for (int j = 0; j < response.length; j++) {
          relatedProductList.add(ProductsModel.fromJson(response[j]));
        }
        relatedProductList.refresh();
        print('relatedProductList---------------------${relatedProductList.length}');
      }
    // }
    isRelatedDataAvailable.value=false;
  }
}
