// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gostore_app/config/repository/product_repository.dart';
import 'package:gostore_app/view/widget/common_snak_bar_widget.dart';
import 'package:gostore_app/core/local_model/wishlist.dart';
import 'package:gostore_app/core/model/product_model.dart';
import 'package:gostore_app/view/widget/loading_widget.dart';

class WishlistController extends GetxController {
  ProductRepository productRepository = ProductRepository();

  TextEditingController searchController = TextEditingController();
  RxBool isSelected = true.obs;
  RxList<ProductsModel> wishlistList = <ProductsModel>[].obs;
  RxList<ProductsModel> searchResult = <ProductsModel>[].obs;

  RxBool isLoading = false.obs;
  RxBool isEmptyWishList = false.obs;

  loadProducts() async {
    Loader.showLoader();
    List<dynamic> favouriteProducts = await WishList.getInstance.getWishlistProducts();
    List<int> productIds = favouriteProducts.map((e) => e['id']).cast<int>().toList();
    if (productIds.isEmpty) {
      Get.back();if (wishlistList.isEmpty) {
        isEmptyWishList.value = true;
      }
      return;
    }
    String ids = productIds.map((c) => c).toList().join(',');
    print("---------------------ids-->; $ids");
    await getWishlistProduct(ids);
    Get.back();
  }

  getWishlistProduct(String ids) async {
    var response = await productRepository.getWishlistProduct(ids);
    print("response--------==> $response");
    wishlistList.clear();
    if (response != null) {
      for (int j = 0; j < response.length; j++) {
        wishlistList.add(ProductsModel.fromJson(response[j]));
      }
      wishlistList.refresh();
      if (wishlistList.isEmpty) {
        isEmptyWishList.value = true;
      }
      print('---------------------${wishlistList.length}');
    }
  }

  removeFromWishlist(ProductsModel product, context) async {
    await WishList.getInstance.removeWishlistProduct(product: product);
    commonToast("Item removed");
    wishlistList.remove(product);
    wishlistList.refresh();
    if (wishlistList.isEmpty) {
      isEmptyWishList.value = true;
    }
  }

  clearWishList() async {
    await WishList.getInstance.clear();
    wishlistList.clear();
  }

  onSearchTextChanged(String text) async {
    print(text);
    searchResult.clear();
    if (text.isEmpty) {
      return;
    } else {
      print("=== ${searchResult.length}");
      wishlistList.forEach((userDetail) {
        if (userDetail.name!.toLowerCase().contains(text) || userDetail.name!.contains(text)) {
          searchResult.add(userDetail);
        }
      });
      wishlistList.clear();
      wishlistList.addAll(searchResult);
    }

    wishlistList.refresh();
    searchResult.refresh();
  }
}
