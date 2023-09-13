// ignore_for_file: must_be_immutable, prefer_const_constructors, avoid_print

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gostore_app/core/controller/cart_controller/cart_controller.dart';
import 'package:gostore_app/core/controller/home_controller/product_controller.dart';
import 'package:gostore_app/core/model/product_model.dart';
import 'package:gostore_app/utils/colors.dart';
import 'package:gostore_app/utils/text_style.dart';
import 'package:gostore_app/view/screen/category_screen/product_detail_screen.dart';
import 'package:gostore_app/view/screen/category_screen/variable_product_screen.dart';
import 'package:gostore_app/view/screen/home_screen/home_screen_widget.dart';
import 'package:gostore_app/view/widget/common_space_divider_widget.dart';
import 'package:gostore_app/view/widget/common_appbar_widget.dart';
import 'package:gostore_app/view/widget/loading_widget.dart';

class ProductScreen extends StatefulWidget {
  final String? id;

  const ProductScreen({Key? key, this.id}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  ProductController productController = Get.put(ProductController());
  CartController cartController = Get.find();

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productController.pageNumber.value = 2;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getAllData();
    });
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
        productController.getProduct(id: widget.id, page: productController.pageNumber.value);
        productController.pageNumber.value += 1;
        print(" pageNumber................>> ${productController.pageNumber.value}");
      }
    });
  }

  getAllData() {
    productController.getAllProduct(
      widget.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.cBackGround,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              buildAppBar("Product".tr),
              verticalSpace(20),
              Expanded(
                child: Obx(() {
                  return ListView(
                    controller: scrollController,
                    shrinkWrap: true,
                    children: [
                      productController.productList.isNotEmpty
                          ? GridView.builder(
                              itemCount: productController.productList.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  // childAspectRatio: 0.55,
                                  childAspectRatio: Get.height * 0.0007,
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 15),
                              itemBuilder: (context, index) {
                                ProductsModel product = productController.productList[index];
                                return product.id == null
                                    ? SizedBox()
                                    : FutureBuilder(
                                        future: productController.addedWishlistProduct(product.id),
                                        builder: (context, AsyncSnapshot<dynamic> snapshot) {
                                          dynamic isInFavourites = snapshot.data;
                                          return GestureDetector(
                                            onTap: () {
                                              Get.to(() => ProductDetailScreen(id: product.id.toString()))!
                                                  .then((value) {
                                                productController.productList.refresh();
                                                return productController.addedWishlistProduct(product.id);
                                              });
                                            },
                                            child: ProductWidget(
                                              image: product.images!.first.src,
                                              title: product.name,
                                              regularPrize: "\$${product.regularPrice}",
                                              prize: "\$${product.price}",
                                              saleCode: product.sku,
                                              // isSale: product.prices!.regularPrice != product.prices!.price ? false : true,
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
                                        });
                              },
                            )
                          : productController.isEmptyProductList.value==true
                              ? SizedBox(
                                  height: Get.height - 250,
                                  width: Get.width,
                                  child: Center(
                                    child: Text(
                                      "Product Not Found",
                                      style: pSemiBold18.copyWith(color: AppColor.cGreyFont),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                              : SizedBox(),
                      productController.isDataAvailable.value == true
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: LoadingWidget(),
                            )
                          : SizedBox(
                              width: 0,
                              height: 0,
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
