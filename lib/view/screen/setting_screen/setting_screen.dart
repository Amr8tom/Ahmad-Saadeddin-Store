// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_const_constructors_in_immutables

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gostore_app/core/controller/gostore_controller.dart';
import 'package:gostore_app/utils/colors.dart';
import 'package:gostore_app/utils/images.dart';
import 'package:gostore_app/utils/text_style.dart';
import 'package:gostore_app/view/widget/common_button.dart';
import 'package:gostore_app/view/widget/common_drawer.dart';
import 'package:gostore_app/view/widget/icon_and_image.dart';
import 'package:gostore_app/view/widget/common_appbar_widget.dart';
import 'package:gostore_app/view/widget/common_space_divider_widget.dart';
import 'package:gostore_app/core/controller/user_controller/user_controller.dart';
import 'package:gostore_app/core/controller/setting_controller/setting_controller.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  SettingController settingController = Get.put(SettingController());
  UserController userController = Get.put(UserController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      userController.getProfileData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: GoStoreAppController(),
        builder: (goStoreAppController) {
          return Scaffold(
            backgroundColor: AppColor.cBackGround,
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 212.07,
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: AppColor.blueThemeColor,
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(10))),
                    padding: EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            commonMenuIconWidget(
                              icon: DefaultImages.menuIcn,
                              onTap: () {
                                Get.back();
                              },
                              color: AppColor.blueThemeColor,
                              bColor: AppColor.cWhite,
                              colorFilter: ColorFilter.mode(
                                  AppColor.cBtnTxt, BlendMode.srcIn),
                            ),
                            horizontalSpace(10),
                            Text(
                              "Settings".tr,
                              style: pBold12.copyWith(
                                  color: AppColor.cBtnTxt, fontSize: 20),
                            ),
                          ],
                        ),
                        Obx(() {
                          return Row(
                            children: [
                              Container(
                                height: 68.961,
                                width: 68.961,
                                decoration: BoxDecoration(
                                  color: AppColor.cLightBlue,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        userController.profileImage.value),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              horizontalSpace(8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${userController.fNameController.text} ${userController.lNameController.text}',
                                    style: pBold12.copyWith(
                                        color: AppColor.cBtnTxt, fontSize: 20),
                                  ),
                                  verticalSpace(4),
                                  Row(
                                    children: [
                                      assetSvdImageWidget(
                                          image: DefaultImages.envelopeIcn,
                                          colorFilter: ColorFilter.mode(
                                              AppColor.cBtnTxt,
                                              BlendMode.srcIn),
                                          width: 17,
                                          height: 17),
                                      horizontalSpace(5),
                                      Text(
                                        userController.emailController.text,
                                        style: pMedium10.copyWith(
                                          color: AppColor.cBtnTxt,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          );
                        })
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: ListView(
                        shrinkWrap: true,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "General Settings".tr,
                            style: pBold14,
                          ),
                          verticalSpace(20),
                          Obx(() {
                            settingController.currantIndex
                                .refresh(); //don't remove this line
                            settingController.isNotification
                                .refresh(); //don't remove this line
                            return ListView.builder(
                              itemCount: settingController.itemList.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                var item = settingController.itemList[index];
                                return drawerMenuItemWidget(
                                    icon: item['icon'],
                                    title: item['title'],
                                    onTap: () {
                                      settingController.currantIndex.value =
                                          index;
                                      settingController.onTapSwitchCase(
                                          index, context);
                                    },
                                    isSelected:
                                        settingController.currantIndex.value ==
                                            index,
                                    // widget: index == 1
                                    //     ? SizedBox(
                                    //         width: 42,
                                    //         child: CupertinoSwitch(
                                    //           value: settingController
                                    //               .isNotification.value,
                                    //           onChanged: (value) {
                                    //             settingController
                                    //                 .isNotification.value = value;
                                    //             settingController.isNotification
                                    //                 .refresh();
                                    //           },
                                    //           activeColor: settingController
                                    //                       .currantIndex.value ==
                                    //                   index
                                    //               ? AppColor.cLightBlue
                                    //               : AppColor.blueThemeColor,
                                    //           trackColor: settingController
                                    //                       .currantIndex.value ==
                                    //                   index
                                    //               ? AppColor.cLightBlue
                                    //               : AppColor.blueThemeColor,
                                    //         ),
                                    //       )
                                    //     : null
                                );
                              },
                            );
                          }),
                          // verticalSpace(22),
                          // CommonIconButton(
                          //   iconData: DefaultImages.doneIcn,
                          //   title: 'Save Changes'.tr,
                          // )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
