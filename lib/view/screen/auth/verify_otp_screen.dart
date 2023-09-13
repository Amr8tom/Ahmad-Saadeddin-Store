// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:gostore_app/view/screen/auth/change_password_screen.dart';
import 'package:gostore_app/view/widget/common_space_divider_widget.dart';
import '../../../core/controller/auth/verify_otp_controller.dart';
import 'package:gostore_app/view/widget/common_button.dart';
import 'package:gostore_app/utils/text_style.dart';
import 'package:gostore_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:get/get.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String email;
  const VerifyOtpScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  VerifyOtpController verifyOtpController = Get.put(VerifyOtpController());
  final focusNode = FocusNode();

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  final defaultPinTheme = PinTheme(
    width: 63.45,
    height: 63.45,
    textStyle: pBold24.copyWith(
      fontSize: 26,
    ),
    decoration: BoxDecoration(
        color: AppColor.cWhite,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColor.blueThemeColor)),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.cBackGround,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Forget Password".tr,
                  style: pBold24,
                ),
                verticalSpace(10),
                Text(
                  "GoStore is on the wat to serve you".tr,
                  style: pMedium14.copyWith(color: AppColor.cGreyFont),
                ),
                verticalSpace(25),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Code from Email".tr,
                  textAlign: TextAlign.start,
                  style: pBold14,
                ),
              ),
              verticalSpace(25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Pinput(
                  controller: verifyOtpController.pinController,
                  focusNode: focusNode,mainAxisAlignment: MainAxisAlignment.spaceAround,
                  pinAnimationType: PinAnimationType.slide,
                  // androidSmsAutofillMethod:
                  //     AndroidSmsAutofillMethod.smsUserConsentApi,
                  listenForMultipleSmsOnAndroid: true,
                  defaultPinTheme: defaultPinTheme,
                  hapticFeedbackType: HapticFeedbackType.lightImpact,
                  onCompleted: (pin) {
                    print('onCompleted: $pin');
                    verifyOtpController.setOtpValue(pin);
                  },
                  onChanged: (value) {
                    print('onChanged: $value');
                  },
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                        borderRadius: BorderRadius.circular(14),
                        color: AppColor.cLightBlue,
                        border: Border.all(color: AppColor.blueThemeColor)),
                  ),
                  followingPinTheme: defaultPinTheme,
                  submittedPinTheme: defaultPinTheme,
                ),
              ),
              verticalSpace(35),
              CommonButton(
                title: 'Reset Password'.tr,
                onPressed: () {
                  print('onCompleted: ${verifyOtpController.otp}');
                  if (verifyOtpController.otp != '') {
                    verifyOtpController.verifyOtp(email: widget.email, code: verifyOtpController.otp);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
