// ignore_for_file: prefer_const_constructors, must_be_immutable, avoid_print, prefer_const_constructors_in_immutables

import 'dart:developer';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gostore_app/core/controller/cart_controller/cart_controller.dart';
import 'package:gostore_app/core/controller/home_controller/product_controller.dart';
import 'package:gostore_app/core/model/product_model.dart';
import 'package:gostore_app/utils/base_api.dart';
import 'package:gostore_app/utils/colors.dart';
import 'package:gostore_app/utils/images.dart';
import 'package:gostore_app/utils/text_style.dart';
import 'package:gostore_app/view/screen/category_screen/product_detail_screen.dart';
import 'package:gostore_app/view/screen/category_screen/variable_product_screen.dart';
import 'package:gostore_app/view/screen/home_screen/home_screen_widget.dart';
import 'package:gostore_app/view/screen/home_screen/search_product_screen.dart';
import 'package:gostore_app/view/widget/icon_and_image.dart';
import 'package:gostore_app/view/widget/common_appbar_widget.dart';
import 'package:gostore_app/view/widget/common_space_divider_widget.dart';
import 'package:gostore_app/core/controller/category_controller/category_controller.dart';
import 'package:gostore_app/view/widget/loading_widget.dart';

class CategoryScreen extends StatefulWidget {
  final bool isBack;

