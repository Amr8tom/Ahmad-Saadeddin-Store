// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gostore_app/core/controller/cart_controller/cart_controller.dart';
import 'package:gostore_app/core/controller/home_controller/product_controller.dart';
import 'package:gostore_app/core/model/product_model.dart';
import 'package:gostore_app/utils/colors.dart';
import 'package:gostore_app/utils/text_style.dart';
import 'package:gostore_app/view/screen/category_screen/variable_product_screen.dart';
import 'package:gostore_app/view/widget/common_appbar_widget.dart';
import 'package:gostore_app/view/widget/common_space_divider_widget.dart';

import '../category_screen/product_detail_screen.dart';
import 'home_screen_widget.dart';

class OnSaleProductListScreen extends StatefulWidget {
  final List<ProductsModel> dataList;
  final String appTitle;

  const OnSaleProductListScreen(
      {Key? key, required this.dataList, required this.appTitle})
      : super(key: key);

  @override
  State<OnSaleProductListScreen> createState() =>
      _OnSaleProductListScreenState();
}

class _OnSaleProductListScreenState extends State<OnSaleProductListScreen> {
  ProductController productController = Get.put(ProductController());

  CartController cartController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productController.productList.value = widget.dataList;
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
              buildAppBar(widget.appTitle),
              verticalSpace(20),
              Expanded(
                child: Obx(() {
                  return ListView(
                    shrinkWrap: true,
                    children: [
                      productController.productList.isNotEmpty
                          ? GridView.builder(
                              itemCount: productController.productList.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      // childAspectRatio: 0.55,
                                      childAspectRatio: Get.height * 0.0007,
                                      crossAxisSpacing: 15,
                                      mainAxisSpacing: 15),
                              itemBuilder: (context, index) {
                                ProductsModel product =
                                    productController.productList[index];
                                return FutureBuilder(
                                    future: productController.addedWishlistProduct(product.id),
                                    builder: (context, AsyncSnapshot<dynamic> snapshot) {
                                      dynamic isInFavourites = snapshot.data;
                                    return GestureDetector(
                                      onTap: () {
                                        Get.to(() => ProductDetailScreen(
                                            id: product.id.toString()));
                                      },
                                      child: ProductWidget(
                                        image: product.images!.first.src,
                                        title: product.name,
                                        regularPrize: "\$${product.regularPrice}",
                                        prize: "\$${product.price}",
                                        saleCode: product.sku,
                                        isSale: product.onSale,
                                        // isSale: product.prices!.regularPrice != product.prices!.price ? false : true,
                                        isLike: isInFavourites,
                                        favFun: () {
                                          if (isInFavourites == true) {
                                            productController.toggleWishList(
                                                wishlistAction: WishlistAction.remove,
                                                product: product);
                                          } else {
                                            productController.toggleWishList(
                                                wishlistAction: WishlistAction.add,
                                                product: product);
                                          }
                                          productController.productList.refresh();
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
                                  }
                                );
                              },
                            )
                          : Center(
                              child: Text(
                                "Product Not Found",
                                style: pSemiBold18.copyWith(
                                    color: AppColor.cGreyFont),
                              ),
                            ),
                    ],
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
