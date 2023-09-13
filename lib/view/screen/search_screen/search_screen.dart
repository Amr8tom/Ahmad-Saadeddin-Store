import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gostore_app/core/controller/home_controller/home_controller.dart';
import 'package:gostore_app/core/model/categories_model.dart';
import 'package:gostore_app/utils/colors.dart';
import 'package:gostore_app/utils/images.dart';
import 'package:gostore_app/utils/text_style.dart';
import 'package:gostore_app/view/screen/category_screen/product_screen.dart';
import 'package:gostore_app/view/screen/dashboard_manager/dashboard_manager.dart';
import 'package:gostore_app/view/widget/common_appbar_widget.dart';
import 'package:gostore_app/view/widget/common_space_divider_widget.dart';
import 'package:gostore_app/view/widget/loading_widget.dart';
import 'package:image_gradient/image_gradient.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              children: [
                // commonMenuIconWidget(
                //   icon: DefaultImages.backIcn,
                //   bColor: AppColor.cLightBlue,
                //   color: AppColor.cLightBlue,
                // ),
                // horizontalSpace(15),
                Text(
                  "Categories".tr,
                  style: pBold24.copyWith(fontSize: 20),
                )
              ],
            ),
            verticalSpace(15),
            Expanded(
              child: ListView.builder(
                  itemCount: homeController.categoriesList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    CategoriesModel data = homeController.categoriesList[index];
                    return buildSearchWidget(
                      image: data.image == null
                          ? 'https://192.168.29.125/flutter-app/wp-content/uploads/2023/06/149169-hat-beach-png-image-high-quality.png'
                          : data.image!.src,
                      total: data.count.toString(),
                      category: data.name,
                      onTap: () {
                        Get.to(() => ProductScreen(
                              id: data.id.toString(),
                            ));
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSearchWidget(
      {String? image, String? total, String? category, Function()? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            Container(
              height: 126,
              width: Get.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [
                      AppColor.blueThemeColor.withOpacity(1),
                      AppColor.cGrey,
                      AppColor.cGrey,
                    ],
                  )),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ImageGradient.linear(
                  image: Image.network(
                    image!,
                    // fit: BoxFit.fill,
                    height: 126,
                    width: Get.width,
                  ),
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    AppColor.blueThemeColor.withOpacity(1),
                    AppColor.cGrey,
                    AppColor.cGrey,
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 126,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 18,
                      width: 48,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColor.cWhite)),
                      child: Center(
                        child: Text(
                          total!,
                          style: pBold14.copyWith(
                              color: AppColor.cBtnTxt, fontSize: 10),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            category!,
                            style: pBold30.copyWith(
                                color: AppColor.cBtnTxt, fontSize: 36),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        commonMenuIconWidget(
                          icon: DefaultImages.arrowRightIcn,
                          color: AppColor.cLightBlue,
                          bColor: AppColor.cLightBlue,
                          colorFilter: ColorFilter.mode(
                            AppColor.cFont,
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
