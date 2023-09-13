// ignore_for_file: avoid_print

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gostore_app/core/model/review_model.dart';
import 'package:gostore_app/view/widget/loading_widget.dart';
import 'package:gostore_app/config/repository/review_repository.dart';

class ReviewController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  RxDouble rate = 3.0.obs;
  ReviewRepository reviewRepository = ReviewRepository();
  RxList<ReviewModel> reviewList = <ReviewModel>[].obs;

  List<ReviewModel> get reviewResult => reviewList;

  getReview(id) async {
    Loader.showLoader();
    var response = await reviewRepository.getReview(id);
    log("Review==> $response");
    if (response != null) {
      reviewList.clear();
      for (int i = 0; i < response.length; i++) {
        reviewResult.add(ReviewModel.fromJson(response[i]));
      }
      reviewList.refresh();
      log("length==> ${reviewList.length}");
    }
    // Loader.hideLoader();
    Get.back();
  }

  addReview({
    int? id,
    String? review,
    String? reviewer,
    String? reviewerEmail,
    int? rating,
  }) async {
    Loader.showLoader();
    var data = {
      "product_id": id,
      "rating": rating,
      "reviewer": reviewer,
      "reviewer_email": reviewerEmail,
      "review": review,
    };
    print('data==?$data');
    var response = await reviewRepository.addReview(data);
    log("Review==> $response");
    if (response != null) {
      Get.back();
      getReview(id.toString());
      clear();
      log("length==> ${reviewList.length}");
    }
    // Loader.hideLoader();
    Get.back();
  }
  clear(){
    rate.value=3.0;
    nameController.clear();
    emailController.clear();
    descriptionController.clear();
  }
}
