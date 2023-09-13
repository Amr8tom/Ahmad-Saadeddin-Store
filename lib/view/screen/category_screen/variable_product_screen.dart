// ignore_for_file: avoid_print, prefer_const_constructors, avoid_function_literals_in_foreach_calls

import 'package:gostore_app/core/controller/category_controller/variable_controller.dart';
import 'package:gostore_app/core/controller/home_controller/product_controller.dart';
import 'package:gostore_app/view/screen/category_screen/product_detail_widget.dart';
import 'package:gostore_app/core/controller/cart_controller/cart_controller.dart';
import 'package:gostore_app/view/screen/home_screen/home_screen_widget.dart';
import 'package:gostore_app/view/widget/common_snak_bar_widget.dart';
import 'package:gostore_app/view/widget/icon_and_image.dart';
import 'package:gostore_app/view/widget/loading_widget.dart';
import '../../widget/common_space_divider_widget.dart';
import '../dashboard_manager/dashboard_manager.dart';
import 'package:gostore_app/utils/text_style.dart';
import '../../widget/common_appbar_widget.dart';
import 'package:gostore_app/utils/colors.dart';
import 'package:gostore_app/utils/helper.dart';
import 'package:flutter/material.dart';
import '../../../utils/images.dart';
import 'package:get/get.dart';

class VariableProductScreen extends StatefulWidget {
  final String id;

  const VariableProductScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<VariableProductScreen> createState() => _VariableProductScreenState();
}

