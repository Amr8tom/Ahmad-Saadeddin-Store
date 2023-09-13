// ignore_for_file: prefer_const_constructors, must_be_immutable, avoid_print, prefer_const_constructors_in_immutables, sized_box_for_whitespace

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gostore_app/core/controller/home_controller/product_controller.dart';
import 'package:gostore_app/core/controller/setting_controller/blog_controller.dart';
import 'package:gostore_app/core/model/categories_model.dart';
import 'package:gostore_app/core/model/product_model.dart';
import 'package:gostore_app/utils/colors.dart';
import 'package:gostore_app/utils/helper.dart';
import 'package:gostore_app/utils/images.dart';
import 'package:gostore_app/utils/text_style.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gostore_app/view/screen/category_screen/product_detail_screen.dart';
import 'package:gostore_app/core/controller/home_controller/home_controller.dart';
import 'package:gostore_app/view/screen/category_screen/product_screen.dart';
import 'package:gostore_app/view/screen/category_screen/variable_product_screen.dart';
import 'package:gostore_app/view/screen/home_screen/home_screen_widget.dart';
import 'package:gostore_app/view/widget/common_space_divider_widget.dart';
import 'package:gostore_app/view/screen/setting_screen/blog_screen.dart';
import 'package:gostore_app/view/widget/icon_and_image.dart';
import 'package:gostore_app/view/widget/loading_widget.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../onboarding_screen/onboarding_screen.dart';
import 'onsale_product.dart';
import 'search_product_screen.dart';
import 'package:gostore_app/core/controller/cart_controller/cart_controller.dart';

class HomeScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  HomeScreen({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.put(HomeController());
  CartController cartController = Get.put(CartController());
  BlogController blogController = Get.put(BlogController());
  ProductController productController = Get.put(ProductController());

  PageController? pageController;
  ScrollController? scrollController;
  List<QuiltedGridTile> pattern = [
    QuiltedGridTile(1, 2),
    QuiltedGridTile(1, 1),
    QuiltedGridTile(1, 1),
  ];
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey = GlobalKey<LiquidPullToRefreshState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
    scrollController = ScrollController();
    scrollController!.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getAllData();
    });
  }

  getAllData() {
    Loader.showLoader();

    homeController.getAllCategory();
    homeController.getBestSeller();
    homeController.getOnSaleProduct();
    homeController.getRateProduct();
    homeController.getNewCollection();
    blogController.getBlogData("3");
    Get.back();
  }

  void _scrollListener() {
    setState(() {
      var index = (scrollController!.offset / 9).round() + 1;
      if (index == 1) {
        homeController.newCollectionIndex.value = 0;
      } else if (index < 41) {
        homeController.newCollectionIndex.value = 1;
      } else if (index > 41) {
        homeController.newCollectionIndex.value = 2;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: LiquidPullToRefresh(
        key: _refreshIndicatorKey,
        onRefresh: () async {
          await getAllData();
        },
        showChildOpacityTransition: false,
        backgroundColor: AppColor.blueThemeColor,
        color: AppColor.cBackGround,
        springAnimationDurationInMilliseconds: 500,
        child: Column(
          children: [
            Container(
              color: AppColor.cNavyBlue,
              padding: const EdgeInsets.all(24),
              child: titleRowWidget(
                () {
                  widget.scaffoldKey.currentState!.openDrawer();
                },
                () {
                  Get.to(() => SearchProductScreen())!.then((value) =>  getAllData());
                },
                "أحمد سعد الدين",
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Stack(
                  children: [
                    homeBackgroundWidget(),
                    Obx(
                      () {
                        return Padding(
                          padding: const EdgeInsets.only(left: 24, right: 24, top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello!".tr,
                                style: pMedium16.copyWith(color: AppColor.cWhiteFont),
                              ),
                              verticalSpace(8),
                              SizedBox(
                                width: 245,
                                child: Text(
                                  "Find cool products fit your style".tr,
                                  style: pBold24.copyWith(color: AppColor.cWhiteFont),
                                ),
                              ),
                              verticalSpace(15),
                              searchWidget(homeController.searchController, readOnly: true, onTap: () {
                                Get.to(() => SearchProductScreen())!.then((value) =>  getAllData());
                              }),
                              verticalSpace(Get.height * 0.045),
                              SizedBox(
                                height: 80,
                                child: ListView.builder(
                                    itemCount: homeController.categoriesList.isEmpty
                                        ? 5
                                        : homeController.categoriesList.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    physics: BouncingScrollPhysics(),
                                    clipBehavior: Clip.hardEdge,
                                    itemBuilder: (context, index) {
                                      CategoriesModel? data = homeController.categoriesList.isEmpty
                                          ? null
                                          : homeController.categoriesList[index];
                                      return Obx(() {
                                        return categoryWidget(
                                          image: data == null
                                              ? null
                                              : data.image == null
                                                  ? 'https://192.168.29.125/flutter-app/wp-content/uploads/2023/06/149169-hat-beach-png-image-high-quality.png'
                                                  : data.image!.src,
                                          label: data == null ? '' : data.name,
                                          color: homeController.categoryIndex.value == index
                                              ? AppColor.cWhite
                                              : AppColor.cLightBlue,
                                          textColor: homeController.categoryIndex.value == index
                                              ? AppColor.cWhiteFont
                                              : AppColor.cCategoryLabel,
                                          onTap: () {
                                            homeController.categoryIndex.value = index;
                                            homeController.categoryIndex.refresh();
                                            Get.to(() => ProductScreen(
                                                  id: data!.id.toString(),
                                                ));
                                          },
                                        );
                                      });
                                    }),
                              ),
                              verticalSpace(Get.height * 0.035),
                              Container(
                                // height: 200,
                                width: Get.width,
                                decoration:
                                    BoxDecoration(color: AppColor.cTeal, borderRadius: BorderRadius.circular(9)),
                                padding: EdgeInsets.all(16),
                                child: CarouselSlider(
                                  options: CarouselOptions(
                                      // height: 200.0,
                                      viewportFraction: 0.9,
                                      initialPage: 0,
                                      enableInfiniteScroll: true,
                                      reverse: false,
                                      autoPlay: true,
                                      autoPlayInterval: Duration(seconds: 3),
                                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      enlargeCenterPage: true,
                                      enlargeFactor: 0.3,
                                      scrollDirection: Axis.horizontal,
                                      onPageChanged: (i, carouselPageChangedReason) {
                                        homeController.sellerIndex.value = i;
                                      }),
                                  items: homeController.sellerList.map((data) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return bestSellerWidget(
                                          image: data.image,
                                          onTap: () {
                                            Get.to(() => ProductScreen());
                                          },
                                          currantIndex: homeController.sellerIndex.value,
                                          list: homeController.sellerList,
                                          title: data.title!.tr,
                                          subTitle: parseHtmlString(data.description!.tr),
                                          isShowIndicator: true,
                                        );
                                      },
                                    );
                                  }).toList(),
                                ),
                              ),
                              verticalSpace(Get.height * 0.025),
                              seeAllRowWidget("On sale Today".tr, () {
                                Get.to(() => OnSaleProductListScreen(
                                      dataList: homeController.onSaleProductList,
                                      appTitle: 'On sale ',
                                    ));
                              }),
                              // verticalSpace(Get.height * 0.025),
                              GridView.builder(
                                itemCount: homeController.onSaleProductList.length > 4
                                    ? 4
                                    : homeController.onSaleProductList.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    // childAspectRatio: 0.55,
                                    childAspectRatio: Get.height * 0.0007,
                                    crossAxisSpacing: 15,
                                    mainAxisSpacing: 15),
                                itemBuilder: (context, index) {
                                  ProductsModel product = homeController.onSaleProductList[index];
                                  return FutureBuilder(
                                      future: productController.addedWishlistProduct(product.id),
                                      builder: (context, AsyncSnapshot<dynamic> snapshot) {
                                        dynamic isInFavourites = snapshot.data;
                                        return GestureDetector(
                                          onTap: () {
                                            Get.to(() => ProductDetailScreen(
                                                      id: product.id.toString(),
                                                    ))!
                                                .then((value) {
                                              productController.addedWishlistProduct(product.id);
                                              homeController.onSaleProductList.refresh();
                                            });
                                          },
                                          child: ProductWidget(
                                            image: product.images!.first.src,
                                            title: product.name,
                                            regularPrize: "\$${product.regularPrice}",
                                            prize: "\$${product.price}",
                                            saleCode: product.sku,
                                            isSale: product.regularPrice == "" ? false : true,
                                            isLike: isInFavourites,
                                            favFun: () {
                                              // if (product.isWishList == true) {
                                              //   product.isWishList = false;
                                              // } else {
                                              //   product.isWishList = true;
                                              // }
                                              if (isInFavourites == true) {
                                                productController.toggleWishList(
                                                    wishlistAction: WishlistAction.remove, product: product);
                                              } else {
                                                productController.toggleWishList(
                                                    wishlistAction: WishlistAction.add, product: product);
                                              }
                                              homeController.onSaleProductList.refresh();
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
                              ),
                              verticalSpace(Get.height * 0.035),
                              Container(
                                height: 200,
                                // width: Get.width,
                                decoration: BoxDecoration(
                                    // color: AppColor.cLightGrey,
                                    borderRadius: BorderRadius.circular(9),
                                    image:
                                        DecorationImage(image: AssetImage(DefaultImages.manImage), fit: BoxFit.cover)),
                                padding: EdgeInsets.all(16),
                                child: bestSellerWidget(
                                    title: 'Best Man Collection'.tr,
                                    subTitle: 'It is a long established fact that a reader will be distracted.'.tr,
                                    onTap: () {
                                      Get.to(() => ProductScreen(
                                            id: '33',
                                          ));
                                    },
                                    isShowIndicator: false),
                              ),
                              verticalSpace(Get.height * 0.015),
                              seeAllRowWidget("Top Rated Products".tr, () {
                                Get.to(() => OnSaleProductListScreen(
                                      dataList: homeController.ratedProductList,
                                      appTitle: 'Top Rated Products',
                                    ));
                              }),
                              verticalSpace(Get.height * 0.015),
                              Container(
                                height: 300,
                                child: PageView.builder(
                                  itemCount: homeController.ratedProductList.length > 6
                                      ? 6
                                      : homeController.ratedProductList.length,
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
                                    if (page == 0 || page == 1) {
                                      homeController.currantIndex.value = 0;
                                    } else if (page == 2 || page == 3) {
                                      homeController.currantIndex.value = 1;
                                    } else {
                                      homeController.currantIndex.value = 2;
                                    }
                                  },
                                  itemBuilder: ((context, index) {
                                    ProductsModel product = homeController.ratedProductList[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: FutureBuilder(
                                          future: productController.addedWishlistProduct(product.id),
                                          builder: (context, AsyncSnapshot<dynamic> snapshot) {
                                            dynamic isInFavourites = snapshot.data;
                                            return GestureDetector(
                                              onTap: () {
                                                Get.to(() => ProductDetailScreen(
                                                          id: product.id.toString(),
                                                        ))!
                                                    .then((value) {
                                                  productController.addedWishlistProduct(product.id);
                                                  homeController.ratedProductList.refresh();
                                                });
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
                                                  homeController.ratedProductList.refresh();
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
                                                isRate: true,
                                                initialRating: product.ratingCount!.toDouble(),
                                                rate: product.averageRating,
                                              ),
                                            );
                                          }),
                                    );
                                  }),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 18),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: buildPageIndicator(3, homeController.currantIndex.value),
                                ),
                              ),
                              blogController.blogPostList.isEmpty
                                  ? SizedBox()
                                  : seeAllRowWidget("Our Blog Posts".tr, () {
                                      Get.to(() => BlogScreen());
                                    }),
                              blogController.blogPostList.isEmpty
                                  ? SizedBox()
                                  : Container(
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
                                              return blogPostWidget(
                                                  image: data.featuredImageUrl,
                                                  title: data.title!.rendered,
                                                  subtitle: parseHtmlString(data.content!.rendered),
                                                  date: dateFormatted(
                                                      date: data.date!,
                                                      formatType: formatForDateTime(FormatType.date)));
                                            },
                                          );
                                        }).toList(),
                                      ),
                                    ),
                              blogController.blogPostList.isEmpty
                                  ? SizedBox()
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 18),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: buildPageIndicator(
                                            blogController.blogPostList.length, blogController.blogPostIndex.value),
                                      ),
                                    ),
                              Text(
                                "New Collections".tr,
                                style: pBold16,
                              ),
                              verticalSpace(8),
                              AspectRatio(
                                aspectRatio: 1,
                                child: GridView.custom(
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  semanticChildCount: 1,
                                  controller: scrollController,
                                  gridDelegate: SliverQuiltedGridDelegate(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    repeatPattern: QuiltedGridRepeatPattern.same,
                                    pattern: pattern,
                                  ),
                                  childrenDelegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                      final tile = pattern[index % pattern.length];
                                      return GestureDetector(
                                        onTap: () {
                                          Get.to(() => ProductDetailScreen(
                                                id: homeController.newCollectionList[index].id.toString(),
                                              ));
                                        },
                                        child: ImageTile(
                                          index: index,
                                          width: tile.crossAxisCount + 157,
                                          height: tile.mainAxisCount + 219,
                                          url: homeController.newCollectionList[index].images!.first.src.toString(),
                                        ),
                                      );
                                    },
                                    childCount: homeController.newCollectionList.length,
                                    addSemanticIndexes: false,
                                    addAutomaticKeepAlives: false,
                                    addRepaintBoundaries: false,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 18),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: buildPageIndicator(
                                    3,
                                    homeController.newCollectionIndex.value,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageTile extends StatelessWidget {
  const ImageTile({
    Key? key,
    required this.index,
    required this.width,
    required this.height,
    required this.url,
  }) : super(key: key);

  final int index;
  final int width;
  final int height;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.cLightBlue,
        borderRadius: BorderRadius.circular(9),
        // image: DecorationImage(image: NetworkImage(url), fit: BoxFit.fill)
      ),
      width: width.toDouble(),
      height: height.toDouble(),
      child: ClipRRect(borderRadius: BorderRadius.circular(9), child: buildCachedNetworkImage(imageUrl: url)),
    );
  }
}
