// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_const_constructors_in_immutables, avoid_print

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gostore_app/core/controller/cart_controller/cart_controller.dart';
import 'package:gostore_app/utils/colors.dart';
import 'package:gostore_app/utils/images.dart';
import 'package:gostore_app/utils/text_style.dart';
import 'package:gostore_app/core/model/product_model.dart';
import 'package:gostore_app/view/screen/category_screen/variable_product_screen.dart';
import 'package:gostore_app/view/widget/icon_and_image.dart';
import 'package:gostore_app/view/widget/common_appbar_widget.dart';
import 'package:gostore_app/view/widget/common_space_divider_widget.dart';
import 'package:gostore_app/view/screen/home_screen/home_screen_widget.dart';
import 'package:gostore_app/view/screen/category_screen/product_detail_screen.dart';
import 'package:gostore_app/core/controller/setting_controller/wishlist_controller.dart';

class WishlistScreen extends StatefulWidget {
  WishlistScreen({Key? key}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  WishlistController wishlistController = Get.put(WishlistController());
  CartController cartController = Get.find();

  @override
  void initState() {
    super.initState();
    getWishList();
  }

  getWishList() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      wishlistController.loadProducts();
    });
  }

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
            child: Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildAppBar(() {
                    wishlistController.clearWishList();
                  }),
                  verticalSpace(18),
                  searchWidget(
                    wishlistController.searchController,
                    onChanged: (value) {
                      value.isEmpty ? getWishList() : wishlistController.onSearchTextChanged(value);
                    },
                    bColor: AppColor.cBorder,
                    onPressed: () {
                      getWishList();
                      wishlistController.searchController.clear();
                    },
                  ),
                  verticalSpace(18),
                  Text(
                    "Add to cart or delete".tr,
                    style: pBold24.copyWith(fontSize: 20),
                  ),
                  Text(
                    "Save your products for next order".tr,
                    style: pMedium12.copyWith(color: AppColor.cGreyFont),
                  ),
                  verticalSpace(10),
                  wishlistController.wishlistList.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: wishlistController.wishlistList.length,
                            shrinkWrap: true,
                            physics: AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              ProductsModel product = wishlistController.wishlistList[index];
                              print("product.regularPrice-----${product.regularPrice}");
                              return GestureDetector(
                                onTap: () {
                                  Get.to(() => ProductDetailScreen(
                                            id: product.id.toString(),
                                          ))!
                                      .then((value) => wishlistController.loadProducts());
                                },
                                child: buildWishlistWidget(
                                  image: product.images!.first.src,
                                  title: product.name,
                                  color: null,
                                  price: product.price,
                                  regularPrice: product.regularPrice,
                                  isSale: product.onSale,
                                  favFun: () {
                                    wishlistController.removeFromWishlist(product, context);
                                    wishlistController.wishlistList.refresh();
                                  },
                                  cartFun: () {
                                    if (product.type == "simple") {
                                      cartController.addToCart(
                                        id: product.id.toString(),
                                        quantity: cartController.quantity.value.toString(),
                                        type: product.type!,
                                        productsModel: product,
                                      );
                                    } else {
                                      Get.to(VariableProductScreen(
                                        id: product.id.toString(),
                                      ));
                                    }
                                  },
                                ),
                              );
                            },
                          ),
                        )
                      : wishlistController.isEmptyWishList.value==true?emptyWishListWidget(context):SizedBox()
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget buildWishlistWidget({
    Color? backGroundColor,
    Color? bColor,
    bool? isSale,
    String? image,
    String? title,
    String? color,
    String? price,
    String? regularPrice,
    Function()? cartFun,
    Function()? favFun,
  }) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          height: 86.48,
          width: Get.width,
          decoration: BoxDecoration(
              color: backGroundColor ?? AppColor.cBackGround,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: bColor ?? AppColor.cBorder)),
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Container(
                height: 68.07,
                width: 64.54,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    image: DecorationImage(image: NetworkImage(image!), fit: BoxFit.fill)),
                padding: EdgeInsets.all(5),
                child: isSale == true
                    ? Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          height: 14,
                          width: 18,
                          decoration: BoxDecoration(
                            color: AppColor.cFav,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              '%',
                              style: pBold12.copyWith(color: AppColor.cBtnTxt),
                            ),
                          ),
                        ),
                      )
                    : SizedBox(),
              ),
              horizontalSpace(8),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title!,
                              style: pBold12.copyWith(fontSize: 10),
                            ),
                            verticalSpace(4),
                            color == null
                                ? verticalSpace(0)
                                : Text(
                                    '${"Color".tr}: $color',
                                    style: pSemiBold8.copyWith(color: AppColor.cGreyFont),
                                  ),
                          ],
                        ),
                        GestureDetector(onTap: favFun, child: assetSvdImageWidget(image: DefaultImages.likeIcn,colorFilter: ColorFilter.mode(AppColor.blueThemeColor, BlendMode.srcIn))),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '\$$price',
                              style: pBold12.copyWith(fontSize: 17, color: AppColor.cText),
                            ),
                            horizontalSpace(4),
                            isSale == true
                                ? Text(
                                    '\$$regularPrice',
                                    style: pSemiBold8.copyWith(color: AppColor.cGreyFont),
                                  )
                                : horizontalSpace(0),
                          ],
                        ),
                        commonMenuIconWidget(
                            icon: DefaultImages.shoppingBasketIcn,
                            onTap: cartFun,
                            bColor: AppColor.blueThemeColor,
                            color: AppColor.blueThemeColor,
                            height: 32,
                            width: 32)
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAppBar(Function() deleteFun) {
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
              "Wishlist".tr,
              style: pBold24.copyWith(fontSize: 20),
            ),
          ],
        ),
        wishlistController.wishlistList.isNotEmpty
            ? commonMenuIconWidget(
                icon: DefaultImages.trashIcn,
                color: AppColor.cBackGround,
                bColor: AppColor.cBorder,
                onTap: deleteFun,
              )
            : SizedBox(),
      ],
    );
  }

  Widget emptyWishListWidget(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          "Your wishlist is Empty".tr,
          style: pSemiBold18.copyWith(color: AppColor.cGreyFont),
        ),
      ),
    );
  }
}
