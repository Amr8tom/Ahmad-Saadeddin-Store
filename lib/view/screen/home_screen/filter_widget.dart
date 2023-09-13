// ignore_for_file: prefer_const_constructors, must_be_immutable, avoid_print, prefer_const_constructors_in_immutables

import 'dart:developer';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gostore_app/core/controller/home_controller/search_controller.dart';
import 'package:gostore_app/core/model/categories_model.dart';
import 'package:gostore_app/core/model/product_model.dart';
import 'package:gostore_app/utils/colors.dart';
import 'package:gostore_app/utils/helper.dart';
import 'package:gostore_app/utils/images.dart';
import 'package:gostore_app/utils/text_style.dart';
import 'package:gostore_app/view/widget/loading_widget.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:gostore_app/view/widget/common_button.dart';
import 'package:gostore_app/view/widget/icon_and_image.dart';
import 'package:gostore_app/view/widget/common_space_divider_widget.dart';
import 'package:gostore_app/core/controller/home_controller/filter_controller.dart';

class FilterBottomSheet extends StatefulWidget {
  FilterBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  FilterController filterController = Get.put(FilterController());
  SearchProductController searchProductController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getData();
    });
  }

  getData() async {
    filterController.getAllCategory();
    filterController.getTagData();
    filterController.getAllAttributes();
    filterController.getColor('1');
    filterController.getSize('2');
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 57),
          child: Container(
            decoration: BoxDecoration(
              color: AppColor.cBackGround,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
          ),
        ),
        Obx(() {
          return Column(
            children: [
              Center(
                child: CommonIconBorderButton(
                    width: 120,
                    radius: 20,
                    iconData: DefaultImages.cancelIcn,
                    btnColor: AppColor.cDarkGrey,
                    title: 'Cancel'.tr,
                    onPressed: () {
                      Get.back();
                    }),
              ),
              verticalSpace(15),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: Get.height * 0.05,
                    right: 22,
                    left: 22,
                  ),
                  child: filterController.isDataAvailable.value
                      ? LoadingWidget()
                      : ListView(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Filters".tr,
                              style: pBold24.copyWith(fontSize: 20),
                            ),
                            verticalSpace(10),
                            Text(
                              "Categories".tr,
                              style: pBold12,
                            ),
                            verticalSpace(15),
                            ListView.builder(
                              itemCount: filterController.categoriesList.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                CategoriesModel data =
                                    filterController.categoriesList[index];
                                return Column(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        for (int i = 0;
                                            i <
                                                filterController
                                                    .categoriesList.length;
                                            i++) {
                                          if (index == i) {
                                            data.isExpand = true;
                                            filterController.getSubCategory(
                                                data.id.toString());
                                          } else {
                                            filterController.categoriesList[i]
                                                .isExpand = false;
                                          }
                                          filterController.categoriesList
                                              .refresh();
                                        }
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            data.name!,
                                            style: pBold14.copyWith(
                                                color: data.isExpand == true
                                                    ? AppColor.cText
                                                    : AppColor.cFont),
                                          ),
                                          SizedBox(
                                            height: 30,
                                            width: 30,
                                            child: assetSvdImageWidget(
                                                image: data.isExpand == true
                                                    ? DefaultImages.minusIcn
                                                    : DefaultImages.plusIcn),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Obx(() {
                                      print(
                                          "${filterController.subCategoriesList.length}");
                                      return data.isExpand == true
                                          ? filterController
                                                  .isCategoryAvailable.value
                                              ? SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child: LoadingWidget())
                                              : ListView(
                                                  shrinkWrap: true,
                                                  children: filterController
                                                      .subCategoriesList
                                                      .map((subCategory) {
                                                    // print("subCategory==>$subCategory");
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 10,
                                                              left: 24),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          filterController
                                                                  .categoriesId
                                                                  .value =
                                                              subCategory.id
                                                                  .toString();
                                                          print(
                                                              "categories==>${filterController.categoriesId.value}");
                                                        },
                                                        child: Text(
                                                          subCategory.name!,
                                                          style: pMedium12,
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                )
                                          : SizedBox();
                                    })
                                  ],
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: horizontalDivider(
                                  color: AppColor.cGreyDivider),
                            ),
                            Text(
                              "Tags".tr,
                              style: pBold12,
                            ),
                            verticalSpace(10),
                            Wrap(
                              spacing: 8,
                              direction: Axis.horizontal,
                              children: tagChips(),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: horizontalDivider(
                                  color: AppColor.cGreyDivider),
                            ),
                            Text(
                              "Price Range".tr,
                              style: pBold12,
                            ),
                            verticalSpace(10),
                            SfRangeSlider(
                              min: 0,
                              max: 450.0,
                              values: filterController.currentRangeValues.value,
                              interval: 20,
                              showTicks: false,
                              showLabels: false,
                              enableTooltip: true,
                              activeColor: AppColor.blueThemeColor,
                              inactiveColor: AppColor.cGrey,
                              showDividers: false,
                              endThumbIcon: assetSvdImageWidget(
                                image: DefaultImages.dotIcn,
                              ),
                              startThumbIcon: assetSvdImageWidget(
                                  image: DefaultImages.dotIcn),
                              minorTicksPerInterval: 1,
                              onChanged: (SfRangeValues values) {
                                filterController.currentRangeValues.value =
                                    values;
                                print(
                                    "111==>${filterController.currentRangeValues.value.start}");
                                print(
                                    "222==>${filterController.currentRangeValues.value.end}");
                              },
                              onChangeStart: (SfRangeValues values) {
                                filterController.currentRangeValues.value =
                                    values;
                                print(
                                    "000==>${filterController.currentRangeValues.value.start}");
                              },
                              onChangeEnd: (SfRangeValues values) {
                                filterController.currentRangeValues.value =
                                    values;
                                print(
                                    "333==>${filterController.currentRangeValues.value.end}");
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: horizontalDivider(
                                  color: AppColor.cGreyDivider),
                            ),
                            Text(
                              "Colors".tr,
                              style: pBold12,
                            ),
                            verticalSpace(10),
                            Wrap(
                              direction: Axis.horizontal,
                              children: colorChips(),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: horizontalDivider(
                                  color: AppColor.cGreyDivider),
                            ),
                            Text(
                              "Size".tr,
                              style: pBold12,
                            ),
                            verticalSpace(10),
                            Wrap(
                              direction: Axis.horizontal,
                              children: sizeChips(),
                            ),
                            verticalSpace(20),
                            CommonButton(
                              title: 'Show Results'.tr,
                              onPressed: () {
                                Loader.showLoader();
                                filterController
                                    .getFilterProduct(
                                        categoryId: filterController
                                            .categoriesId.value
                                            .toString(),
                                        minPrice: filterController
                                            .currentRangeValues.value.start
                                            .toString(),
                                        maxPrice: filterController
                                            .currentRangeValues.value.end
                                            .toString(),
                                        tagID: filterController.tagsTd.value
                                            .toString(),
                                        attribute:
                                            filterController.attribute.value,
                                        attributeTerm: filterController
                                            .attributeTerm.value
                                            .toString())
                                    .then((response) {
                                  // Get.back();
                                  searchProductController.searchProductList
                                      .clear();
                                  for (int i = 0; i < response.length; i++) {
                                    searchProductController.searchProductList
                                        .add(ProductsModel.fromJson(
                                            response[i]));
                                  }
                                  Loader.hideLoader();
                                  log('value------------------> ${response.length}');
                                  log('value------------------> ${searchProductController.searchProductList.length}');
                                });
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: GestureDetector(
                                onTap: () {
                                  filterController.tagsTd.value = '';
                                  filterController.attributeTerm.value = '';
                                  filterController.attribute.value = '';
                                  filterController.categoriesId.value ='';
                                  Get.back();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    assetSvdImageWidget(
                                      image: DefaultImages.clearIcn,
                                      colorFilter: ColorFilter.mode(
                                          AppColor.blueThemeColor,
                                          BlendMode.srcIn),
                                    ),
                                    horizontalSpace(10),
                                    Text(
                                      "Clear Filters".tr,
                                      style: pMedium14.copyWith(
                                          color: AppColor.cText),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ],
          );
        }),
      ],
    );
  }

  List<Widget> tagChips() {
    List<Widget> chips = [];
    for (int i = 0; i < filterController.tagList.length; i++) {
      print("tagsN==>${filterController.tagList[i].name}");

      Widget item = Padding(
        padding: const EdgeInsets.only(right: 5),
        child: FilterChip(
          label: Text("${filterController.tagList[i].name}"),
          labelStyle: pBold12.copyWith(fontSize: 10, color: AppColor.cGreyFont),
          labelPadding: EdgeInsets.symmetric(horizontal: 12),
          backgroundColor: AppColor.cBackGround,
          selectedColor: AppColor.cBackGround,
          selected: filterController.tagList[i].isSelected ?? false,
          onSelected: (bool value) {
            for (int j = 0; j < filterController.tagList.length; j++) {
              if (i == j) {
                filterController.tagList[i].isSelected = value;
                filterController.tagsTd.value =
                    filterController.tagList[i].id.toString();
                print("tags==>${filterController.tagsTd.value}");
              } else {
                filterController.tagList[j].isSelected = false;
              }
            }
            filterController.tagList.refresh();
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: filterController.tagList[i].isSelected == true
                  ? AppColor.blueThemeColor
                  : AppColor.cBorder,
            ),
          ),
          showCheckmark: false,
        ),
      );
      chips.add(item);
    }
    return chips;
  }

  List<Widget> colorChips() {
    List<Widget> chips = [];
    for (int i = 0; i < filterController.colorList.length; i++) {
      var color =filterController.colorList[i].colorCode;
      var coralColor = HexColor(color!);
      Widget item = FilterChip(
        label: Container(
          height: 42,
          width: 42,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            border: Border.all(
              color: filterController.colorList[i].isSelected == true
                  ? AppColor.blueThemeColor
                  : AppColor.cTransparent,
            ),
          ),
          child: Center(
            child: Container(
              height: 34,
              width: 34,
              decoration: BoxDecoration(
                color: coralColor,
                borderRadius: BorderRadius.circular(9),
              ),
              child: Icon(Icons.done,
                  color: filterController.colorList[i].isSelected==true
                      ? AppColor.cWhiteFont
                      : AppColor.cTransparent),
            ),
          ),
        ),
        padding: EdgeInsets.zero,
        labelPadding: EdgeInsets.zero,
        backgroundColor: AppColor.cBackGround,
        selectedColor: AppColor.cBackGround,
        selected: filterController.colorList[i].isSelected ?? false,
        onSelected: (bool value) {
          for (int j = 0; j < filterController.colorList.length; j++) {
            if (i == j) {
              filterController.colorList[i].isSelected = value;
              filterController.attribute.value =
                  filterController.allAttributesList[0].slug!;
              filterController.attributeTerm.value =
                  filterController.colorList[i].id.toString();
              print("colors==>>${filterController.attributeTerm.value}");
              print("colors==>>${filterController.attribute.value}");
            } else {
              filterController.colorList[j].isSelected = false;
            }
          }
          filterController.colorList.refresh();
        },
        showCheckmark: false,
      );
      chips.add(item);
    }
    return chips;
  }

  List<Widget> sizeChips() {
    List<Widget> chips = [];
    for (int i = 0; i < filterController.sizeList.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: FilterChip(
          label: Text(
            filterController.sizeList[i].name!,
            style: pBold12.copyWith(
                fontSize: 10,
                color: filterController.sizeList[i].isSelected == true
                    ? AppColor.cFont
                    : AppColor.cGreyFont),
          ),
          backgroundColor: AppColor.cBackGround,
          selectedColor: AppColor.cBackGround,
          selected: filterController.sizeList[i].isSelected ?? false,
          onSelected: (bool value) {
            for (int j = 0; j < filterController.sizeList.length; j++) {
              if (i == j) {
                filterController.sizeList[i].isSelected = value;
                filterController.attribute.value =
                    filterController.allAttributesList[1].slug!;
                filterController.attributeTerm.value =
                    filterController.sizeList[i].id.toString();
                print("sizeList==>>${filterController.attributeTerm.value}");
                print("sizeList==>>${filterController.attribute.value}");
              } else {
                filterController.sizeList[j].isSelected = false;
              }
              filterController.sizeList.refresh();
            }
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: filterController.sizeList[i].isSelected == true
                  ? AppColor.blueThemeColor
                  : AppColor.cBorder,
            ),
          ),
          showCheckmark: false,
        ),
      );
      chips.add(item);
    }
    return chips;
  }
}
