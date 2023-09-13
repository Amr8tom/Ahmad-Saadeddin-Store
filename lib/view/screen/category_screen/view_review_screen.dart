// ignore_for_file: prefer_const_constructors, avoid_print, prefer_interpolation_to_compose_strings

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gostore_app/core/controller/review_controller/review_controller.dart';
import 'package:gostore_app/core/model/review_model.dart';
import 'package:gostore_app/utils/colors.dart';
import 'package:gostore_app/utils/helper.dart';
import 'package:gostore_app/utils/images.dart';
import 'package:gostore_app/utils/text_style.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gostore_app/view/screen/category_screen/write_review_screen.dart';
import 'package:gostore_app/view/widget/common_button.dart';
import 'package:gostore_app/view/widget/common_appbar_widget.dart';
import 'package:gostore_app/view/widget/common_space_divider_widget.dart';
import 'package:gostore_app/view/screen/category_screen/product_detail_widget.dart';

class ViewReviewScreen extends StatefulWidget {
  final double? initialRating;
  final String? rates;
  final String? productId;
  final String? totalRates;
  final String? productImage;
  final String? productName;

  const ViewReviewScreen(
      {Key? key,
      this.rates,
      this.totalRates,
      this.productImage,
      this.initialRating,
      this.productName, this.productId})
      : super(key: key);

  @override
  State<ViewReviewScreen> createState() => _ViewReviewScreenState();
}

class _ViewReviewScreenState extends State<ViewReviewScreen> {
  ReviewController reviewController = Get.put(ReviewController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getAllReview();
    });
  }

  getAllReview() async {
    await reviewController.getReview(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.cBackGround,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              buildAppBar(),
              verticalSpace(15),
              Expanded(
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
                                widget.productImage ??
                                    DefaultImages.personImage1,
                              ),
                            ),
                          ),
                        ),
                        horizontalSpace(12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.productName ??
                                  "Beige autumn coat with a hood",
                              style: pBold14,
                            ),
                            verticalSpace(4),
                            Row(
                              children: [
                                RatingBar.builder(
                                  initialRating: widget.initialRating!,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 18,
                                  unratedColor: AppColor.cGrey,
                                  ignoreGestures: true,
                                  // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, _) => Icon(Icons.star,
                                      color: AppColor.blueThemeColor),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                                horizontalSpace(4),
                                Text(
                                  widget.rates!,
                                  style: pMedium12.copyWith(
                                      color: AppColor.cGreyFont),
                                ),
                                buildDotWidget(),
                                Text(
                                  "${widget.totalRates} " + "Rates".tr,
                                  style: pMedium12.copyWith(
                                      color: AppColor.cGreyFont),
                                ),
                              ],
                            ),
                            verticalSpace(10),
                            CommonBorderButton(
                              title: 'Write a Review'.tr,
                              onPressed: () {
                                Get.to(() => WriteReviewScreen(
                                rates:widget.rates,
                                totalRates:widget.totalRates,
                                productImage:widget.productImage,
                                productName:widget.productName,
                                    initialRating:widget.initialRating,
                                  productId:widget.productId,
                                ));
                              },
                              width: 120,
                              height: 37,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: horizontalDivider(),
                    ),
                    Obx((){
                        return ListView.separated(
                          itemCount: reviewController.reviewList.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            ReviewModel review=reviewController.reviewList[index];

                            return buildReviewDetail(
                              initialRating: review.rating!.toDouble(),
                              name: review.reviewer,
                              discreption:parseHtmlString(review.review),
                              date: dateFormatted(date:review.dateCreated!, formatType: formatForDateTime(FormatType.date)),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return horizontalDivider();
                          },
                        );
                      }
                    ),
                    // verticalSpace(10),
                    // CommonBorderButton(
                    //   title: 'Show more Reviews'.tr,
                    //   height: 35,
                    //   textColor: AppColor.cFont,
                    //   bColor: AppColor.cBorder,
                    // ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildReviewDetail({
    double initialRating = 0.0,
    String? name,
    String? discreption,
    String? date,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                itemBuilder: (context, _) =>
                    Icon(Icons.star, color: AppColor.blueThemeColor),
                onRatingUpdate: (double value) {},
              ),
              Text(
                'Report'.tr,
                style: pMedium10.copyWith(
                  fontSize: 9,
                  color: AppColor.cRed,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
          verticalSpace(8),
          Text(
            name!,
            style: pBold12.copyWith(
              fontSize: 11,
            ),
          ),
          verticalSpace(10),
          Text(
            discreption!,
            style: pMedium10.copyWith(
              fontSize: 11,
              color: AppColor.cGreyFont,
            ),
          ),
          verticalSpace(10),
          Text(
            'Elisabeth on'.tr + ' $date',
            style: pMedium10.copyWith(
              fontSize: 11,
            ),
          )
        ],
      ),
    );
  }

  Row buildAppBar() {
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
              "Reviews".tr,
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
