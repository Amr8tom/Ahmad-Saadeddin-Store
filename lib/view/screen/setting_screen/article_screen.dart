// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, prefer_const_constructors_in_immutables

import 'package:gostore_app/utils/helper.dart';
import 'package:gostore_app/view/widget/loading_widget.dart';

import 'blog_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gostore_app/utils/colors.dart';
import 'package:gostore_app/utils/images.dart';
import 'package:gostore_app/utils/text_style.dart';
import 'package:image_gradient/image_gradient.dart';
import 'package:gostore_app/view/widget/common_appbar_widget.dart';
import 'package:gostore_app/view/widget/common_space_divider_widget.dart';
import 'package:gostore_app/core/controller/setting_controller/blog_controller.dart';

class ArticleScreen extends StatefulWidget {
  final String id;

  ArticleScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  BlogController blogController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      blogController.getPostDetailData(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.cBackGround,
      body: SafeArea(
        child: Obx(() {
          print(blogController.articleList.length);
          return blogController.isDataAvailable.value || blogController.blogModel==null
              ? LoadingWidget()
              : Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(
                          10,
                        ),
                      ),
                      child: Stack(
                        children: [
                          ImageGradient(
                            image: Image.network(
                            blogController.blogModel!.featuredImageUrl.toString(),
                              fit: BoxFit.fill,
                              height: 270,
                              width: Get.width,
                            ),
                            gradient: LinearGradient(
                                colors: [
                                  AppColor.blueThemeColor,
                                  AppColor.cWhite
                                ],
                                stops: [
                                  0.5,
                                  1.0
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight),
                          ),
                          Container(
                            height: 270,
                            width: Get.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(
                                  10,
                                ),
                              ),
                              color: AppColor.blueThemeColor,
                              gradient: LinearGradient(
                                colors: [
                                  AppColor.blueThemeColor,
                                  AppColor.blueThemeColor.withOpacity(0.00),
                                  AppColor.cTransparent,
                                ],
                                stops: [0.2, 0.4, 0.8],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                              ),
                            ),
                            padding: EdgeInsets.all(24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildAppBar(''),
                                verticalSpace(35),
                                buildProductWidget(),
                                verticalSpace(10),
                                Text(
                                  blogController.blogModel!.title!.rendered ??
                                      "Best top trends products in 2023 year for influence's",
                                  style: pBold24.copyWith(
                                      color: AppColor.cBtnTxt, fontSize: 19.14),
                                ),
                                verticalSpace(10),
                                Text(
                                  dateFormatted(
                                      date: blogController.blogModel!.date!,
                                      formatType:
                                          formatForDateTime(FormatType.date)),
                                  style: pSemiBold10.copyWith(
                                    color: AppColor.cLabel,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: ListView(
                          children: [
                            Text(
                              blogController.blogModel!.title!.rendered ??
                                  "Best top trends products in 2023 year for influencers",
                              style: pBold24.copyWith(fontSize: 20),
                            ),
                            verticalSpace(20),
                            Text(
                              parseHtmlString(
                                  blogController.blogModel!.content!.rendered),
                              style: pMedium12,
                            ),
                            verticalSpace(15),
                            Text(
                              "Gathering information's".tr,
                              style: pBold14,
                            ),
                            verticalSpace(15),
                            Text(
                              parseHtmlString(
                                  blogController.blogModel!.excerpt!.rendered),
                              style: pMedium12,
                            ),
                            // RichText(
                            //   text: TextSpan(
                            //     text: 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'.tr,
                            //     style: pMedium12,
                            //     children: [
                            //       TextSpan(
                            //         text: 'The point of using Lorem Ipsum is that it has ',
                            //         style: pMedium12.copyWith(
                            //           color: AppColor.cText,
                            //           decoration: TextDecoration.underline,
                            //         ),
                            //         ),
                            //       TextSpan(
                            //         text: 'a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for lorem ipsum will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).',
                            //         style: pMedium12,
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            verticalSpace(15),
                            Text(
                              "Best Articles".tr,
                              style: pBold14,
                            ),
                            verticalSpace(15),
                            GridView.builder(
                              itemCount: blogController.articleList.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.46,
                                mainAxisSpacing: 15,
                                crossAxisSpacing: 10,
                                mainAxisExtent: 360,
                              ),
                              itemBuilder: (context, index) {
                                var data = blogController.articleList[index];
                                return buildArticleWidget(
                                  image:  data.featuredImageUrl,
                                  title: data.title!.rendered,
                                  discreption:
                                      parseHtmlString(data.content!.rendered),
                                  date: dateFormatted(
                                    date: data.date!,
                                    formatType:
                                        formatForDateTime(FormatType.date),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
        }),
      ),
    );
  }
}