class _VariableProductScreenState extends State<VariableProductScreen>
    with TickerProviderStateMixin {
  VariableController variableController = Get.put(VariableController());
  CartController cartController = Get.find();
  ProductController productController = Get.find();

  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getAllData(widget.id);
    });
  }

  getAllData(id) {
    variableController.getProductDetail(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.cBackGround,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(),
              verticalSpace(15),
              Expanded(
                child: Obx(() {
                  print("==-=-=-=-=-=-=-=${variableController.isColor.value}");
                  print("==-=-=-=-=-=-=-=${variableController.isSize.value}");
                  if (variableController.isDataAvailable.value &&
                      variableController.productImage.value == '') {
                    return LoadingWidget();
                  } else {
                    if (variableController.products != null) {
                      return ListView(
                        children: [
                          Stack(
                            children: [
                              buildCachedNetworkImage(
                                imageUrl: variableController.productImage.value,
                                height: 372.76,
                                width: 327,
                              ),
                              Container(
                                height: 372.76,
                                width: 327,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  // image: DecorationImage(
                                  //     image: NetworkImage(variableController
                                  //         .productImage.value),
                                  //     fit: BoxFit.fill),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 14, horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          variableController.products!.onSale ==
                                                  true
                                              ? saleWidget()
                                              : SizedBox(),
                                          SizedBox(
                                            width: 54,
                                            child: ListView.builder(
                                              itemCount: variableController
                                                  .products!.images!.length,
                                              shrinkWrap: true,
                                              itemBuilder: (context, i) {
                                                var image = variableController
                                                    .products!.images![i];
                                                return Align(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      variableController
                                                          .productImage
                                                          .value = image.src!;
                                                      variableController
                                                          .productIndex
                                                          .value = i;
                                                    },
                                                    child: buildImageContainer(
                                                      image.src!,
                                                      variableController
                                                              .productIndex
                                                              .value ==
                                                          i,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    variableController.products!.onSale == true
                                        ? Container(
                                            height: 35,
                                            width: Get.width,
                                            decoration: BoxDecoration(
                                                color: AppColor.cFav,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "SALE 🔥",
                                                  style: pBold14.copyWith(
                                                      fontSize: 13,
                                                      color: AppColor.cBtnTxt),
                                                ),
                                                horizontalSpace(15),
                                                Text(
                                                  variableController
                                                          .products!.sku ??
                                                      "1D:10H:20M:30S",
                                                  style: pBold14.copyWith(
                                                      fontSize: 13,
                                                      color: AppColor.cBtnTxt),
                                                ),
                                              ],
                                            ),
                                          )
                                        : SizedBox()
                                  ],
                                ),
                              ),
                            ],
                          ),
                          FutureBuilder(
                              future: productController
                                  .addedWishlistProduct(int.parse(widget.id)),
                              builder:
                                  (context, AsyncSnapshot<dynamic> snapshot) {
                                dynamic isInFavourites = snapshot.data;
                                return buildTitleRow(
                                  variableController.products!.name ??
                                      "Beige autumn coat with a hood",
                                  isInFavourites == true
                                      ? DefaultImages.likeIcn
                                      : DefaultImages.unlikeIcn,
                                      () {
                                    if (isInFavourites == true) {
                                      productController.toggleWishList(
                                          wishlistAction: WishlistAction.remove,
                                          product: variableController
                                              .products!);
                                    } else {
                                      productController.toggleWishList(
                                          wishlistAction: WishlistAction.add,
                                          product: variableController
                                              .products!);
                                    }
                                  },
                                );
                              }),
                          buildRatingWidget(
                            initialRating: variableController
                                .products!.ratingCount!
                                .toDouble(),
                            rates: variableController.products!.averageRating ??
                                '18',
                            totalRates: variableController.products!.ratingCount
                                .toString(),
                            productImage: variableController.productImage.value,
                            productName: variableController.products!.name,
                            sku:
                                variableController.products!.sku ?? "ADZ123404",
                            stock: variableController.products!.status ??
                                "In Stock",
                            id: variableController.products!.id.toString(),
                          ),
                          verticalSpace(10),
                          Text(
                            parseHtmlString(
                                variableController.products!.description),
                            style:
                                pMedium12.copyWith(color: AppColor.cGreyFont),
                          ),
                          verticalSpace(8),
                          variableController.isColor.value == false
                              ? SizedBox()
                              : Text(
                                  "Color:".tr,
                                  style: pMedium12.copyWith(
                                      color: AppColor.cGreyFont),
                                ),
                          verticalSpace(
                              variableController.isColor.value == false
                                  ? 0
                                  : 10),
                          Wrap(
                            direction: Axis.horizontal,
                            children: colorChips(),
                          ),
                          verticalSpace(8),
                          variableController.isSize.value == false
                              ? SizedBox()
                              : Text(
                                  "Size:".tr,
                                  style: pMedium12.copyWith(
                                      color: AppColor.cGreyFont),
                                ),
                          verticalSpace(variableController.isSize.value == false
                              ? 0
                              : 10),
                          Wrap(
                            direction: Axis.horizontal,
                            children: sizeChips(),
                          ),
                          TabBar(
                            controller: tabController,
                            indicatorWeight: 3,
                            tabs: [
                              Tab(
                                child: Text("Description".tr),
                              ),
                              Tab(
                                child: Text("Categories".tr),
                              ),
                            ],
                            onTap: (page) {
                              variableController.tabIndex.value = page;
                            },
                            labelStyle: pSemiBold12,
                            labelColor: AppColor.cText,
                            unselectedLabelColor: AppColor.cGreyFont,
                            unselectedLabelStyle:
                                pSemiBold12.copyWith(color: AppColor.cGreyFont),
                            indicatorColor: AppColor.blueThemeColor,
                          ),
                          verticalSpace(15),
                          variableController.tabIndex.value == 0
                              ? buildTabWidget(
                                  string: parseHtmlString(
                                      variableController.products!.description))
                              : buildTabWidget(
                                  string:
                                      "Categories: ${variableController.products!.categories!.first.name}"),
                          // AspectRatio(
                          //   aspectRatio: 1.9,
                          //   child: TabBarView(
                          //       controller: tabController,
                          //       // viewportFraction: 1,
                          //       physics: NeverScrollableScrollPhysics(),
                          //       children: [
                          //         buildTabWidget(
                          //             string: variableController
                          //                 .products!.description),
                          //         buildTabWidget(
                          //             string:
                          //                 "Categories: ${variableController.products!.categories!.first.name}"),
                          //       ]),
                          // ),
                        ],
                      );
                    } else {
                      return LoadingWidget();
                    }
                  }
                }),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Obx(() {
        return cartButtonWidget(cartController.totalCartItem.value, context);
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 24, bottom: 25, right: 24, top: 0),
        child: Obx(() {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              variableController.isDataAvailable.value ||
                      variableController.products == null
                  ? SizedBox(height: 35)
                  : buildPriceWidget(
                      (variableController.quantity *
                              double.parse(
                                  variableController.products!.price ?? '00'))
                          .toString(),
                      variableController.products!.regularPrice ?? '00'),
              verticalSpace(8),
              Container(
                height: 58,
                decoration: BoxDecoration(
                    color: AppColor.blueThemeColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (variableController.quantity > 1) {
                          variableController.quantity -= 1;
                        }
                      },
                      child: assetSvdImageWidget(
                          image: DefaultImages.minusIcn,
                          colorFilter: ColorFilter.mode(
                              AppColor.cBtnTxt, BlendMode.srcIn),
                          width: 26,
                          height: 26),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        variableController.quantity.value.toString(),
                        style: pBold16.copyWith(color: AppColor.cBtnTxt),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        variableController.quantity += 1;
                      },
                      child: assetSvdImageWidget(
                        image: DefaultImages.addIcn,
                        width: 26,
                        height: 26,
                      ),
                    ),
                    VerticalDivider(
                      thickness: 2,
                      color: AppColor.cMenuBlue,
                      indent: 20,
                      endIndent: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        if (variableController.size.value == '' ||
                            variableController.color.value == '') {
                          commonToast("Please select Color and size.");
                        } else {
                          cartController.addToCart(
                            id: widget.id,
                            quantity: variableController.quantity.value.toString(),
                            type: variableController.products!.type!,
                            productsModel: variableController.products!,
                            size: variableController.size.value.toLowerCase(),
                            color: variableController.color.value.toLowerCase(),
                          );
                        }
                      },
                      child: Text(
                        "Add to Cart",
                        style: pBold14.copyWith(color: AppColor.cBtnTxt),
                      ),
                    ),
                    horizontalSpace(10),
                    assetSvdImageWidget(
                      image: DefaultImages.shoppingBasketIcn,
                      height: 16,
                      width: 16,
                    )
                  ],
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  Widget buildTabWidget({String? string}) {
    return Text(
      string ??
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
      style: pMedium12.copyWith(
        color: AppColor.cGreyFont,
      ),
    );
  }

  List<Widget> sizeChips() {
    List<Widget> chips = [];
    print(
        "lengthssssss==========> ${variableController.products!.attributes!.length}");
    variableController.products!.attributes!.forEach((element) {
      print("na==========> ${element.name}");
      if (element.name == "Size") {
        variableController.isSize.value = true;
        for (int i = 0; i < element.options!.length; i++) {
          String data = element.options![i];
          Widget item = Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: FilterChip(
              label: SizedBox(
                child: Text(
                  data,
                  style: pBold12.copyWith(
                      fontSize: 10,
                      color: data == variableController.size.value
                          ? AppColor.cFont
                          : AppColor.cGreyFont),
                ),
              ),
              backgroundColor: AppColor.cBackGround,
              selectedColor: AppColor.cBackGround,
              selected: data == variableController.size.value,
              onSelected: (bool value) {
                variableController.size.value = data;
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: data == variableController.size.value
                      ? AppColor.blueThemeColor
                      : AppColor.cBorder,
                ),
              ),
              showCheckmark: false,
            ),
          );
          chips.add(item);
        }
      }
    });
    return chips;
  }

  List<Widget> colorChips() {
    List<Widget> chips = [];
    variableController.products!.attributes!.forEach((element) {
      if (element.name == "Color") {
        variableController.isColor.value = true;
        for (int i = 0; i < element.options!.length; i++) {
          String data = element.options![i];
          Widget item = Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: FilterChip(
              label: Text(
                data,
                style: pBold12.copyWith(
                    fontSize: 10,
                    color: data == variableController.color.value
                        ? AppColor.cFont
                        : AppColor.cGreyFont),
              ),
              backgroundColor: AppColor.cBackGround,
              selectedColor: AppColor.cBackGround,
              selected: data == variableController.color.value,
              onSelected: (bool value) {
                variableController.color.value = data;
                print("--------color${variableController.color.value}");
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: data == variableController.color.value
                      ? AppColor.blueThemeColor
                      : AppColor.cBorder,
                ),
              ),
              showCheckmark: false,
            ),
          );
          chips.add(item);
        }
      }
    });
    return chips;
  }

  Widget _buildAppBar() {
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
              "Back to Products".tr,
              style: pMedium12.copyWith(color: AppColor.cGreyFont),
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

  Widget buildTitleRow(String title, String icon, Function() onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 230,
            child: Text(
              title,
              style: pBold24.copyWith(fontSize: 21),
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: 39,
              height: 39,
              decoration: BoxDecoration(
                  color: AppColor.cLightBlue, shape: BoxShape.circle),
              child: assetSvdImageWidget(image: icon, height: 25, width: 25),
            ),
          ),
        ],
      ),
    );
  }
}
