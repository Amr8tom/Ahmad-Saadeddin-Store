// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gostore_app/utils/colors.dart';
import 'package:gostore_app/utils/images.dart';
import 'package:gostore_app/utils/text_style.dart';
import 'package:gostore_app/view/widget/common_space_divider_widget.dart';
import 'package:gostore_app/view/widget/icon_and_image.dart';

Widget buildAppBar(String title,{Color?titleColor}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          commonMenuIconWidget(
            icon: DefaultImages.backIcn,
            color: AppColor.cLightBlue,
            bColor: AppColor.cLightBlue,
            onTap: () {
              Get.back();
            },
          ),
          horizontalSpace(15),
          Text(
            title,
            style: pBold24.copyWith(fontSize: 20,color: titleColor??AppColor.cFont),
          ),
        ],
      ),
    ],
  );
}

Widget commonMenuIconWidget(
    {Function()? onTap,
    String? icon,
    Color? bColor,
    Color? color,
    ColorFilter? colorFilter,
    double? height,
    double? width}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: height ?? 43,
      width: width ?? 43,
      decoration: BoxDecoration(
          color: color,
          border: Border.all(color: bColor ?? AppColor.cIconBorder),
          borderRadius: BorderRadius.circular(10)),
      child: assetSvdImageWidget(image: icon, colorFilter: colorFilter),
    ),
  );
}
