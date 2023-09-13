// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gostore_app/utils/images.dart';
import 'package:gostore_app/utils/prefer.dart';
import 'package:gostore_app/view/screen/auth/login_screen.dart';
import 'package:gostore_app/view/screen/category_screen/category_screen.dart';
import 'package:gostore_app/view/screen/search_screen/search_screen.dart';
import 'package:gostore_app/view/screen/user_screen/user_screen.dart';

class DashboardManagerController extends GetxController {
  RxInt currantIndex = 0.obs;
  RxList naviBarItemList = [
    {'icon': DefaultImages.homeIcn      ,'screen':SizedBox()},
    {'icon': DefaultImages.gridIcn      ,'screen':CategoryScreen(isBack: false,)},
    {'icon': DefaultImages.greySearchIcn,'screen':SearchScreen()},
    {'icon': DefaultImages.cartIcn      ,'screen':SizedBox()},
    {'icon': DefaultImages.userIcn      ,'screen':UserScreen(isBack: false,)},
  ].obs;
}
