// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:get/get.dart';
import 'verify_otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:gostore_app/utils/colors.dart';
import 'package:gostore_app/utils/images.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:gostore_app/view/screen/auth/success_widget.dart';

class EmailSentScreen extends StatelessWidget {
  final String email;

  const EmailSentScreen({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.cBackGround,
      body: SuccessWidget(
          image: DefaultImages.sentMessageIcn,
          title: "Email Sent".tr,
          subTitle: "Check your email and open the link we sent to continue".tr,
          btnName: 'Go to Email'.tr,
          onTap: () async {
            var result = await OpenMailApp.openMailApp();
            print(result);
            Get.to(() => VerifyOtpScreen(email: email));
          }),
    );
  }
}
