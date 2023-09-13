// ignore_for_file: prefer_const_constructors, avoid_print, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:gostore_app/utils/colors.dart';
import 'package:gostore_app/utils/images.dart';
import 'package:gostore_app/utils/text_style.dart';
import 'package:gostore_app/view/widget/common_appbar_widget.dart';
import 'package:gostore_app/view/widget/common_space_divider_widget.dart';
import 'package:gostore_app/view/widget/icon_and_image.dart';
import 'package:gostore_app/view/widget/loading_widget.dart';

Widget homeBackgroundWidget() => Container(
      height: 450,
      width: Get.width,
      decoration: BoxDecoration(
          color: AppColor.cNavyBlue,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))),
      child: assetSvdImageWidget(
        width: Get.width,
        fit: BoxFit.fill,
        image: DefaultImages.homeBgIcn,
      ),
    );

Widget titleRowWidget(Function() menuTap, Function() searchTap, String title) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      InkWell(
        onTap: menuTap,
        child: commonMenuIconWidget(
          icon: DefaultImages.menuIcn,
          onTap: null,
          colorFilter: ColorFilter.mode(AppColor.cWhiteFont, BlendMode.srcIn),
          bColor: AppColor.cWhiteFont,
        ),
      ),
      Text(
        title,
        style: pBold24.copyWith(color: AppColor.cWhiteFont),
      ),
      commonMenuIconWidget(
        icon: DefaultImages.searchIcn,
        onTap: searchTap,
        colorFilter: ColorFilter.mode(AppColor.cWhiteFont, BlendMode.srcIn),
        bColor: AppColor.cWhiteFont,
      ),
    ],
  );
}

Widget categoryWidget({
  Function()? onTap,
  String? image,
  String? label,
  Color? color,
  Color? textColor,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 0),
    child: GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.deferToChild,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: image == null
                    ? SizedBox()
                    : CachedNetworkImage(
                        imageUrl: image,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress,strokeWidth: 1),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                // child: image == null ? SizedBox() : Image.network(image),
              )),
          verticalSpace(8),
          SizedBox(
            width: 70,
            child: Text(
              label!,
              style: pMedium12.copyWith(color: textColor),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget searchWidget(
  TextEditingController controller, {
  Color? bColor,
  ValueChanged<String>? onChanged,
  bool readOnly = false,
  Function()? onTap,
  Function()? onPressed,
}) =>
    TextFormField(
      controller: controller,
      cursorColor: AppColor.cNavyBlue,
      style: pMedium12,
      onChanged: onChanged,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColor.cWhite,
        hintText: 'Search...',
        hintStyle: pMedium12,
        prefixIcon: assetSvdImageWidget(
            image: DefaultImages.searchIcn,
            colorFilter: ColorFilter.mode(AppColor.cBlack, BlendMode.srcIn)),
        prefixIconConstraints: BoxConstraints(minWidth: 43, maxWidth: 45),
        suffixIcon: IconButton(
          icon: Icon(Icons.clear, color: AppColor.cGreyFont),
          onPressed: onPressed,
        ),
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: bColor ?? AppColor.searchBorder)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: bColor ?? AppColor.searchBorder)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: bColor ?? AppColor.searchBorder)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: bColor ?? AppColor.searchBorder)),
      ),
    );

Widget bestSellerWidget({
  String? image,
  String? title,
  String? subTitle,
  Function()? onTap,
  List? list,
  int? currantIndex,
  bool? isShowIndicator,
}) {
  return Row(
    children: [
      SizedBox(
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Text(
                    title!,
                    style: pBold24,
                  ),
                ),
                verticalSpace(4),
                Text(
                  subTitle!,
                  style: pMedium10.copyWith(color: AppColor.cWhiteFont),
                ),
                verticalSpace(12),
              ],
            ),
            CommonProductButton(
              iconData: DefaultImages.arrowRightIcn,
              title: 'Show products'.tr,
              btnColor: AppColor.cNavyBlue,
              bColor: AppColor.cNavyBlue,
              textColor: AppColor.cWhiteFont,
              colorFilter:
                  ColorFilter.mode(AppColor.cWhiteFont, BlendMode.srcIn),
              width: 145,
              height: 28,
              onPressed: onTap,
            ),
            verticalSpace(isShowIndicator == true ? 15 : 0),
            isShowIndicator == true
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: _buildPageIndicator(list!, currantIndex),
                  )
                : horizontalSpace(0),
          ],
        ),
      ),
      horizontalSpace(15),
      image == null
          ? SizedBox()
          : Expanded(
              flex: 1,
              child: Image.network(
                image,
                // fit: BoxFit.cover,
              ),
            ),
    ],
  );
}

List<Widget> _buildPageIndicator(List list, currantIndex) {
  List<Widget> itemList = [];
  for (int i = 0; i < list.length; i++) {
    itemList.add(i == currantIndex ? _indicator(true) : _indicator(false));
  }
  return itemList;
}

Widget _indicator(bool isActive) {
  return SizedBox(
    height: 10,
    child: AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 4),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: isActive ? AppColor.cNavyBlue : AppColor.cWhite,
        shape: BoxShape.circle,
      ),
    ),
  );
}

seeAllRowWidget(String title, Function() function) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Text(
          title,
          style: pBold16,
        ),
      ),
      TextButton(
        onPressed: function,
        child: Text(
          "See All".tr,
          style: pMedium12.copyWith(
              decoration: TextDecoration.underline, color: AppColor.cText),
        ),
      ),
    ],
  );
}

class ProductWidget extends StatelessWidget {
  final String? image;
  final bool? isSale;
  final bool? isLike;
  final bool? isRate;
  final String? saleCode;
  final String? title;
  final String? regularPrize;
  final String? prize;
  final String? rate;
  final double? initialRating;

