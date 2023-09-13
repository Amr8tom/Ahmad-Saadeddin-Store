// ignore_for_file: prefer_const_constructors_in_immutables, must_be_immutable

import 'package:get/get.dart';
import '../../utils/colors.dart';
import '../../utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:gostore_app/view/widget/icon_and_image.dart';
import 'package:gostore_app/view/widget/common_space_divider_widget.dart';

class CommonButton extends StatelessWidget {
  final String? title;
  final double? height;
  final double? width;
  final Function()? onPressed;
  final Color? bColor;
  final Color? btnColor;

  CommonButton({
    Key? key,
    this.title,
    this.height,
    this.width,
    this.onPressed,
    this.bColor,
    this.btnColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width ?? Get.width,
        // height: height ?? Get.height * 0.07,
        height: height ?? 56,
        decoration: BoxDecoration(
            color: btnColor ?? AppColor.blueThemeColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: bColor ?? AppColor.cTransparent)),
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
        child: Center(
          child: Text(
            title!,
            style: pBold14.copyWith(color: AppColor.cBtnTxt),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class CommonBorderButton extends StatelessWidget {
  final String? title;
  final double? height;
  final double? width;
  final double? radius;
  final Function()? onPressed;
  final Color? bColor;
  final Color? btnColor;
  final Color? textColor;

  CommonBorderButton({
    Key? key,
    this.title,
    this.height,
    this.width,
    this.onPressed,
    this.bColor,
    this.btnColor,
    this.radius,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width ?? Get.width,
        // height: height ?? Get.height * 0.07,
        height: height ?? 43,
        decoration: BoxDecoration(
            color: btnColor ?? AppColor.cWhite,
            borderRadius: BorderRadius.circular(radius ?? 10),
            border:
                Border.all(color: bColor ?? AppColor.blueThemeColor, width: 1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title!,
              style: pBold14.copyWith(color: textColor ?? AppColor.cText),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class CommonIconBorderButton extends StatelessWidget {
  final String? title;
  final double? height;
  final double? width;
  final double? radius;
  final String? iconData;
  final Function()? onPressed;
  final Color? bColor;
  final Color? btnColor;
  final Color? textColor;
  ColorFilter? colorFilter;

  CommonIconBorderButton({
    Key? key,
    this.title,
    this.height,
    this.width,
    this.onPressed,
    this.bColor,
    this.btnColor,
    this.iconData,
    this.radius,
    this.colorFilter,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width ?? Get.width,
        // height: height ?? Get.height * 0.07,
        height: height ?? 43,
        decoration: BoxDecoration(
            color: btnColor ?? AppColor.cWhite,
            borderRadius: BorderRadius.circular(radius ?? 10),
            border:
                Border.all(color: bColor ?? AppColor.blueThemeColor, width: 1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              // width: 100,
              child: FittedBox(
                fit: BoxFit.fill,
                clipBehavior: Clip.antiAliasWithSaveLayer,

                child: Text(
                  title!,
                  style: pBold14.copyWith(color: textColor ?? AppColor.cText),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            horizontalSpace(10),
            iconData == null
                ? horizontalSpace(0)
                : assetSvdImageWidget(
                    image: iconData!, colorFilter: colorFilter)
          ],
        ),
      ),
    );
  }
}

class CommonIconButton extends StatelessWidget {
  final String? title;
  final double? height;
  final double? width;
  final double? radius;
  final String? iconData;
  final Function()? onPressed;
  final Color? bColor;
  final Color? btnColor;
  final Color? textColor;

  CommonIconButton({
    Key? key,
    this.title,
    this.height,
    this.width,
    this.onPressed,
    this.bColor,
    this.btnColor,
    this.iconData,
    this.radius,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width ?? Get.width,
        // height: height ?? Get.height * 0.07,
        height: height ?? 43,
        decoration: BoxDecoration(
            color: btnColor ?? AppColor.blueThemeColor,
            borderRadius: BorderRadius.circular(radius ?? 10),
            border:
                Border.all(color: bColor ?? AppColor.blueThemeColor, width: 1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            assetSvdImageWidget(
              image: iconData!,
            ),
            horizontalSpace(10),
            Text(
              title!,
              style: pBold14.copyWith(color: textColor ?? AppColor.cBtnTxt),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