  CategoryScreen({Key? key, required this.isBack}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  CategoryController categoryController = Get.put(CategoryController());
  ProductController productController = Get.put(ProductController());

  CartController cartController = Get.put(CartController());
  ScrollController scrollController = ScrollController();
  String menId = '33';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getAllData();
      scrollController.addListener(() {
        if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
          productController.getProduct(id: menId, page: productController.pageNumber.value);
          productController.pageNumber.value += 1;
          print(" pageNumber................>> ${productController.pageNumber.value}");
        }
      });
    });
  }

  getAllData() {
    productController.getAllProduct(menId);
    categoryController.getSubCategory(menId);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 175,
            decoration: BoxDecoration(
              color: AppColor.blueThemeColor,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
            ),
            child: Column(
              children: [
                _buildAppBar(),
                Padding(
                  padding: EdgeInsets.only(
                    left: 24,
                  ),
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: categoryChips(),
                      )),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: buildFindProductTextWidget(
                "${productController.productList.length}"),
          ),
          // verticalSpaceSpace(Get.height * 0.025),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ListView(
                controller: scrollController,
                children: [
                  categoryController.isDataAvailable.value
                      ? SizedBox(height: Get.height / 2, child: LoadingWidget())
                      : productController.productList.isNotEmpty
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
                                              Get.to(() => ProductDetailScreen(id: product.id.toString()));
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
                                                productController.productList.refresh();
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
                            )
                          : SizedBox(
                              height: Get.height / 2,
                              width: Get.width,
                              child: Center(
                                child: Text(
                                  "Product Not Found",
                                  style: pSemiBold18.copyWith(color: AppColor.cGreyFont),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
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
              ),
            ),
          )
        ],
      );
    });
  }

  List<Widget> categoryChips() {
    List<Widget> chips = [];
    for (int i = 0; i < categoryController.subCategoriesList.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.only(right: 6),
        child: FilterChip(
          label: Text("${categoryController.subCategoriesList[i].name}"),
          labelStyle: pBold12.copyWith(
              fontSize: 10,
              color:
                  categoryController.subCategoriesList[i].isExpand == true ? AppColor.cBtnTxt : AppColor.cBlueBorder),
          labelPadding: EdgeInsets.symmetric(horizontal: 12),
          backgroundColor: AppColor.blueThemeColor,
          selectedColor: AppColor.blueThemeColor,
          selected: categoryController.subCategoriesList[i].isExpand ?? false,
          onSelected: (bool value) {
            // categoryController.subCategoriesList[i].isExpand = value;
            for (int j = 0; j < categoryController.subCategoriesList.length; j++) {
              if (i == j) {
                categoryController.subCategoriesList[i].isExpand = value;
                productController.getAllProduct(categoryController.subCategoriesList[i].id.toString());
              } else {
                categoryController.subCategoriesList[j].isExpand = false;
              }
            }
            categoryController.subCategoriesList.refresh();
          },
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: categoryController.subCategoriesList[i].isExpand == true ? AppColor.cWhite : AppColor.cBlueBorder,
            ),
          ),
          showCheckmark: false,
        ),
      );
      chips.add(item);
    }
    return chips;
  }

  Widget _buildAppBar() {
    final config = CalendarDatePicker2WithActionButtonsConfig(
      dayTextStyle: pMedium14,
      calendarType: CalendarDatePicker2Type.range,
      selectedDayHighlightColor: AppColor.blueThemeColor,
      closeDialogOnCancelTapped: true,
      firstDayOfWeek: 1,
      weekdayLabelTextStyle: pSemiBold12,
      controlsTextStyle: pSemiBold14,
      centerAlignModePicker: true,
      customModePickerIcon: const SizedBox(),
      selectedDayTextStyle: pMedium14.copyWith(color: Colors.white),
      dayTextStylePredicate: ({required date}) {
        TextStyle? textStyle;
        if (date.weekday == DateTime.saturday || date.weekday == DateTime.sunday) {
          textStyle = pMedium14;
        }
        if (DateUtils.isSameDay(date, DateTime(2021, 1, 25))) {
          textStyle = pMedium14;
        }
        return textStyle;
      },
    );
    return Padding(
      padding: EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              widget.isBack == true
                  ? commonMenuIconWidget(
                      icon: DefaultImages.backIcn,
                      onTap: () {
                        Get.back();
                      },
                      bColor: AppColor.cMenuBlue,
                      color: AppColor.cMenuBlue,
                      colorFilter: ColorFilter.mode(AppColor.cWhiteFont, BlendMode.srcIn))
                  : SizedBox(),
              horizontalSpace(widget.isBack == true ? 15 : 0),
              Text(
                "Men",
                style: pBold24.copyWith(fontSize: 20, color: AppColor.cBtnTxt),
              ),
            ],
          ),
          PopupMenuButton(
            itemBuilder: (ctx) => List.generate(categoryController.popupList.length, (index) {
              var data = categoryController.popupList[index];
              return _buildPopupMenuItem(
                  data['title'], data['icon'], index, categoryController.popupMenuItemIndex.value == index);
            }),
            onSelected: (value) async {
              print("-=-=-=-=-=-=$value");
              Loader.showLoader();
              categoryController.popupMenuItemIndex.value = value;
              if (categoryController.popupMenuItemIndex.value == 0) {
                List<DateTime?>? values = await showCalendarDatePicker2Dialog(
                  context: context,
                  config: config,
                  dialogSize: const Size(325, 450),
                  borderRadius: BorderRadius.circular(15),
                  value: categoryController.dialogCalendarPickerValue,
                  dialogBackgroundColor: AppColor.cBackGround,
                );
                if (values != null) {
                  print('object==> $values');
                  categoryController.dialogCalendarPickerValue = values;
                  String url =
                      "${API.afterUrl}${categoryController.dialogCalendarPickerValue[0]}${API.beforeUrl}${categoryController.dialogCalendarPickerValue[1]}";
                  categoryController.getDateFilter(url).then((response) {
                    productController.productList.clear();
                    for (int i = 0; i < response.length; i++) {
                      log("id--------==> ${response[i]["id"]}");
                      productController.productList.add(ProductsModel.fromJson(response[i]));
                    }
                    productController.productList.refresh();
                  });
                }
              } else if (categoryController.popupMenuItemIndex.value == 1) {
                String url = "${API.featuredUrl}1";
                categoryController.getDateFilter(url).then((response) {
                  productController.productList.clear();
                  for (int i = 0; i < response.length; i++) {
                    log("id--------==> ${response[i]["id"]}");
                    productController.productList.add(ProductsModel.fromJson(response[i]));
                  }
                  productController.productList.refresh();
                });
              } else {
                String url = "${API.onSaleUrl}1";
                categoryController.getDateFilter(url).then((response) {
                  productController.productList.clear();
                  for (int i = 0; i < response.length; i++) {
                    log("id--------==> ${response[i]["id"]}");
                    productController.productList.add(ProductsModel.fromJson(response[i]));
                  }
                  productController.productList.refresh();
                });
              }
              Get.back();
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), side: BorderSide(color: AppColor.cBorder)),
            padding: EdgeInsets.all(21),
            initialValue: categoryController.popupMenuItemIndex.value,
            child: commonMenuIconWidget(
                icon: DefaultImages.popupMenuIcn,
                bColor: AppColor.cWhite,
                colorFilter: ColorFilter.mode(AppColor.cBtnTxt, BlendMode.srcIn)),
          )
        ],
      ),
    );
  }
}

PopupMenuItem _buildPopupMenuItem(String title, String iconData, int position, bool isSelected) {
  return PopupMenuItem(
    value: position,
    child: Row(
      children: [
        assetSvdImageWidget(
            image: iconData,
            colorFilter: ColorFilter.mode(isSelected ? AppColor.cText : AppColor.cGreyFont, BlendMode.srcIn),
            width: 13,
            height: 13),
        horizontalSpace(11),
        Text(title, style: pMedium12.copyWith(color: isSelected ? AppColor.cText : AppColor.cGreyFont)),
      ],
    ),
  );
}
