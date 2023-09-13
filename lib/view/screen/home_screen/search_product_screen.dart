// ignore_for_file: must_be_immutable, prefer_const_constructors, prefer_const_constructors_in_immutables, avoid_print

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gostore_app/core/controller/cart_controller/cart_controller.dart';
import 'package:gostore_app/core/controller/home_controller/product_controller.dart';
import 'package:gostore_app/core/model/product_model.dart';
import 'package:gostore_app/utils/colors.dart';
import 'package:gostore_app/utils/images.dart';
import 'package:gostore_app/utils/text_style.dart';
import 'package:gostore_app/view/screen/category_screen/product_detail_screen.dart';
import 'package:gostore_app/view/screen/category_screen/variable_product_screen.dart';
import 'package:gostore_app/view/screen/dashboard_manager/dashboard_manager.dart';
import 'package:gostore_app/view/screen/home_screen/filter_widget.dart';
import 'package:gostore_app/view/widget/icon_and_image.dart';
import 'package:gostore_app/view/widget/common_appbar_widget.dart';
import 'package:gostore_app/view/widget/common_space_divider_widget.dart';
import 'package:gostore_app/view/screen/home_screen/home_screen_widget.dart';
import 'package:gostore_app/core/controller/home_controller/search_controller.dart';

class SearchProductScreen extends StatefulWidget {
  SearchProductScreen({Key? key}) : super(key: key);

  @override
  State<SearchProductScreen> createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
  SearchProductController searchController = Get.put(SearchProductController());

  CartController cartController = Get.find();
  ProductController productController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getProduct();
    });
  }

  getProduct() {
    searchController.searchProduct('');
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
                  Row(
                    children: [
                      commonMenuIconWidget(
                        onTap: () {
                          Get.back();
                        },
                        icon: DefaultImages.backIcn,
                        color: AppColor.cLightBlue,
                        bColor: AppColor.cLightBlue,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SizedBox(
                            height: 43,
                            child: searchWidget(
                              searchController.searchTextEditingController,
                              bColor: AppColor.cBorder,
                              onChanged: (value) {
                                if (value.length >= 3) {
                                  print("value------>$value");
                                  searchController.searchProduct(value);
                                }
                              },
                              onPressed: () {
                                searchController.searchTextEditingController.clear();
                                searchController.searchProduct('');
                              },
                            ),
                          ),
                        ),
                      ),
                      commonMenuIconWidget(
                        onTap: () {
                          showModalBottomSheet(
                              backgroundColor: AppColor.cTransparent,
                              barrierColor: AppColor.cDarkGrey,
                              context: context,
                              constraints: BoxConstraints(maxHeight: Get.height - 100, minHeight: Get.height - 100),
                              isScrollControlled: true,
                              // isDismissible: false,
                              // enableDrag: false,
                              shape:
                                  RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
                              builder: (context) {
                                return FilterBottomSheet();
                              });
                        },
                        icon: DefaultImages.filtersIcn,
                      ),
                    ],
                  ),
                  buildFindProductTextWidget('${searchController.searchProductList.length}'),
                  Expanded(
                    child: ListView.builder(
                      itemCount: searchController.searchProductList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        ProductsModel product = searchController.searchProductList[index];
                        return FutureBuilder(
                            future: productController.addedWishlistProduct(product.id),
                            builder: (context, AsyncSnapshot<dynamic> snapshot) {
                              dynamic isInFavourites = snapshot.data;
                              return GestureDetector(
                                onTap: () {
                                  Get.to(() => ProductDetailScreen(
                                        id: product.id.toString(),
                                      ));
                                },
                                child: searchProductWidget(
                                  image: product.images!.first.src,
                                  title: product.name,
                                  regularPrice: product.regularPrice,
                                  price: product.price,
                                  isSale: product.onSale,
                                  isFav: isInFavourites,
                                  favFun: () {
                                    if (isInFavourites == true) {
                                      productController.toggleWishList(
                                          wishlistAction: WishlistAction.remove, product: product);
                                    } else {
                                      productController.toggleWishList(
                                          wishlistAction: WishlistAction.add, product: product);
                                    }
                                    searchController.searchProductList.refresh();
                                  },
                                  cartFun: () {
                                    if (product.type == 'simple') {
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
                            });
                      },
                    ),
                  )
                ],
              );
            }),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: cartButtonWidget(cartController.totalCartItem.value, context),
      ),
    );
  }

  Widget searchProductWidget({
    String? image,
    String? title,
    String? regularPrice,
    String? price,
    bool? isFav,
    bool? isSale,
    Function()? favFun,
    Function()? cartFun,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        color: AppColor.cBackGround,
        height: 82,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 89,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColor.cLightBlue,
                    borderRadius: BorderRadius.circular(9),
                    image: DecorationImage(
                      image: NetworkImage(
                        image!,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                horizontalSpace(10),
                SizedBox(
                  // width: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      isSale == true ? saleWidget() : SizedBox(),
                      Text(
                        title!,
                        style: pBold12,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                      Row(
                        children: [
                          isSale == false || regularPrice == ''
                              ? SizedBox()
                              : FittedBox(
                                  child: Text(
                                    '\$$regularPrice',
                                    style: pBold14.copyWith(
                                      fontSize: 12,
                                      color: AppColor.cGreyFont,
                                    ),
                                  ),
                                ),
                          horizontalSpace( isSale == false || regularPrice == '' ? 0 : 8),
                          Text(
                            '\$$price',
                            style: pBold14.copyWith(
                              fontSize: 12,
                              color: AppColor.cText,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: favFun,
                  child: CircleAvatar(
                    radius: 11,
                    backgroundColor: AppColor.cLightBlue,
                    child: assetSvdImageWidget(
                      image: isFav == true ? DefaultImages.likeIcn : DefaultImages.unlikeIcn,
                    ),
                  ),
                ),
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
        ),
      ),
    );
  }
}

Widget buildFindProductTextWidget(String totalProduct) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 15),
    child: RichText(
      text: TextSpan(
        text: '$totalProduct ${"products".tr} ',
        style: pBold12.copyWith(color: AppColor.cText, fontSize: 10),
        children: [TextSpan(text: 'are found'.tr, style: pMedium10)],
      ),
    ),
  );
}
