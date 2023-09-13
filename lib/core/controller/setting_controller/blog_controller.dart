import 'dart:developer';

import 'package:get/get.dart';
import 'package:gostore_app/config/repository/blog_repository.dart';
import 'package:gostore_app/core/model/blog_model.dart';
import 'package:gostore_app/utils/images.dart';
import 'package:gostore_app/view/widget/loading_widget.dart';

class BlogController extends GetxController {
  BlogRepository blogRepository = BlogRepository();
  RxInt blogPostIndex = 0.obs;
  RxBool isDataAvailable=false.obs;
  BlogModel? blogModel;
  RxList<BlogModel> blogPostList = <BlogModel>[].obs;
  RxList<BlogModel> articleList = <BlogModel>[].obs;

  BlogModel? get blogData => blogModel;
  set blogData(BlogModel? value) {
    blogModel = value;
    update();
  }
  getBlogData(perPage) async {
    Loader.showLoader();
    var response = await blogRepository.getBlogData(perPage);
    log("blogPost response--------==> $response");

      blogPostList.clear();
    if (response != null) {
      for (int i = 0; i < response.length; i++) {
        blogPostList.add(BlogModel.fromJson(response[i]));
      }
      blogPostList.refresh();
    }
      print('blogPostList---------------------${blogPostList.length}');
    // Loader.hideLoader();
    Get.back();
  }

  getArticleData() async {
    Loader.showLoader();
    var response = await blogRepository.getArticleData();
    log("response--------==> $response");

    if (response != null) {
      articleList.clear();
      for (int i = 0; i < response.length; i++) {
        articleList.add(BlogModel.fromJson(response[i]));
      }
      articleList.refresh();
      print('---------------------${articleList.length}');
    }
    // Loader.hideLoader();
    Get.back();
  }

  getPostDetailData(id) async {
    isDataAvailable.value=true;
    var response = await blogRepository.getPostDetailData(id);
    log("blogModel response--------==> $response");

    if (response != null) {
      blogData = BlogModel.fromJson(response);
      log("blogData response--------==> $blogData");
      log("blogModel response--------==> $blogModel");

    }
    isDataAvailable.value=false;

  }
}
