// ignore_for_file: prefer_const_constructors, must_be_immutable, avoid_print

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../widget/common_button.dart';
import 'package:gostore_app/utils/colors.dart';
import 'package:gostore_app/utils/images.dart';
import 'package:gostore_app/utils/validator.dart';
import 'package:gostore_app/utils/text_style.dart';
import 'package:gostore_app/view/widget/common_text_field.dart';
import 'package:gostore_app/view/screen/auth/success_reset_password.dart';
import 'package:gostore_app/view/widget/common_space_divider_widget.dart';
import 'package:gostore_app/core/controller/auth/verify_otp_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  final String email;

  ChangePasswordScreen({Key? key, required this.email}) : super(key: key);
  VerifyOtpController verifyOtpController = Get.put(VerifyOtpController());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: AppColor.cBackGround,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Obx(
              () {
                return Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Type new Password".tr,
                            style: pBold24,
                          ),
                          verticalSpace(10),
                          Text(
                            "GoStore is on the wat to serve you".tr,
                            style:
                                pMedium14.copyWith(color: AppColor.cGreyFont),
                          ),
                          verticalSpace(25),
                          CommonTextField(
                            controller: verifyOtpController.passwordController,
                            labelText: 'Password'.tr,
                            hintText: "Enter your password",
                            maxLines: 1,
                            prefix: DefaultImages.keyIcn,
                            obscureText: verifyOtpController.isObscure.value,
                            validator: (value) {
                              return Validator.validatePassword(value!);
                            },
                            obscuringCharacter: '*',
                            suffix: IconButton(
                                onPressed: () {
                                  verifyOtpController.isObscure.value =
                                      !verifyOtpController.isObscure.value;
                                },
                                icon: Icon(
                                  !verifyOtpController.isObscure.value
                                      ? Icons.visibility_off_outlined
                                      : Icons.remove_red_eye_outlined,
                                  color: AppColor.cGreyFont,
                                )),
                            focusNode: FocusNode(),
                          ),
                          verticalSpace(25),
                          CommonTextField(
                            controller:
                                verifyOtpController.confirmPasswordController,
                            labelText: 'Confirm Password'.tr,
                            hintText: "Enter your password",
                            prefix: DefaultImages.keyIcn,
                            maxLines: 1,
                            obscureText:
                                verifyOtpController.isConfirmObscure.value,
                            validator: (value) {
                              return Validator.validateConfirmPassword(value!,
                                  verifyOtpController.passwordController.text);
                            },
                            obscuringCharacter: '*',
                            suffix: IconButton(
                                onPressed: () {
                                  verifyOtpController.isConfirmObscure.value =
                                      !verifyOtpController
                                          .isConfirmObscure.value;
                                },
                                icon: Icon(
                                  !verifyOtpController.isConfirmObscure.value
                                      ? Icons.visibility_off_outlined
                                      : Icons.remove_red_eye_outlined,
                                  color: AppColor.cGreyFont,
                                )),
                            focusNode: FocusNode(),
                          ),
                          verticalSpace(30),
                          CommonButton(
                            title: 'Reset Password'.tr,
                            onPressed: () {
                              print('onCompleted: ${verifyOtpController.otp}');
                              if (formKey.currentState!.validate()) {
                                verifyOtpController.changePassword(
                                    email: email,
                                    password: verifyOtpController
                                        .confirmPasswordController.text
                                        .trim());
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
