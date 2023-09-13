// ignore_for_file: avoid_print, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:gostore_app/core/controller/review_controller/review_controller.dart';
import 'package:gostore_app/utils/colors.dart';
import 'package:gostore_app/utils/images.dart';
import 'package:gostore_app/utils/text_style.dart';
import 'package:gostore_app/utils/validator.dart';
import 'package:gostore_app/view/screen/category_screen/product_detail_widget.dart';
import 'package:gostore_app/view/widget/common_appbar_widget.dart';
import 'package:gostore_app/view/widget/common_button.dart';
import 'package:gostore_app/view/widget/common_space_divider_widget.dart';
import 'package:gostore_app/view/widget/common_text_field.dart';

class WriteReviewScreen extends StatelessWidget {
  final double? initialRating;
  final String? productId;

  final String? rates;
  final String? totalRates;
  final String? productImage;
  final String? productName;

  WriteReviewScreen(
      {Key? key,
      this.rates,
      this.totalRates,
      this.productImage,
      this.productName,
      this.initialRating,
      this.productId})
      : super(key: key);
  ReviewController reviewController = Get.find();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: AppColor.cBackGround,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildAppBar(),
                verticalSpace(15),
                Expanded(
                  child: Obx(() {
                    print(reviewController.rate.value);
                    return Form(
                      key: formKey,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 96,
                                width: 77,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      productImage!,
                                    ),
                                  ),
                                ),
                              ),
                              horizontalSpace(12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    productName!,
                                    style: pBold14,
                                  ),
                                  verticalSpace(4),
                                  Row(
                                    children: [
                                      RatingBar.builder(
                                        initialRating:
                                            initialRating!.toDouble(),
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: false,
                                        itemCount: 5,
                                        itemSize: 22,
                                        unratedColor: AppColor.cGrey,
                                        ignoreGestures: true,
                                        // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                        itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: AppColor.blueThemeColor),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                          reviewController.rate.value = rating;
                                        },
                                      ),
                                      horizontalSpace(4),
                                      Text(
                                        rates!,
                                        style: pMedium12.copyWith(
                                            color: AppColor.cGreyFont),
                                      ),
                                      buildDotWidget(),
                                      Text(
                                        "$totalRates ${"Rates".tr}",
                                        style: pMedium12.copyWith(
                                            color: AppColor.cGreyFont),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: horizontalDivider(),
                          ),
                          verticalSpace(10),
                          Text(
                            "Select your Rate:".tr,
                            style: pBold14,
                          ),
                          verticalSpace(8),
                          RatingBar.builder(
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 40,
                            unratedColor: AppColor.cGrey,
                            ignoreGestures: false,
                            glowColor: AppColor.cLightBlue,
                            itemBuilder: (context, _) => Icon(Icons.star,
                                color: AppColor.blueThemeColor),
                            onRatingUpdate: (rating) {
                              print(rating);
                              reviewController.rate.value = rating;
                            },
                          ),
                          verticalSpace(10),
                          CommonTextField(
                            controller: reviewController.nameController,
                            labelText: 'Your Name'.tr,
                            hintText: 'Enter your name',
                            validator: (value) {
                              return Validator.validateName(
                                  value!, "Reviewer name");
                            },
                          ),
                          verticalSpace(10),
                          CommonTextField(
                            controller: reviewController.emailController,
                            labelText: 'Reviewer Email'.tr,
                            hintText: 'Enter your reviewer email',
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              return Validator.validateEmail(value!);
                            },
                          ),
                          verticalSpace(10),
                          CommonTextField(
                            controller: reviewController.descriptionController,
                            labelText: 'Description'.tr,
                            hintText: 'Description',
                            maxLines: 6,
                            validator: (value) {
                              return Validator.validateRequired(value!);
                            },
                          ),
                          verticalSpace(20),
                          CommonButton(
                            title: 'Send Review'.tr,
                            bColor: AppColor.cBorder,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                reviewController.addReview(
                                    id: int.parse(productId!),
                                    rating: reviewController.rate.value.toInt(),
                                    reviewer: reviewController.nameController.text.trim(),
                                    reviewerEmail: reviewController.emailController.text.trim(),
                                    review: reviewController.descriptionController.text.trim(),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            commonMenuIconWidget(
              icon: DefaultImages.backIcn,
              onTap: () {
                Get.back();
              },
              bColor: AppColor.cLightBlue,
              color: AppColor.cLightBlue,
            ),
            horizontalSpace(15),
            Text(
              "Write a Review",
              style: pBold24.copyWith(
                fontSize: 20,
              ),
            ),
          ],
        ),
        // commonMenuIconWidget(
        //   icon: DefaultImages.moreVerticalIcn,
        //   bColor: AppColor.cBorder,
        // ),
      ],
    );
  }
}
