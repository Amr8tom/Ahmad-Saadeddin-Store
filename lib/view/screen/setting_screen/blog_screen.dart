// ignore_for_file: prefer_const_constructors, must_be_immutable, sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gostore_app/utils/colors.dart';
import 'package:gostore_app/utils/helper.dart';
import 'package:gostore_app/utils/text_style.dart';
import 'package:gostore_app/view/widget/common_appbar_widget.dart';
import 'package:gostore_app/view/widget/common_space_divider_widget.dart';
import 'package:gostore_app/view/screen/home_screen/home_screen_widget.dart';
import 'package:gostore_app/view/screen/onboarding_screen/onboarding_screen.dart';
import 'package:gostore_app/core/controller/setting_controller/blog_controller.dart';
import 'package:gostore_app/view/widget/loading_widget.dart';

import 'article_screen.dart';

class BlogScreen extends StatefulWidget {
  BlogScreen({Key? key}) : super(key: key);

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  BlogController blogController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      blogController.getArticleData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.cBackGround,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: 280,
              decoration: BoxDecoration(
                color: AppColor.blueThemeColor,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(10),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 24, right: 24, top: 24),
              child: Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildAppBar('Blog'.tr, titleColor: AppColor.cBtnTxt),
                    verticalSpace(17),
                    blogController.blogPostList.isEmpty
                        ? Container(
                            height: Get.height / 1.5,
                            child: Center(
                              child: Text(
                                "Data not found",
                                style: pSemiBold21.copyWith(color: AppColor.cGreyFont),
                              ),
                            ),
                          )
                        : Expanded(
                            child: ListView(
                              shrinkWrap: true,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Featured Article'.tr,
                                  style: pBold16.copyWith(color: AppColor.cBtnTxt),
                                ),
                                verticalSpace(10),
                                SizedBox(
                                  height: Get.height * 0.45,
                                  width: Get.width,
                                  // aspectRatio: 0.86,
                                  child: PageView(
                                    scrollDirection: Axis.horizontal,
                                    onPageChanged: (page) {
                                      blogController.blogPostIndex.value = page;
                                    },
                                    physics: BouncingScrollPhysics(),
                                    children: blogController.blogPostList.map((data) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return GestureDetector(
                                            onTap: () {
                                              Get.to(() => ArticleScreen(
                                                    id: data.id.toString(),
                                                  ));
                                            },
                                            child: blogPostWidget(
                                                image: data.featuredImageUrl,
                                                title: data.title!.rendered,
                                                subtitle: parseHtmlString(data.content!.rendered),
                                                date: dateFormatted(
                                                    date: data.date!, formatType: formatForDateTime(FormatType.date))),
                                          );
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 18),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: buildPageIndicator(
                                        blogController.blogPostList.length, blogController.blogPostIndex.value),
                                  ),
                                ),
                                Text(
                                  "Best Articles".tr,
                                  style: pBold14,
                                ),
                                verticalSpace(15),
                                GridView.builder(
                                  itemCount: blogController.articleList.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.46,
                                      mainAxisSpacing: 15,
                                      crossAxisSpacing: 10,
                                      mainAxisExtent: 360),
                                  itemBuilder: (context, index) {
                                    var data = blogController.articleList[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Get.to(() => ArticleScreen(
                                              id: data.id.toString(),
                                            ));
                                      },
                                      child: buildArticleWidget(
                                        image: data.featuredImageUrl,
                                        title: data.title!.rendered,
                                        discreption: parseHtmlString(data.content!.rendered),
                                        date: dateFormatted(
                                          date: data.date!,
                                          formatType: formatForDateTime(FormatType.date),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildArticleWidget({String? image, String? title, String? discreption, String? date}) {
  assert(discreption != null);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
          height: 218.2,
          width: 155.710,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            // image: DecorationImage(image: NetworkImage(image!), fit: BoxFit.fill),
          ),
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 16),
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
          )
          // child: Align(
          //   alignment: Alignment.topLeft,
          //   child: buildProductWidget(),
          // ),
          ),
      verticalSpace(10),
      Text(
        title!,
        style: pBold14,
      ),
      verticalSpace(10),
      Text(
        discreption!,
        style: pMedium10.copyWith(color: AppColor.cGreyFont),
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
      ),
      verticalSpace(10),
      Text(
        date!,
        style: pSemiBold10.copyWith(
          color: AppColor.cGreyFont,
        ),
      ),
    ],
  );
}

Container buildProductWidget() {
  return Container(
    height: 15,
    width: 70,
    decoration: BoxDecoration(
      color: AppColor.cFav,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Center(
      child: Text(
        "Products".tr,
        style: pBold14.copyWith(
          color: AppColor.cBtnTxt,
          fontSize: 10,
        ),
      ),
    ),
  );
}