  final Function()? cartFun;
  final Function()? favFun;

  const ProductWidget(
      {Key? key,
      this.image,
      this.isSale,
      this.isLike,
      this.saleCode,
      this.title,
      this.regularPrize,
      this.prize,
      this.cartFun,
      this.favFun,
      this.isRate,
      this.rate,
      this.initialRating})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 215,
          width: 155,
          decoration: BoxDecoration(
            color: AppColor.cLightBlue,
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(image: CachedNetworkImageProvider(image!,), fit: BoxFit.fill),
          ),
          child: Stack(
            children: [
              // buildCachedNetworkImage(
              //   imageUrl: image!,
              //   height: 215,
              //   width: 155,
              // ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        isSale == true ? saleWidget() : horizontalSpace(0),
                        GestureDetector(
                          onTap: favFun,
                          child: CircleAvatar(
                            radius: 11,
                            backgroundColor: AppColor.cWhite,
                            child: isLike == true
                                ? assetSvdImageWidget(
                                    image: DefaultImages.likeIcn,
                                    colorFilter: ColorFilter.mode(
                                        AppColor.blueThemeColor,
                                        BlendMode.srcIn),
                                  )
                                : assetSvdImageWidget(
                                    image: DefaultImages.unlikeIcn),
                          ),
                        ),
                      ],
                    ),
                  ),
                  isSale == true
                      ? Container(
                          height: 25,
                          width: Get.width,
                          decoration: BoxDecoration(
                              color: AppColor.cFav,
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: FittedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "SALE 🔥 ",
                                  style: pBold14.copyWith(
                                      fontSize: 10, color: AppColor.cBtnTxt),
                                ),
                                Text(
                                  saleCode!,
                                  style: pBold14.copyWith(
                                      fontSize: 10, color: AppColor.cBtnTxt),
                                ),
                              ],
                            ),
                          ),
                        )
                      : horizontalSpace(0),
                ],
              ),
            ],
          ),
        ),
        verticalSpace(10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title!,
                    style: pBold14.copyWith(fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  verticalSpace(8),
                  FittedBox(
                    child: Row(
                      children: [
                        isSale == true
                            ? FittedBox(
                                child: Text(
                                  regularPrize!,
                                  style: pBold14.copyWith(
                                      fontSize: 12, color: AppColor.cGreyFont),
                                ),
                              )
                            : horizontalSpace(0),
                        horizontalSpace(isSale == true ? 8 : 0),
                        Text(
                          prize!,
                          style: pBold14.copyWith(
                              fontSize: 12, color: AppColor.cText),
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(isRate == true ? 8 : 0),
                  isRate == true
                      ? Row(
                          children: [
                            RatingBar.builder(
                              initialRating: initialRating ?? 0.0,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 12,
                              unratedColor: AppColor.cGrey,
                              ignoreGestures: true,
                              // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(Icons.star,
                                  color: AppColor.blueThemeColor),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                            Text(
                              rate!,
                              style: pSemiBold10.copyWith(
                                  color: AppColor.cGreyFont),
                            )
                          ],
                        )
                      : verticalSpace(0),
                ],
              ),
            ),
            horizontalSpace(8),
            commonMenuIconWidget(
              onTap: cartFun,
              color: AppColor.blueThemeColor,
              icon: DefaultImages.shoppingBasketIcn,
              bColor: AppColor.blueThemeColor,
              width: 32,
              height: 32,
            ),
          ],
        ),
      ],
    );
  }
}

Widget saleWidget() {
  return Container(
    // height: 15,
    // width: 50,
    decoration: BoxDecoration(
      color: AppColor.cFav,
      borderRadius: BorderRadius.circular(
        10,
      ),
    ),
    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
    child: Center(
      child: Text(
        "SALE".tr,
        style: pBold14.copyWith(fontSize: 10, color: AppColor.cBtnTxt),
      ),
    ),
  );
}

Widget blogPostWidget(
    {String? image, String? title, String? subtitle, String? date}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: 218,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          // image: DecorationImage(
          //   image: CachedNetworkImageProvider (image!),
          //   fit: BoxFit.fill,
          // ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(9),
          child: CachedNetworkImage(
            imageUrl: image!,
            height: 218,
            width: Get.width,
            fit: BoxFit.fill,
            placeholder: (context, url) => LoadingWidget(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
        // padding: EdgeInsets.symmetric(horizontal: 6, vertical: 16),
        // child: Align(
        //   alignment: Alignment.topLeft,
        //   child: Container(
        //     height: 15,
        //     width: 70,
        //     decoration: BoxDecoration(
        //       color: AppColor.cFav,
        //       borderRadius: BorderRadius.circular(10),
        //     ),
        //     child: Center(
        //       child: Text(
        //         "Products".tr,
        //         style: pBold14.copyWith(
        //           color: AppColor.cBtnTxt,
        //           fontSize: 10,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ),
      verticalSpace(Get.height * 0.015),
      Text(
        title!,
        style: pBold14.copyWith(fontSize: Get.height * 0.018),
      ),
      verticalSpace(Get.height * 0.015),
      Expanded(
        child: Text(
          subtitle! + subtitle,
          style: pMedium12.copyWith(
              fontSize: Get.height * 0.015, color: AppColor.cGreyFont),
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      verticalSpace(Get.height * 0.015),
      Text(
        date!,
        style: pBold14.copyWith(
            fontSize: Get.height * 0.015, color: AppColor.cGreyFont),
      ),
    ],
  );
}

class CommonProductButton extends StatelessWidget {
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

  CommonProductButton({
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
              width: 100,
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
