// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, unnecessary_brace_in_string_interps, avoid_function_literals_in_foreach_calls, must_be_immutable

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gostore_app/core/controller/cart_controller/cart_controller.dart';
import 'package:gostore_app/core/controller/home_controller/product_controller.dart';
import 'package:gostore_app/core/model/product_model.dart';
import 'package:gostore_app/utils/colors.dart';
import 'package:gostore_app/utils/helper.dart';
import 'package:gostore_app/utils/text_style.dart';
import 'package:gostore_app/core/controller/category_controller/product_detail_controller.dart';
import 'package:gostore_app/view/screen/category_screen/product_detail_widget.dart';
import 'package:gostore_app/view/screen/category_screen/variable_product_screen.dart';
import 'package:gostore_app/view/screen/home_screen/home_screen_widget.dart';
import 'package:gostore_app/view/widget/common_snak_bar_widget.dart';
import 'package:gostore_app/view/widget/icon_and_image.dart';
import 'package:gostore_app/view/widget/loading_widget.dart';
import '../../widget/common_space_divider_widget.dart';
import '../../widget/common_appbar_widget.dart';
import '../../../utils/images.dart';
import '../dashboard_manager/dashboard_manager.dart';
import '../onboarding_screen/onboarding_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  String id;

  ProductDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> with TickerProviderStateMixin {
  ProductDetailController productDetailController = Get.put(ProductDetailController());
  CartController cartController = Get.find();
  ProductController productController = Get.find();

  TabController? tabController;

  @override
  void initState() {
    super.initState();
    // productDetailController.productImage.value = widget.image;
    tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getAllData(widget.id);
    });
  }

  getAllData(id) {
    productDetailController.getProductDetail(id);
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
                  if (productDetailController.isDataAvailable.value ||
                      productDetailController.productImage.value == '') {
                    return LoadingWidget();
                  } else {
                    if (productDetailController.products != null) {
                      return ListView(
                        children: [
                          Stack(
                            children: [
                              ClipRRect( borderRadius: BorderRadius.circular(10),
                                child: buildCachedNetworkImage(
                                  imageUrl: productDetailController.productImage.value,
                                  height: 372.76,
                                  width: 327,
                                ),
                              ),
                              Container(
                                height: 372.76,
                                width: 327,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  // image: DecorationImage(
                                  //     image: NetworkImage(productDetailController
                                  //         .productImage.value),
                                  //     fit: BoxFit.fill),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          productDetailController.products!.onSale == true ? saleWidget() : SizedBox(),
                                          SizedBox(
                                            width: 54,
                                            child: ListView.builder(
                                              itemCount: productDetailController.products!.images!.length,
                                              shrinkWrap: true,
                                              itemBuilder: (context, i) {
                                                var image = productDetailController.products!.images![i];
                                                return Align(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      productDetailController.productImage.value = image.src!;
                                                      productDetailController.productIndex.value = i;
                                                    },
                                                    child: buildImageContainer(
                                                      image.src!,
                                                      productDetailController.productIndex.value == i,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    productDetailController.products!.onSale == true
                                        ? Container(
                                            height: 35,
                                            width: Get.width,
                                            decoration: BoxDecoration(
                                                color: AppColor.cFav, borderRadius: BorderRadius.circular(10)),
                                            padding: EdgeInsets.symmetric(horizontal: 12),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "SALE 🔥",
                                                  style: pBold14.copyWith(fontSize: 13, color: AppColor.cBtnTxt),
                                                ),
                                                horizontalSpace(15),
                                                Text(
                                                  productDetailController.products!.sku ?? "1D:10H:20M:30S",
                                                  style: pBold14.copyWith(fontSize: 13, color: AppColor.cBtnTxt),
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
                              future: productController.addedWishlistProduct(int.parse(widget.id)),
                              builder: (context, AsyncSnapshot<dynamic> snapshot) {
                                dynamic isInFavourites = snapshot.data;
                                return buildTitleRow(
                                  productDetailController.products!.name ?? "Beige autumn coat with a hood",
                                  isInFavourites == true ? DefaultImages.likeIcn : DefaultImages.unlikeIcn,
                                  () {
                                    if (isInFavourites == true) {
                                      productController.toggleWishList(
                                          wishlistAction: WishlistAction.remove,
                                          product: productDetailController.products!);
                                    } else {
                                      productController.toggleWishList(
                                          wishlistAction: WishlistAction.add,
                                          product: productDetailController.products!);
                                    }
                                    setState(() {});
                                  },
                                );
                              }),
                          buildRatingWidget(
                            initialRating: productDetailController.products!.ratingCount!.toDouble(),
                            rates: productDetailController.products!.averageRating ?? '18',
                            totalRates: productDetailController.products!.ratingCount.toString(),
                            productImage: productDetailController.productImage.value,
                            productName: productDetailController.products!.name,
                            sku: productDetailController.products!.sku ?? "ADZ123404",
                            stock: productDetailController.products!.status ?? "In Stock",
                            id: productDetailController.products!.id.toString(),
                          ),
                          verticalSpace(10),
                          Text(
                            parseHtmlString(productDetailController.products!.description),
                            style: pMedium12.copyWith(color: AppColor.cGreyFont),
                          ),
                          verticalSpace(8),
                          productDetailController.isColor.value == false
                              ? SizedBox()
                              : Text(
                                  "Color:".tr,
                                  style: pMedium12.copyWith(color: AppColor.cGreyFont),
                                ),
                          verticalSpace(productDetailController.isColor.value == false ? 0 : 10),
                          Wrap(
                            direction: Axis.horizontal,
                            children: colorChips(),
                          ),
                          verticalSpace(8),
                          productDetailController.isSize.value == false
                              ? SizedBox()
                              : Text(
                                  "Size:".tr,
                                  style: pMedium12.copyWith(color: AppColor.cGreyFont),
                                ),
                          verticalSpace(productDetailController.isSize.value == false ? 0 : 10),
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
                              productDetailController.tabIndex.value = page;
                            },
                            labelStyle: pSemiBold12,
                            labelColor: AppColor.cText,
                            unselectedLabelColor: AppColor.cGreyFont,
                            unselectedLabelStyle: pSemiBold12.copyWith(color: AppColor.cGreyFont),
                            indicatorColor: AppColor.blueThemeColor,
                          ),
                          verticalSpace(15),
                          productDetailController.tabIndex.value == 0
                              ? buildTabWidget(string: parseHtmlString(productDetailController.products!.description))
                              : buildTabWidget(
                                  string: "Categories: ${productDetailController.products!.categories!.first.name}"),
                          verticalSpace(10),
                          Text(
                            'You might also like'.tr,
                            style: pBold12,
                          ),
                          verticalSpace(10),
                          productDetailController.isRelatedDataAvailable.value
                              ? LoadingWidget()
                              : productDetailController.relatedProductList.isNotEmpty
                                  ? SizedBox(
                                      height: 300,
                                      child: PageView.builder(
                                        itemCount: productDetailController.relatedProductList.length,
                                        allowImplicitScrolling: true,
                                        padEnds: false,
                                        scrollDirection: Axis.horizontal,
                                        physics: BouncingScrollPhysics(),
                                        // controller: pageController,
                                        controller: PageController(
                                          initialPage: 0,
                                          viewportFraction: 0.5,
                                        ),
                                        onPageChanged: (page) {
                                          productDetailController.currantIndex.value = (page / 2).round();
                                        },
                                        itemBuilder: ((context, index) {
                                          ProductsModel product = productDetailController.relatedProductList[index];

                                          return Padding(
                                            padding: const EdgeInsets.only(left: 15),
                                            child: FutureBuilder(
                                                future: productController.addedWishlistProduct(product.id),
                                                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                                                  dynamic isInFavourites = snapshot.data;
                                                  return GestureDetector(
                                                    onTap: () {
                                                      widget.id = product.id.toString();
                                                      getAllData(product.id.toString());
                                                    },
                                                    child: ProductWidget(
                                                      image: product.images!.first.src,
                                                      title: product.name,
                                                      regularPrize: "\$${product.regularPrice}",
                                                      prize: "\$${product.price}",
                                                      saleCode: product.sku,
                                                      isSale: product.onSale,
                                                      isLike: isInFavourites,
                                                      favFun: () {
                                                        if (isInFavourites == true) {
                                                          productController.toggleWishList(
                                                              wishlistAction: WishlistAction.remove, product: product);
                                                        } else {
                                                          productController.toggleWishList(
                                                              wishlistAction: WishlistAction.add, product: product);
                                                        }
                                                        productDetailController.relatedProductList.refresh();
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
                                                      isRate: true,
                                                      rate: product.averageRating.toString(),
                                                      initialRating: product.ratingCount!.toDouble(),
                                                    ),
                                                  );
                                                }),
                                          );
                                        }),
                                      ),
                                    )
                                  : Center(
                                      child: Text("Related product not found",
                                          style: pSemiBold12.copyWith(color: AppColor.cGreyFont))),
                          productDetailController.relatedProductList.isEmpty ||
                                  productDetailController.relatedProductList.length == 1
                              ? SizedBox()
                              : Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 18),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: buildPageIndicator(
                                        int.parse(
                                            (productDetailController.relatedProductList.length / 2).round().toString()),
                                        productDetailController.currantIndex.value),
                                  ),
                                ),
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
              productDetailController.isDataAvailable.value || productDetailController.products == null
                  ? SizedBox(height: 35)
                  : buildPriceWidget(
                      (productDetailController.quantity * double.parse(productDetailController.products!.price ?? '00'))
                          .toString(),
                      productDetailController.products!.regularPrice ?? '00'),
              verticalSpace(8),
              Container(
                height: 58,
                decoration: BoxDecoration(color: AppColor.blueThemeColor, borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (productDetailController.quantity > 1) {
                          productDetailController.quantity -= 1;
                        }
                      },
                      child: assetSvdImageWidget(
                          image: DefaultImages.minusIcn,
                          colorFilter: ColorFilter.mode(AppColor.cBtnTxt, BlendMode.srcIn),
                          width: 26,
                          height: 26),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        productDetailController.quantity.value.toString(),
                        style: pBold16.copyWith(color: AppColor.cBtnTxt),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        productDetailController.quantity += 1;
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
                        if (productDetailController.products!.type == "simple") {
                          cartController.addToCart(
                              id: widget.id,
                              quantity: productDetailController.quantity.value.toString(),
                              type: productDetailController.products!.type!,
                              color: productDetailController.color.value.toLowerCase(),
                              size: productDetailController.size.value.toLowerCase(),
                              productsModel: productDetailController.products!,
                              quantityMap: {});
                        } else {
                          if (productDetailController.color.value == '' || productDetailController.size.value == '') {
                            commonToast("Please select variant.");
                          } else {
                            cartController.addToCart(
                              id: widget.id,
                              quantity: productDetailController.quantity.value.toString(),
                              type: productDetailController.products!.type!,
                              size: productDetailController.size.value.toLowerCase(),
                              color: productDetailController.color.value.toLowerCase(),
                              productsModel: productDetailController.products!,
                            );
                          }
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
    productDetailController.isSize.value = false;

    productDetailController.products!.attributes!.forEach((element) {
      if (element.name == "Size") {
        productDetailController.isSize.value = true;
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
                      color: data == productDetailController.size.value ? AppColor.cFont : AppColor.cGreyFont),
                ),
              ),
              backgroundColor: AppColor.cBackGround,
              selectedColor: AppColor.cBackGround,
              selected: data == productDetailController.size.value,
              onSelected: (bool value) {
                productDetailController.size.value = data;
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: data == productDetailController.size.value ? AppColor.blueThemeColor : AppColor.cBorder,
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
    productDetailController.isColor.value = false;
    productDetailController.products!.attributes!.forEach((element) {
      if (element.name == "Color") {
        productDetailController.isColor.value = true;
        for (int i = 0; i < element.options!.length; i++) {
          String data = element.options![i];
          Widget item = Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: FilterChip(
              label: Text(
                data,
                style: pBold12.copyWith(
                    fontSize: 10,
                    color: data == productDetailController.color.value ? AppColor.cFont : AppColor.cGreyFont),
              ),
              backgroundColor: AppColor.cBackGround,
              selectedColor: AppColor.cBackGround,
              selected: data == productDetailController.color.value,
              onSelected: (bool value) {
                productDetailController.color.value = data;
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: data == productDetailController.color.value ? AppColor.blueThemeColor : AppColor.cBorder,
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
              decoration: BoxDecoration(color: AppColor.cLightBlue, shape: BoxShape.circle),
              child: assetSvdImageWidget(
                image: icon,
                height: 25,
                width: 25,
                colorFilter: ColorFilter.mode(AppColor.blueThemeColor, BlendMode.srcIn),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
