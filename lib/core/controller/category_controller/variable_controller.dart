import 'dart:developer';

import 'package:get/get.dart';
import 'package:gostore_app/config/repository/product_repository.dart';
import 'package:gostore_app/core/model/product_model.dart';

class VariableController extends GetxController {
  ProductRepository productRepository = ProductRepository();
  RxString size = ''.obs;
  RxString color = ''.obs;
  RxBool isSize = false.obs;
  RxBool isColor = false.obs;
  RxInt productIndex = 0.obs;
  RxInt tabIndex = 0.obs;
  RxInt quantity = 1.obs;
  RxString productImage = ''.obs;
  RxBool isDataAvailable = false.obs;

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
      isDataAvailable.value = false;
    }
    isDataAvailable.value = false;
  }
}
