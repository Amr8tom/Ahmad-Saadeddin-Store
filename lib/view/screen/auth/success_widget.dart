// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gostore_app/utils/colors.dart';
import 'package:gostore_app/utils/text_style.dart';
import 'package:gostore_app/view/widget/common_button.dart';
import 'package:gostore_app/view/widget/icon_and_image.dart';

class SuccessWidget extends StatelessWidget {
  final String?image;
  final String?title;
  final String?subTitle;
  final String?btnName;
  final Function()? onTap;
   const SuccessWidget({Key? key, this.image, this.title, this.subTitle, this.onTap, this.btnName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(right: 24, left: 24,top: Get.height*0.13,bottom: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                assetSvdImageWidget(image:image),
                Text(
                 title!,
                  style: pBold24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35,vertical: 15),
                  child: Text(
                  subTitle!,
                    style: pMedium14.copyWith(color: AppColor.cGreyFont),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            CommonButton( title: btnName,
            onPressed: onTap,)
          ],
        ),
      ),
    );
  }
}
