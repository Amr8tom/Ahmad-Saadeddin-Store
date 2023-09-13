// ignore_for_file: avoid_print, prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gostore_app/core/controller/cart_controller/cart_controller.dart';
import 'package:gostore_app/network_dio/network_dio.dart';
import 'package:gostore_app/utils/base_api.dart';
import 'package:gostore_app/utils/constant.dart';
import 'package:gostore_app/utils/helper.dart';
import 'package:gostore_app/utils/prefer.dart';
import 'package:gostore_app/view/screen/auth/email_sent_screen.dart';
import 'package:gostore_app/view/screen/auth/login_screen.dart';
import 'package:gostore_app/view/screen/dashboard_manager/dashboard_manager.dart';
import 'package:gostore_app/view/widget/common_snak_bar_widget.dart';
import 'package:gostore_app/view/widget/loading_widget.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  CartController cartController = Get.put(CartController());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController newEmailController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController forgotEmailController = TextEditingController();
  RxBool isObscure = true.obs;
  RxBool isSignUpObscure = true.obs;
  RxBool isCreateAc = true.obs;
  RxBool isTermsAndCon = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    emailController.clear();
    passwordController.clear();
    fNameController.clear();
    lNameController.clear();
    newEmailController.clear();
    newPasswordController.clear();
    forgotEmailController.clear();
  }

  login({
    required String userName,
    required String password,
    required bool isBack,
    required int page,
    required BuildContext context,
  }) async {
    Loader.showLoader();
    var url = Uri.parse(API.baseUrl + API.authUrl + API.loginUrl);
    Map data = {"username": userName, "password": password};
    print("===url============$url\n data===> ${json.encode(data)}");
    var response = await http.post(url,
        body: json.encode(data), headers: NetworkHttps.headers);
    print('Response status: ${response.statusCode}');
    var decoded = jsonDecode(response.body);
    if (response.statusCode == 200) {
      Loader.hideLoader();
      print("===user_id============  ${decoded['wp_user']["data"]['ID']}");
      Prefs.setString(AppConstant.userId, decoded['wp_user']["data"]['ID']);
      Prefs.setToken(decoded["access_token"]);
      if (isBack == true) {
        print("===isBack============1$page $isBack");
        // Get.back();
        emailController.clear();
        passwordController.clear();
        if (page == 3) {
          String accessToken = Prefs.getToken();
          print("---->accessToken$page====>$accessToken");
          await cartController.prefItemAddToCart(context);

        } else {
          Get.offAll(DashBoardManagerScreen(
            currantIndex: page,
          ));
        }
      } else {
        Get.offAll(DashBoardManagerScreen());
      }
      commonToast(
          "${decoded['wp_user']["data"]['display_name'].toString().capitalizeFirst} Login Successfully ");
    } else {
      Loader.hideLoader();
      print("===err============  ${parseHtmlString(decoded["message"])}");
      commonToast(parseHtmlString(decoded["message"]));
    }
  }

  register(
      {required String fName,
      required String lName,
      required String email,
      required String password}) async {
    Loader.showLoader();
    var endPoint = API.customersUrl;
    String url = NetworkHttps.getOAuthURL(endPoint);

    Map data = {
      "first_name": fName,
      "last_name": lName,
      "email": email,
      "password": password
    };
    print("===url============$url\n data===> ${json.encode(data)}");
    var response = await http.post(Uri.parse(url),
        body: json.encode(data), headers: NetworkHttps.headers);
    print('Response status: ${response.statusCode}');
    var decoded = jsonDecode(response.body);
    log("===Response body:============  $decoded");
    if (response.statusCode == 201 || response.statusCode == 200) {
      Loader.hideLoader();
      print("===user_id============  ${decoded['ID']}");
      Prefs.setString(AppConstant.userId, decoded['ID']);
      commonToast("Sign up Successfully ");
      Get.offAll(LoginScreen(
        isBack: false,
      ));
    } else {
      Loader.hideLoader();
      print("===err============  ${parseHtmlString(decoded["message"])}");
      commonToast(parseHtmlString(decoded["message"]));
    }
  }

  forgotPassword({
    required String email,
  }) async {
    Loader.showLoader();
    var url = API.baseUrl + API.forgetPasswordUrl;

    Map data = {
      "email": email,
    };
    print("===url============$url\n data===> ${json.encode(data)}");
    var response = await http.post(Uri.parse(url),
        body: json.encode(data), headers: NetworkHttps.headers);
    print('Response status: ${response.statusCode}');
    var decoded = jsonDecode(response.body);
    log("===Response body:============  $decoded");
    if (response.statusCode == 201 || response.statusCode == 200) {
      Loader.hideLoader();
      if (decoded['success'] == true) {
        commonToast(parseHtmlString(decoded["data"]));

        Get.to(() => EmailSentScreen(
              email: email,
            ));
      } else {
        commonToast(parseHtmlString(decoded["data"]));
      }
    } else {
      Loader.hideLoader();
      print("===err============  ${parseHtmlString(decoded["message"])}");
      commonToast(parseHtmlString(decoded["message"]));
    }
  }
}
