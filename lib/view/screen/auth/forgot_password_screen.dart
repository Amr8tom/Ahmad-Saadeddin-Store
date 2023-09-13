// ignore_for_file: prefer_const_literals_to_create_immutables, must_be_immutable, prefer_const_constructors

import 'package:get/get.dart';
import 'email_sent_screen.dart';
import 'package:flutter/material.dart';
import 'package:gostore_app/utils/colors.dart';
import 'package:gostore_app/utils/images.dart';
import 'package:gostore_app/utils/validator.dart';
import 'package:gostore_app/utils/text_style.dart';
import 'package:gostore_app/view/widget/common_button.dart';
import 'package:gostore_app/view/widget/common_text_field.dart';
import 'package:gostore_app/core/controller/auth/auth_controller.dart';
import 'package:gostore_app/view/widget/common_space_divider_widget.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);
  AuthController authController = Get.find();
  GlobalKey<FormState> formKey = GlobalKey();

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
            padding: const EdgeInsets.only(
              left: 24,
              right: 24,
            ),
            child: Form(
              key: formKey,
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
                  CommonTextField(
                    controller: authController.forgotEmailController,
                    labelText: 'Email Address'.tr,
                    hintText: "johndoe@company.com",
                    prefix: DefaultImages.envelopeIcn,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      return Validator.validateEmail(value!);
                    },
                    focusNode: FocusNode(),
                  ),
                  verticalSpace(35),
                  CommonButton(
                    title: 'Send Code'.tr,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        authController.forgotPassword(email: authController.forgotEmailController.text.trim());
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
