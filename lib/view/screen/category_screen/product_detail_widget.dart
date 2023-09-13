// ignore_for_file: prefer_const_constructors, avoid_print, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gostore_app/utils/colors.dart';
import 'package:gostore_app/utils/text_style.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gostore_app/view/screen/category_screen/view_review_screen.dart';
import 'package:gostore_app/view/widget/common_space_divider_widget.dart';

Widget buildRatingWidget({
  double initialRating = 0.0,
  String? rates,
  String? totalRates,
  String? productImage,
  String? productName,
  String? sku,
  String? stock,
  String? id,
}) {
  return Row(
    children: [
      ConstrainedBox(
        constraints: BoxConstraints(minWidth: 100, maxWidth: 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Get.to(() => ViewReviewScreen(
                  productId: id,
                      initialRating: initialRating,
                      rates: rates,
                      totalRates: totalRates,
                      productImage: productImage,
                      productName: productName,
                    ));
              },
              child: Row(
                children: [
                  RatingBar.builder(
                    initialRating: initialRating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 18,
                    unratedColor: AppColor.cGrey,
                    ignoreGestures: true,
                    // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) =>
                        Icon(Icons.star, color: AppColor.blueThemeColor),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  horizontalSpace(4),
                  Text(
                    rates!,
                    style: pMedium12.copyWith(color: AppColor.cGreyFont),
                  ),
                ],
              ),
            ),
            verticalSpace(8),
            Text(
              "${"SKU".tr}: $sku",
              style: pMedium12.copyWith(color: AppColor.cGreyFont),
            ),
          ],
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              buildDotWidget(),
              Text(
                "$totalRates ${"Rates".tr}",
                style: pMedium12.copyWith(color: AppColor.cGreyFont),
              ),
            ],
          ),
          verticalSpace(8),
          Row(
            children: [
              buildDotWidget(),
              Text(
                "Available".tr + ": ",
                style: pMedium12.copyWith(color: AppColor.cGreyFont),
              ),
              Text(
                "$stock".capitalizeFirst!,
                style: pMedium12.copyWith(color: AppColor.cGreen),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

Widget buildPriceWidget(String price, String regularPrice) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "\$$price",
          textAlign: TextAlign.start,
          style: pBold30.copyWith(color: AppColor.cText),
        ),
        horizontalSpace(10),
        regularPrice == ""
            ? SizedBox()
            : Text(
                "\$$regularPrice",
                textAlign: TextAlign.start,
                style: pMedium16.copyWith(color: AppColor.cGreyFont),
              ),
      ],
    ),
  );
}

Widget buildDotWidget() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: Container(
      width: 5,
      height: 5,
      decoration:
          BoxDecoration(color: AppColor.cGreyFont, shape: BoxShape.circle),
    ),
  );
}

Widget buildImageContainer(String image, bool isSelected) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: 42,
      width: 46,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color:
                isSelected == true ? AppColor.cBlack : AppColor.cTransparent),
        image: DecorationImage(image: NetworkImage(image), fit: BoxFit.fill),
      ),
    ),
  );
}
