// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, avoid_print

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gostore_app/core/controller/cart_controller/cart_controller.dart';
import 'package:gostore_app/utils/colors.dart';
import 'package:gostore_app/utils/images.dart';
import 'package:gostore_app/utils/prefer.dart';
import 'package:gostore_app/utils/text_style.dart';
import 'package:gostore_app/view/screen/auth/login_screen.dart';
import 'package:gostore_app/view/screen/user_screen/user_screen.dart';
import 'package:gostore_app/view/widget/common_drawer.dart';
import 'package:gostore_app/view/widget/icon_and_image.dart';
import 'package:gostore_app/view/screen/my_cart/cart_widget.dart';
import 'package:gostore_app/core/controller/gostore_controller.dart';
import 'package:gostore_app/view/screen/home_screen/home_screen.dart';
import 'package:gostore_app/core/controller/dashboard_manager_controller/dashboard_manager_controller.dart';

class DashBoardManagerScreen extends StatefulWidget {
  final int currantIndex;

  DashBoardManagerScreen({Key? key, this.currantIndex = 0}) : super(key: key);

  @override
  State<DashBoardManagerScreen> createState() => _DashBoardManagerScreenState();
}

class _DashBoardManagerScreenState extends State<DashBoardManagerScreen> {
  DashboardManagerController dashboardManagerController =
      Get.put(DashboardManagerController());
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  CartController cartController=Get.put(CartController());
  String accessToken = Prefs.getToken();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      dashboardManagerController.currantIndex.value = widget.currantIndex;
      print("-=-=-=-=-=-=-${dashboardManagerController.currantIndex.value}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: GoStoreAppController(),
        builder: (goStoreAppController) {
          return Container(
            color: AppColor.cNavyBlue,
            child: SafeArea(
              child: Obx(() {
                return GestureDetector(
                  onTap: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  },
                  child: Scaffold(
                    key: scaffoldKey,
                    backgroundColor: AppColor.cBackGround,
                    drawer: CommonDrawerWidget(),
                    body: dashboardManagerController.currantIndex.value == 0
                        ? HomeScreen(scaffoldKey: scaffoldKey)
                        : dashboardManagerController.currantIndex.value == 4?accessToken == ''
                        ? LoginScreen(
                      isBack: true,
                      page: 4,
                    )
                        : UserScreen(
                      isBack: false,
                    ):dashboardManagerController.naviBarItemList[
                                dashboardManagerController.currantIndex.value]
                            ['screen'],
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.endFloat,
                    floatingActionButton:
                        dashboardManagerController.currantIndex.value == 4
                            ? SizedBox(
                                height: 0,
                              )
                            : cartButtonWidget(cartController.totalCartItem.value, context),
                    bottomNavigationBar: Obx(() {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 20),
                        child: Container(
                          height: 56,
                          decoration: BoxDecoration(
                            color: AppColor.cBackGround,
                            borderRadius: BorderRadius.circular(40),
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.cShadow,
                                blurRadius: 12,
                                spreadRadius: 0,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(
                              dashboardManagerController.naviBarItemList.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  if (index == 3) {
                                    myCart(context);
                                  } else {
                                    dashboardManagerController
                                        .currantIndex.value = index;
                                    dashboardManagerController.currantIndex
                                        .refresh();
                                  }
                                },
                                behavior: HitTestBehavior.deferToChild,
                                child: Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    assetSvdImageWidget(
                                      image: dashboardManagerController
                                          .naviBarItemList[index]['icon'],
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      colorFilter: ColorFilter.mode(
                                          dashboardManagerController
                                                      .currantIndex.value ==
                                                  index
                                              ? AppColor.blueThemeColor
                                              : AppColor.cGreyFont,
                                          BlendMode.srcIn),
                                    ),
                                    index == 3
                                        ? cartTotalValue(
                                            total:cartController.totalCartItem.value.toString(),
                                            color: AppColor.blueThemeColor)
                                        : SizedBox(
                                            height: 0,
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                );
              }),
            ),
          );
        });
  }
}

myCart(BuildContext context) {
  return showModalBottomSheet(
      backgroundColor: AppColor.cTransparent,
      barrierColor: AppColor.cDarkGrey,
      context: context,
      constraints: BoxConstraints(
          maxHeight: Get.height - 100, minHeight: Get.height - 100),
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      builder: (context) {
        return CartBottomSheet();
      });
}

Widget cartButtonWidget(int total, BuildContext context) {
  return GestureDetector(
    onTap: () {
      myCart(context);
    },
    child: Container(
      width: 53,
      height: 53,
      decoration:
          BoxDecoration(color: AppColor.blueThemeColor, shape: BoxShape.circle),
      child: Stack(
        alignment: Alignment.topRight - Alignment(.5, -.55),
        fit: StackFit.loose,
        children: [
          assetSvdImageWidget(
            image: DefaultImages.cartIcn,
            colorFilter: ColorFilter.mode(
              AppColor.cBtnTxt,
              BlendMode.srcIn,
            ),
          ),
          cartTotalValue(total: total.toString())
        ],
      ),
    ),
  );
}

Widget cartTotalValue({String? total, Color? color}) {
  return Container(
    decoration: BoxDecoration(
        color: color ?? AppColor.cCartGrey, shape: BoxShape.circle),
    padding: EdgeInsets.all(3),
    child: Text(
      total!,
      style: pBold12.copyWith(color: AppColor.cBtnTxt, fontSize: 8),
    ),
  );
}
