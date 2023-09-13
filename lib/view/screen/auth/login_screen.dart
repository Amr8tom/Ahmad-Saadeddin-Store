// ignore_for_file: must_be_immutable, avoid_print

import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gostore_app/utils/colors.dart';
import 'package:gostore_app/utils/images.dart';
import 'package:gostore_app/utils/validator.dart';
import 'package:gostore_app/utils/text_style.dart';
import 'package:gostore_app/view/screen/auth/forgot_password_screen.dart';
import 'package:gostore_app/view/widget/common_button.dart';
import 'package:gostore_app/view/widget/icon_and_image.dart';
import 'package:gostore_app/view/widget/common_text_field.dart';
import 'package:gostore_app/core/controller/auth/auth_controller.dart';
import 'package:gostore_app/view/widget/common_space_divider_widget.dart';

import 'sign_up_screen.dart';

class LoginScreen extends StatelessWidget {
  final bool isBack;
  final int? page;
  LoginScreen({Key? key, this.isBack = false, this.page=0}) : super(key: key);
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
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  EdgeInsets.only(right: 24, left: 24, top: Get.height * 0.15),
              child: Center(
                child: Obx(
                  () {
                    return Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Sign In".tr,
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
                            controller: authController.emailController,
                            labelText: 'Email Address'.tr,
                            hintText: "johndoe@company.com",
                            prefix: DefaultImages.envelopeIcn,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              // return Validator.validateEmail(value!);
                              return Validator.validateName(
                                  value!, "User name or email");
                            },
                            focusNode: FocusNode(),
                          ),
                          verticalSpace(25),
                          CommonTextField(
                            controller: authController.passwordController,
                            labelText: 'Password'.tr,
                            hintText: "Enter your password",
                            prefix: DefaultImages.keyIcn,
                            obscureText: authController.isObscure.value,
                            maxLines: 1,
                            validator: (value) {
                              return Validator.validatePassword(value!);
                            },
                            obscuringCharacter: '*',
                            suffix: IconButton(
                                onPressed: () {
                                  authController.isObscure.value =
                                      !authController.isObscure.value;
                                },
                                icon: Icon(
                                  !authController.isObscure.value
                                      ? Icons.visibility_off_outlined
                                      : Icons.remove_red_eye_outlined,
                                  color: AppColor.cGreyFont,
                                )),
                            focusNode: FocusNode(),
                          ),
                          // verticalSpace(10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Get.to(() => ForgotPasswordScreen());
                              },
                              child: Text(
                                "Forgot Password?".tr,
                                style:
                                    pMedium14.copyWith(color: AppColor.cText),
                              ),
                            ),
                          ),
                          CommonButton(
                              title: 'Sign In'.tr,
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                    await authController.login(
                                        userName: authController.emailController.text.trim(),
                                        password: authController.passwordController.text.trim(),
                                        isBack: isBack,
                                        context: context, page: page!,
                                    );
                                  // Get.offAll( DashBoardManagerScreen());
                                }
                              },
                              height: 56),
                          // Row(
                          //   children: [
                          //     Expanded(child: horizontalDivider()),
                          //     Padding(
                          //       padding: const EdgeInsets.symmetric(
                          //           horizontal: 15, vertical: 20),
                          //       child: Text(
                          //         "Or Log in with".tr,
                          //         style: pMedium14.copyWith(
                          //             color: AppColor.cGreyFont),
                          //       ),
                          //     ),
                          //     Expanded(child: horizontalDivider()),
                          //   ],
                          // ),
                          // verticalSpace(10),
                          // socialLoginWidget(() {}, DefaultImages.googleIcn,
                          //     'Log in With Google'.tr),
                          // socialLoginWidget(() {}, DefaultImages.facebookIcn,
                          //     'Log in With Facebook'.tr),
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
              text: 'Don\'t have account? '.tr,
              style: pMedium14.copyWith(color: AppColor.cGreyFont),
              children: [
                TextSpan(
                    text: 'Sign Up'.tr,
                    style: pMedium14.copyWith(color: AppColor.cText),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.to(() => SignUpScreen(
                              isBack: true,
                            ));
                      }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget socialLoginWidget(Function() onTap, String icon, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 56,
          width: Get.width,
          decoration: BoxDecoration(
              // color: AppColor.blueThemeColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColor.cBorder)),
          // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListTile(
            leading: SizedBox(
                width: 25, height: 25, child: assetSvdImageWidget(image: icon)),
            horizontalTitleGap: 55,
            title: Text(
              title,
              style: pBold14,
              // textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
