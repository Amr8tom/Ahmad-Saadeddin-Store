// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gostore_app/network_dio/network_dio.dart';
import 'package:gostore_app/utils/base_api.dart';
import 'package:gostore_app/utils/helper.dart';
import 'package:gostore_app/view/screen/auth/change_password_screen.dart';
import 'package:gostore_app/view/screen/auth/success_reset_password.dart';
import 'package:gostore_app/view/widget/common_snak_bar_widget.dart';
import 'package:gostore_app/view/widget/loading_widget.dart';
import 'package:http/http.dart' as http;

class VerifyOtpController extends GetxController {
  final pinController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RxBool isObscure = true.obs;
  RxBool isConfirmObscure = true.obs;
  String otp = '';

  setOtpValue(value) {
    otp = value;
    update();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pinController.dispose();
  }

  verifyOtp({
    required String email,
    required String code,
  }) async {
    Loader.showLoader();
    var url = API.baseUrl + API.verifyOtpUrl;

    Map data = {
      "email": email,
      "code": code,
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

        Get.to(() => ChangePasswordScreen(
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

  changePassword({
    required String email,
    required String password,
  }) async {
    Loader.showLoader();
    var url = API.baseUrl + API.updatePasswordUrl;

    Map data = {
      "email": email,
      "password": password,
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

        Get.to(() => ResetPasswordScreen());
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
