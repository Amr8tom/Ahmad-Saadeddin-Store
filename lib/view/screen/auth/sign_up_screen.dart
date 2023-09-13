// ignore_for_file: must_be_immutable, avoid_print, prefer_const_constructors

import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gostore_app/utils/colors.dart';
import 'package:gostore_app/utils/images.dart';
import 'package:gostore_app/utils/validator.dart';
import 'package:gostore_app/utils/text_style.dart';
import 'package:gostore_app/view/widget/common_button.dart';
import 'package:gostore_app/view/widget/common_text_field.dart';
import 'package:gostore_app/view/screen/auth/login_screen.dart';
import 'package:gostore_app/view/widget/common_snak_bar_widget.dart';
import 'package:gostore_app/core/controller/auth/auth_controller.dart';
import 'package:gostore_app/view/widget/common_space_divider_widget.dart';
import 'package:gostore_app/view/screen/setting_screen/privacy_and_terms_screen.dart';

class SignUpScreen extends StatelessWidget {
  final bool isBack;

  SignUpScreen({Key? key, required this.isBack}) : super(key: key);
  AuthController authController = Get.put(AuthController());
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
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(right: 24, left: 24, top: Get.height * 0.12),
              child: Center(
                child: Obx(
                  () {
                    return Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Sign Up".tr,
                            style: pBold24,
                          ),
                          verticalSpace(10),
                          Text(
                            "GoStore is on the wat to serve you".tr,
                            style: pMedium14.copyWith(color: AppColor.cGreyFont),
                          ),
                          verticalSpace(15),
                          CommonTextField(
                            controller: authController.fNameController,
                            labelText: 'First Name'.tr,
                            hintText: "Enter you first name",
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              return Validator.validateName(value!, 'First Name');
                            },
                            focusNode: FocusNode(),
                          ),
                          verticalSpace(15),
                          CommonTextField(
                            controller: authController.lNameController,
                            labelText: 'Last Name'.tr,
                            hintText: "Enter you last name",
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              return Validator.validateName(value!, 'Last Name');
                            },
                            focusNode: FocusNode(),
                          ),
                          verticalSpace(15),
                          CommonTextField(
                            controller: authController.newEmailController,
                            labelText: 'Email Address'.tr,
                            hintText: "johndoe@company.com",
                            prefix: DefaultImages.envelopeIcn,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              return Validator.validateEmail(value!);
                            },
                            focusNode: FocusNode(),
                          ),
                          verticalSpace(15),
                          CommonTextField(
                            controller: authController.newPasswordController,
                            labelText: 'Password'.tr,
                            hintText: "Enter your password",
                            prefix: DefaultImages.keyIcn,
                            maxLines: 1,
                            obscureText: authController.isSignUpObscure.value,
                            validator: (value) {
                              return Validator.validatePassword(value!);
                            },
                            obscuringCharacter: '*',
                            suffix: IconButton(
                                onPressed: () {
                                  authController.isSignUpObscure.value = !authController.isSignUpObscure.value;
                                },
                                icon: Icon(
                                  !authController.isSignUpObscure.value
                                      ? Icons.visibility_off_outlined
                                      : Icons.remove_red_eye_outlined,
                                  color: AppColor.cGreyFont,
                                )),
                            focusNode: FocusNode(),
                          ),
                          // SizedBox(
                          //   height: 30,
                          //   child: CheckboxListTile(
                          //       value: authController.isCreateAc.value,
                          //       onChanged: (bool? value) {
                          //         authController.isCreateAc.value = value!;
                          //       },
                          //       title: Text(
                          //         "I want to create an account".tr,
                          //         style:
                          //             pMedium12.copyWith(color: AppColor.cFont),
                          //       ),
                          //       controlAffinity:
                          //           ListTileControlAffinity.leading,
                          //       contentPadding: EdgeInsets.zero,
                          //       checkColor: AppColor.cBtnTxt,
                          //       activeColor: AppColor.blueThemeColor,
                          //       shape: RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(4)),
                          //       side: BorderSide(
                          //           color: AppColor.blueThemeColor, width: 1.5),
                          //       checkboxShape: RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(4))),
                          // ),
                          SizedBox(
                            height: 30,
                            child: CheckboxListTile(
                                value: authController.isTermsAndCon.value,
                                onChanged: (bool? value) {
                                  authController.isTermsAndCon.value = value!;
                                },
                                title: RichText(
                                  textAlign: TextAlign.start,
                                  text: TextSpan(
                                    text: 'I agree with '.tr,
                                    style: pMedium12.copyWith(color: AppColor.cFont),
                                    children: [
                                      TextSpan(
                                          text: "Privacy and Terms".tr,
                                          style: pMedium12.copyWith(
                                              color: AppColor.cText, decoration: TextDecoration.underline),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Get.to(() => PrivacyTermsScreen());
                                            }),
                                    ],
                                  ),
                                ),
                                controlAffinity: ListTileControlAffinity.leading,
                                contentPadding: EdgeInsets.zero,
                                checkColor: AppColor.cBtnTxt,
                                activeColor: AppColor.blueThemeColor,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                side: BorderSide(color: AppColor.blueThemeColor, width: 1.5),
                                checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
                          ),
                          verticalSpace(20),
                          CommonButton(
                              title: 'Sign Up'.tr,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  if (authController.isTermsAndCon.value == true) {
                                    authController.register(
                                      fName: authController.fNameController.text.trim(),
                                      lName: authController.lNameController.text.trim(),
                                      email: authController.newEmailController.text.trim(),
                                      password: authController.newPasswordController.text.trim(),
                                    );
                                  } else {
                                    commonToast("You have to accept the terms first.");
                                  }
                                }
                              },
                              height: 56),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Have you an account? '.tr,
              style: pMedium14.copyWith(color: AppColor.cGreyFont),
              children: [
                TextSpan(
                    text: 'Sign In'.tr,
                    style: pMedium14.copyWith(color: AppColor.cText),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        isBack
                            ? Get.back()
                            : Get.off(LoginScreen(
                                isBack: false,
                              ));
                      }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
