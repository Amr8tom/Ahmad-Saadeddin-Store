// ignore_for_file: avoid_print
import 'dart:developer';
import 'package:get/get.dart';
import 'package:gostore_app/core/local_model/wishlist.dart';
import 'package:gostore_app/core/model/product_model.dart';
import 'package:gostore_app/view/widget/common_snak_bar_widget.dart';
import 'package:gostore_app/view/widget/loading_widget.dart';
import 'package:gostore_app/config/repository/product_repository.dart';

enum WishlistAction { add, remove }

class ProductController extends GetxController {
  ProductRepository productRepository = ProductRepository();
  RxList<ProductsModel> productList = <ProductsModel>[ProductsModel()].obs;

  RxBool isDataAvailable = false.obs;
  RxBool isEmptyProductList = false.obs;
  RxInt pageNumber = 2.obs;

  getAllProduct(id) async {
    isEmptyProductList.value = false;
    Loader.showLoader();
    var response = await productRepository.getProduct(id, 1);
    print("response--------==> $response");
    if (response != null) {
      productList.clear();
      for (int i = 0; i < response.length; i++) {
        productList.add(ProductsModel.fromJson(response[i]));
      }
      productList.refresh();
      print('---------------------${productList.length}');
    }
    if (productList.isEmpty) {
      isEmptyProductList.value = true;
    }
    Get.back();
  }

  getProduct({String? id, int? page}) async {
    isDataAvailable.value = true;
    var response = await productRepository.getProduct(id, page);
    log("response--------==> $response");

    if (response != null) {
      isDataAvailable.value = false;
      if (response.isNotEmpty) {
        for (int i = 0; i < response.length; i++) {
          productList.add(ProductsModel.fromJson(response[i]));
        }
      }
      productList.refresh();
      print(' productModel!.products! productModel!.products!${productList.length}');
    }
  }

  addedWishlistProduct(id) async {
    return WishList.getInstance.hasAddedWishlistProduct(id);
  }

  toggleWishList({
    required WishlistAction wishlistAction,
    required ProductsModel product,
  }) async {
    String subtitleMsg;
    if (wishlistAction == WishlistAction.remove) {
      await WishList.getInstance.removeWishlistProduct(product: product);
      subtitleMsg = ("This product has been removed from your wishlist");
    } else {
      await WishList.getInstance.saveWishlistProduct(product: product);
      subtitleMsg = ("This product has been added to your wishlist");
    }
    commonToast(subtitleMsg);

    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    pageNumber.value = 2;
  }
}
