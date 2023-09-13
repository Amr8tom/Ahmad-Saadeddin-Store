// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gostore_app/utils/colors.dart';
import 'package:gostore_app/utils/images.dart';
import 'package:gostore_app/view/screen/auth/login_screen.dart';
import 'package:gostore_app/view/screen/auth/success_widget.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.cBackGround,
      body: SuccessWidget(
          image: DefaultImages.passwordResetIcn,
          title: "Your password was reset".tr,
          subTitle: "Check your email and open the link we sent to continue".tr,
          btnName: 'Go to Login'.tr,
          onTap: () {
            Get.offAll(() => LoginScreen( isBack: false,));
          }),
    );
  }
}
