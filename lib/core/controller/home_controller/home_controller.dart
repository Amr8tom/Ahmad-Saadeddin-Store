// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gostore_app/config/repository/blog_repository.dart';
import 'package:gostore_app/config/repository/category_repository.dart';
import 'package:gostore_app/config/repository/product_repository.dart';
import 'package:gostore_app/core/model/best_sellers_model.dart';
import 'package:gostore_app/core/model/blog_model.dart';
import 'package:gostore_app/core/model/categories_model.dart';
import 'package:gostore_app/view/widget/loading_widget.dart';

import '../../../utils/images.dart';
import '../../model/product_model.dart';

class HomeController extends GetxController {
  TextEditingController searchController = TextEditingController();
  CategoryRepository categoryRepository = CategoryRepository();
  ProductRepository productRepository = ProductRepository();
  CategoriesModel? categoriesModel;
  RxInt categoryIndex = 0.obs;
  RxInt currantIndex = 0.obs;
  RxInt sellerIndex = 0.obs;

  // RxInt blogPostIndex = 0.obs;
  RxInt newCollectionIndex = 0.obs;
  RxList<CategoriesModel> categoriesList = <CategoriesModel>[].obs;

  List<CategoriesModel> get categoriesResult => categoriesList;
  BestSellersModel? bestSellersModel;
  RxList<ProductsModel> onSaleProductList = <ProductsModel>[].obs;
  RxList<ProductsModel> ratedProductList = <ProductsModel>[].obs;
  RxList<ProductsModel> newCollectionList = <ProductsModel>[].obs;
  RxList<BestSellerData> sellerList = <BestSellerData>[].obs;

  Future getAllCategory() async {
    // Loader.showLoader();
    var response = await categoryRepository.getCategories();
    if (response != null) {
      categoriesList.clear();
      for (int i = 0; i < response.length; i++) {
        categoriesResult.add(CategoriesModel.fromJson(response[i]));
      }
    }
    // Loader.hideLoader();
  }

  getOnSaleProduct() async {
    // Loader.showLoader();
    var response = await productRepository.getOnSaleProduct();
    log("response--------==> $response");

    if (response != null) {
      onSaleProductList.clear();
      for (int i = 0; i < response.length; i++) {
        onSaleProductList.add(ProductsModel.fromJson(response[i]));
      }
      onSaleProductList.refresh();
      print('---------------------${onSaleProductList.length}');
    }
    // Loader.hideLoader();
    // Get.back();
  }

  getRateProduct() async {
    // Loader.showLoader();
    var response = await productRepository.getRateProduct("rating");
    log("rating--------==> $response");
    ratedProductList.clear();
    if (response != null) {
      for (int i = 0; i < response.length; i++) {
        ratedProductList.add(ProductsModel.fromJson(response[i]));
      }
      ratedProductList.refresh();
      print('ratedProductList---------------------${ratedProductList.length}');
    }
    // Loader.hideLoader();
    // Get.back();
  }

  getNewCollection() async {
    // Loader.showLoader();
    var response = await productRepository.getRateProduct('date');
    log("rating--------==> $response");
    newCollectionList.clear();
    if (response != null) {
      for (int i = 0; i < response.length; i++) {
        newCollectionList.add(ProductsModel.fromJson(response[i]));
      }
      newCollectionList.refresh();
      print(
          'newCollectionList---------------------${newCollectionList.length}');
    }
    // Loader.hideLoader();
    // Get.back();
  }

  getBestSeller() async {
    // Loader.showLoader();
    var response = await productRepository.getBestSellerData();
    log("rating--------==> $response");
    if (response != null) {
      bestSellersModel = BestSellersModel.fromJson(response);
      sellerList.value = bestSellersModel!.data!;
    }
    // Loader.hideLoader();
    // Get.back();
  }
}
