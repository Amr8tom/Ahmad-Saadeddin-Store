// ignore_for_file: prefer_const_constructors, must_be_immutable, avoid_print, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gostore_app/core/controller/user_controller/user_controller.dart';
import 'package:gostore_app/utils/colors.dart';
import 'package:gostore_app/utils/images.dart';
import 'package:gostore_app/utils/text_style.dart';
import 'package:gostore_app/utils/validator.dart';
import 'package:gostore_app/view/widget/common_button.dart';
import 'package:gostore_app/view/widget/common_text_field.dart';
import 'package:gostore_app/view/widget/common_appbar_widget.dart';
import 'package:gostore_app/view/widget/common_space_divider_widget.dart';
import 'package:image_gradient/image_gradient.dart';
import 'package:image_picker/image_picker.dart';

class UserScreen extends StatefulWidget {
  final bool isBack;

  UserScreen({Key? key, required this.isBack}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  UserController userController = Get.put(UserController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getUserData();
    });
  }

  getUserData() {
    userController.getProfileData();
  }
  GlobalKey<FormState> formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(
                    10,
                  ),
                ),
                child: Stack(
                  children: [
                    ImageGradient(
                      image: Image.asset(
                        DefaultImages.userImage,
                        fit: BoxFit.fill,
                        height: 222,
                        width: Get.width,
                      ),
                      gradient: LinearGradient(
                          colors: [AppColor.blueThemeColor, AppColor.cWhite],
                          stops: [0.0, 1.0],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight),
                    ),
                    Container(
                      height: 222,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(
                            10,
                          ),
                        ),
                        color: AppColor.blueThemeColor,
                        gradient: LinearGradient(
                          colors: [
                            AppColor.blueThemeColor,
                            AppColor.blueThemeColor.withOpacity(0.00),
                            AppColor.cTransparent,
                          ],
                          stops: [0.2, 0.4, 0.8],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                        ),
                      ),
                      padding: EdgeInsets.all(24),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Row(
                          children: [
                            widget.isBack == true
                                ? commonMenuIconWidget(
                                    icon: DefaultImages.backIcn,
                                    onTap: () {
                                      Get.back();
                                    },
                                    color: AppColor.cWhite,
                                    bColor: AppColor.cWhite,
                                    colorFilter: ColorFilter.mode(
                                        AppColor.blueThemeColor,
                                        BlendMode.srcIn),
                                  )
                                : SizedBox(height: 0, width: 0),
                            horizontalSpace(10),
                            Text(
                              "Profile".tr,
                              style: pBold12.copyWith(
                                  color: AppColor.cBtnTxt, fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Container(
                  color: Colors.transparent,
                  height: 213,
                  child: Align(
                    heightFactor: 0.0,
                    child: Container(
                      height: 213,
                      width: 213,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: userController
                                  .selectedImagePath.value.isNotEmpty
                              ? FileImage(
                                  File(userController.selectedImagePath.value))
                              : NetworkImage(userController.profileImage.value)
                                  as ImageProvider,
                          fit: BoxFit.fill,
                        ),
                      ),
                      padding: EdgeInsets.only(bottom: 15),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: commonMenuIconWidget(
                          icon: DefaultImages.cameraIcn,
                          color: AppColor.cLightBlue,
                          bColor: AppColor.cLightBlue,
                          onTap: () {
                            userController.pickImage(ImageSource.camera);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                  /*top: Get.height * 0.15,*/
                  left: 24,
                  right: 24),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    CommonTextField(
                      controller: userController.displayNameController,
                      labelText: 'Display Name'.tr,
                      hintText: 'Enter your display name',
                      validator: (value) {
                        return Validator.validateName(value!, "Display Name");
                      },
                    ),
                    verticalSpace(10),
                    CommonTextField(
                      controller: userController.fNameController,
                      labelText: 'First Name'.tr,
                      hintText: 'Enter your first name',
                      validator: (value) {
                        return Validator.validateName(value!, "First Name");
                      },
                    ),
                    verticalSpace(10),
                    CommonTextField(
                      controller: userController.lNameController,
                      labelText: 'Last Name'.tr,
                      hintText: 'Enter your last name',
                      validator: (value) {
                        return Validator.validateName(value!, "Last Name");
                      },
                    ),
                    verticalSpace(10),
                    CommonTextField(
                      controller: userController.phoneController,
                      labelText: 'Phone number'.tr,
                      hintText: 'Enter your Phone number',
                      maxLength: 10,
                      keyboardType: TextInputType.number,

                      validator: (value) {
                        return Validator.validateMobile(value!);
                      },
                    ),
                    verticalSpace(10),
                    CommonTextField(
                        controller: userController.emailController,
                        labelText: 'Email'.tr,
                        hintText: 'company@company.com',
                        keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        return Validator.validateEmail(value!);
                      },),
                    verticalSpace(25),
                    CommonIconButton(
                      iconData: DefaultImages.doneIcn,
                      title: 'Save Changes'.tr,
                      onPressed: () {
                        if(formKey.currentState!.validate()||userController.sendImagePath.value!=""){
                          userController.updateProfileData();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      );
    });
  }
}
