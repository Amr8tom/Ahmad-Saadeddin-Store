// ignore_for_file: must_be_immutable, prefer_const_constructors, prefer_const_constructors_in_immutables, avoid_print

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gostore_app/utils/colors.dart';
import 'package:gostore_app/utils/constant.dart';
import 'package:gostore_app/utils/prefer.dart';
import 'package:gostore_app/utils/text_style.dart';
import 'package:gostore_app/view/widget/common_button.dart';
import 'package:gostore_app/view/widget/common_space_divider_widget.dart';
import 'package:gostore_app/view/screen/onboarding_screen/onboarding1.dart';
import 'package:gostore_app/view/screen/onboarding_screen/onboarding2.dart';
import 'package:gostore_app/view/screen/onboarding_screen/onboarding3.dart';
import 'package:gostore_app/view/screen/dashboard_manager/dashboard_manager.dart';
import '../../../core/controller/onboarding_controller/onboarding_controller.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  OnBodingController onBodingController = Get.put(OnBodingController());

  PageController? pageController;
  List<Widget> pageList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController(initialPage: 0, keepPage: true);
    pageList = [
      OnBoarding1(onBodingController: onBodingController),
      OnBoarding2(),
      OnBoarding3()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.cBackGround,
      body: Obx(() {
        print("(${onBodingController.currantIndex.value})");
        return PageView(
            scrollDirection: Axis.horizontal,
            physics: NeverScrollableScrollPhysics(),
            controller: pageController,
            onPageChanged: (page) {
              onBodingController.currantIndex.value = page;
              print("====== ${pageController!.initialPage}");
              print("====== $page ${onBodingController.currantIndex.value}");
            },
            children: pageList);
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: buildPageIndicator(
                    pageList.length, onBodingController.currantIndex.value),
              ),
              onBodingController.currantIndex.value == 2
                  ? horizontalSpace(0)
                  : TextButton(
                      onPressed: () {
                        pageController!.jumpToPage(2);
                      },
                      child: Text(
                        "Skip".tr,
                        style: pBold14.copyWith(color: AppColor.cText),
                      ),
                    ),
              CommonButton(
                  title: onBodingController.currantIndex.value == 2
                      ? 'Get Started'.tr
                      : 'Next'.tr,
                  onPressed: () {
                    if (onBodingController.currantIndex.value == 2) {
                      Prefs.setBool(AppConstant.getStarted, true);
                      Get.offAll(DashBoardManagerScreen());
                    } else {
                      pageController!.nextPage(
                          duration: Duration(milliseconds: 120),
                          curve: Curves.bounceOut);
                    }
                  },
                  height: 43,
                  width:
                      onBodingController.currantIndex.value == 2 ? 235 : 133),
            ],
          );
        }),
      ),
    );
  }
}

List<Widget> buildPageIndicator(int length, int index) {
  List<Widget> widgetList = [];
  for (int i = 0; i < length; i++) {
    widgetList.add(i == index ? _indicator(true) : _indicator(false));
  }
  return widgetList;
}

Widget _indicator(bool isActive) {
  return SizedBox(
    height: 10,
    child: AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 2),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: isActive ? AppColor.blueThemeColor : AppColor.cGrey,
        shape: BoxShape.circle,
      ),
    ),
  );
}
