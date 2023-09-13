// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_const_literals_to_create_immutables, avoid_print, prefer_const_constructors_in_immutables

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gostore_app/core/controller/cart_controller/cart_controller.dart';
import 'package:gostore_app/core/controller/home_controller/filter_controller.dart';
import 'package:gostore_app/core/model/categories_model.dart';
import 'package:gostore_app/utils/colors.dart';
import 'package:gostore_app/utils/images.dart';
import 'package:gostore_app/utils/text_style.dart';
import 'package:gostore_app/view/screen/category_screen/product_screen.dart';
import 'package:gostore_app/view/screen/dashboard_manager/dashboard_manager.dart';
import 'package:gostore_app/view/screen/setting_screen/privacy_and_terms_screen.dart';
import 'package:gostore_app/view/widget/icon_and_image.dart';
import 'package:gostore_app/view/widget/common_space_divider_widget.dart';
import 'package:gostore_app/core/controller/home_controller/drawer_controller.dart';

import 'loading_widget.dart';

class CommonDrawerWidget extends StatefulWidget {
  CommonDrawerWidget({Key? key}) : super(key: key);

  @override
  State<CommonDrawerWidget> createState() => _CommonDrawerWidgetState();
}

class _CommonDrawerWidgetState extends State<CommonDrawerWidget> {
  MyDrawerController drawerController = Get.put(MyDrawerController());

  FilterController filterController = Get.put(FilterController());

  CartController cartController = Get.find();

  List titleList = [
    'Shop'.tr,
    'Categories'.tr,
    'Blog'.tr,
    'Settings'.tr,
    'Logout'.tr
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getData();
    });
  }

  getData() async {
    filterController.getAllCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width / 1.3,
      decoration: BoxDecoration(
        color: AppColor.cBackGround,
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(9),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 35),
      child: Obx(() {
        print(drawerController.currantIndex.value);
        drawerController.itemList.refresh();
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "GoStore",
                      style: pBold24.copyWith(fontSize: 29),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                        myCart(context);
                      },
                      child: Container(
                        height: 44,
                        width: 125,
                        decoration: BoxDecoration(
                          color: AppColor.cLightBlue,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Cart".tr,
                              style: pBold14.copyWith(fontSize: 12),
                            ),
                            Stack(
                              alignment:
                                  Alignment.topRight - Alignment(-.55, -.55),
                              children: [
                                assetSvdImageWidget(
                                  image: DefaultImages.cartIcn,
                                  colorFilter: ColorFilter.mode(
                                    AppColor.cCartIcon,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 8,
                                  backgroundColor: AppColor.blueThemeColor,
                                  child: Text(
                                      "${cartController.totalCartItem.value}",
                                      style: pBold14.copyWith(
                                          fontSize: 8,
                                          color: AppColor.cBtnTxt)),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: horizontalDivider(color: AppColor.cGreyDivider),
              ),
              Text(
                "Menu".tr,
                style: pBold12,
              ),
              verticalSpace(14),
              ListView.builder(
                itemCount: drawerController.itemList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var item = drawerController.itemList[index];
                  return drawerMenuItemWidget(
                      icon: item,
                      title: titleList[index],
                      onTap: () {
                        drawerController.currantIndex.value = index;
                        drawerController.onTapSwitchCase(index);
                      },
                      isSelected: drawerController.currantIndex.value == index);
                },
              ),
              horizontalDivider(color: AppColor.cGreyDivider),
              Text(
                "Categories".tr,
                style: pBold12,
              ),
              filterController.isDataAvailable.value
                  ? LoadingWidget()
                  : ListView.builder(
                      itemCount: filterController.categoriesList.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        CategoriesModel data =
                            filterController.categoriesList[index];
                        return Column(
                          children: [
                            TextButton(
                              onPressed: () {
                                for (int i = 0;
                                    i < filterController.categoriesList.length;
                                    i++) {
                                  if (index == i) {
                                    data.isExpand = true;
                                    filterController
                                        .getSubCategory(data.id.toString());
                                  } else {
                                    filterController
                                        .categoriesList[i].isExpand = false;
                                  }
                                  filterController.categoriesList.refresh();
                                }
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    data.name!,
                                    style: pBold14.copyWith(
                                        color: data.isExpand == true
                                            ? AppColor.cText
                                            : AppColor.cFont),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: assetSvdImageWidget(
                                        image: data.isExpand == true
                                            ? DefaultImages.minusIcn
                                            : DefaultImages.plusIcn),
                                  ),
                                ],
                              ),
                            ),
                            Obx(() {
                              print(
                                  "===${filterController.subCategoriesList.length}");
                              return data.isExpand == true
                                  ? filterController.isCategoryAvailable.value
                                      ? SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: LoadingWidget())
                                      : ListView(
                                          shrinkWrap: true,
                                          children: filterController
                                              .subCategoriesList
                                              .map((subCategory) {
                                            print("subCategory==>$subCategory");
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10, left: 24),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: InkWell(
                                                  onTap: () {
                                                    Get.back();
                                                    Get.to(() => ProductScreen(
                                                          id: subCategory.id
                                                              .toString(),
                                                        ));
                                                  },
                                                  child: Text(
                                                    subCategory.name!,
                                                    style: pMedium12,
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        )
                                  : SizedBox();
                            })
                          ],
                        );
                      },
                    ),
              Center(
                child: TextButton(
                  onPressed: () {
                    Get.to(() => PrivacyTermsScreen());
                  },
                  child: Text(
                    'Privacy and Terms'.tr,
                    style: pMedium10.copyWith(
                      color: AppColor.cText,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

Widget drawerMenuItemWidget({
  String? icon,
  String? title,
  Function()? onTap,
  bool? isSelected,
  Widget? widget,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          color: isSelected == true
              ? AppColor.blueThemeColor
              : AppColor.cLightBlue,
          borderRadius: BorderRadius.all(
            Radius.circular(9),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 23),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                assetSvdImageWidget(
                  image: icon,
                  colorFilter: ColorFilter.mode(
                    isSelected == true ? AppColor.cBtnTxt : AppColor.cFont,
                    BlendMode.srcIn,
                  ),
                ),
                horizontalSpace(10),
                Text(
                  title!,
                  style: pBold12.copyWith(
                    color:
                        isSelected == true ? AppColor.cBtnTxt : AppColor.cFont,
                  ),
                ),
              ],
            ),
            widget ??
                assetSvdImageWidget(
                  image: DefaultImages.arrowRightIcn,
                  colorFilter: ColorFilter.mode(
                    isSelected == true ? AppColor.cBtnTxt : AppColor.cFont,
                    BlendMode.srcIn,
                  ),
                ),
          ],
        ),
      ),
    ),
  );
}
