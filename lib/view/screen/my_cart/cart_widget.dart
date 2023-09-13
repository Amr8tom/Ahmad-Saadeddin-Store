// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_const_constructors_in_immutables, avoid_print, invalid_use_of_protected_member

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gostore_app/core/local_model/cart.dart';
import 'package:gostore_app/core/model/cart_model.dart';
import 'package:gostore_app/utils/prefer.dart';
import 'package:gostore_app/view/screen/auth/login_screen.dart';
import 'package:gostore_app/view/screen/my_cart/checkout_screen.dart';
import 'package:gostore_app/view/widget/common_snak_bar_widget.dart';
import 'package:gostore_app/view/widget/loading_widget.dart';
import '../../widget/common_button.dart';
import 'package:gostore_app/utils/images.dart';
import 'package:gostore_app/utils/colors.dart';
import 'package:gostore_app/utils/text_style.dart';
import 'package:gostore_app/view/widget/icon_and_image.dart';
import 'package:gostore_app/view/widget/common_appbar_widget.dart';
import 'package:gostore_app/view/widget/common_space_divider_widget.dart';
import 'package:gostore_app/core/controller/cart_controller/cart_controller.dart';

class CartBottomSheet extends StatefulWidget {
  CartBottomSheet({Key? key}) : super(key: key);

  @override
  State<CartBottomSheet> createState() => _CartBottomSheetState();
}

class _CartBottomSheetState extends State<CartBottomSheet> {
  CartController cartController = Get.put(CartController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartController.selectedCartItem.clear();
    cartController.selectedCartItemKeyList.clear();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // getAllCart();
    });
  }

  getAllCart() async {
    await cartController.getCart();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: CommonIconBorderButton(
              width: 125,
              radius: 20,
              iconData: DefaultImages.cancelIcn,
              btnColor: AppColor.cDarkGrey,
              title: 'Cancel'.tr,
              onPressed: () {
                Get.back();
              },
            ),
          ),
          verticalSpace(15),
          Expanded(
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(10)), color: AppColor.cWhite),
              child: Padding(
                padding: EdgeInsets.only(
                  top: Get.height * 0.05,
                  right: 22,
                  left: 22,
                ),
                child: Obx(
                  () {
                    print("------${cartController.selectedCartItem}");
                    return cartController.isDataAvailable.value
                        ? LoadingWidget()
                        : SingleChildScrollView(
                            child: cartController.cartList.isEmpty
                                ? SizedBox(
                                    height: Get.height / 2,
                                    child: Center(
                                      child: Text(
                                        "Cart Item not found",
                                        style: pSemiBold12.copyWith(color: AppColor.cGreyFont),
                                      ),
                                    ),
                                  )
                                : Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Cart".tr,
                                            style: pBold24.copyWith(fontSize: 20),
                                          ),
                                          _buildDeleteButton(),
                                        ],
                                      ),
                                      verticalSpace(10),
                                      cartController.cartList.isNotEmpty
                                          ? ListView.builder(
                                              itemCount: cartController.cartList.length,
                                              shrinkWrap: true,
                                              physics: NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                CartItems data = cartController.cartList[index];
                                                return buildCartWidget(
                                                  value: data.isSelected,
                                                  backGroundColor:
                                                      data.isSelected == true ? AppColor.cLightBlue : AppColor.cWhite,
                                                  bColor: data.isSelected == true
                                                      ? AppColor.blueThemeColor
                                                      : AppColor.cBorder,
                                                  image: data.featuredImage,
                                                  title: data.name,
                                                  color: data.meta == null || data.meta!.variation == null
                                                      ? null
                                                      : data.meta!.variation!.color == ''
                                                          ? null
                                                          : data.meta!.variation!.color,
                                                  price:
                                                      (data.quantity!.value! * int.parse(data.price.toString()) / 100)
                                                          .toString(),
                                                  regularPrice: data.regularPrice,
                                                  isSale: data.salePrice == "0" ? false : true,
                                                  // isSale:data.salePrice == data.regularPrice ? false : true,
                                                  qty: data.quantity!.value.toString(),
                                                  onChanged: (bool? value) {
                                                    data.isSelected = value!;
                                                    cartController.cartList.refresh();
                                                    if (value == true) {
                                                      cartController.selectedCartItem[index] = value;
                                                      cartController.selectedCartItemKeyList
                                                          .add({"index": index, 'key': data.itemKey});
                                                    } else {
                                                      cartController.selectedCartItem.remove(index);
                                                      cartController.selectedCartItemKeyList.removeAt(index);
                                                      cartController.selectedCartItemKeyList.refresh();
                                                    }
                                                    print('index==== $index');
                                                    print(
                                                        'selectedCartItemKeyList==== ${cartController.selectedCartItemKeyList.value}');
                                                    print(
                                                        'selectedCartItem==== ${cartController.selectedCartItem.value}');
                                                  },
                                                  incrementFun: () {
                                                    data.quantity!.value = data.quantity!.value! + 1;
                                                    cartController.cartList.refresh();
                                                    cartController.updateCart(
                                                        id: data.id!,
                                                        itemKey: data.itemKey.toString(),
                                                        quantity: data.quantity!.value.toString());
                                                  },
                                                  decrementFun: () {
                                                    if (data.quantity!.value! > 1) {
                                                      // data.qty -= 1;
                                                      data.quantity!.value = data.quantity!.value! - 1;
                                                      cartController.cartList.refresh();
                                                      cartController.updateCart(
                                                          id: data.id!,
                                                          itemKey: data.itemKey.toString(),
                                                          quantity: data.quantity!.value.toString());
                                                    }
                                                  },
                                                );
                                              },
                                            )
                                          : SizedBox(
                                              height: Get.height / 2,
                                              child: Center(
                                                  child: Text(
                                                "Item not found!",
                                                style: pSemiBold12.copyWith(color: AppColor.cGreyFont),
                                              ))),
                                      cartController.cartModel!.coupons == null
                                          ? SizedBox(
                                              height: 15,
                                            )
                                          : Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                cartController.cartModel!.coupons!.isEmpty
                                                    ? SizedBox()
                                                    : horizontalDivider(),
                                                cartController.cartModel!.coupons!.isEmpty
                                                    ? SizedBox()
                                                    : Text(
                                                        "Have you a Coupon Code?".tr,
                                                        style: pBold14,
                                                      ),
                                                cartController.cartModel!.coupons!.isEmpty
                                                    ? SizedBox()
                                                    : buildCouponWidget(
                                                        cartController.cartModel!.coupons!.first.coupon.toString(), () {
                                                        /*  cartController.couponController.text.isEmpty
                                ? commonToast("Coupon code is Empty")
                                : */
                                                        cartController.applyCouponItem(
                                                            couponCode: cartController.cartModel!.coupons!.first.coupon
                                                                .toString());
                                                      }),
                                              ],
                                            ),
                                      horizontalDivider(),
                                      buildTotalWidget(
                                          cartController.cartModel == null
                                              ? '0.00'
                                              : '${double.parse(cartController.cartModel!.totals!.subtotal!) / 100}',
                                          cartController.totalCartItem.value,
                                          // cartController.cartModel == null
                                          //     ? 0
                                          //     : cartController.cartModel!.itemCount,
                                          cartController.cartModel!.totals == null
                                              ? '0.00'
                                              : '${double.parse(cartController.cartModel!.totals!.total!) / 100}'),
                                      verticalSpace(30),
                                      buildContinueButton(
                                          cartController.cartModel == null
                                              ? '0.00'
                                              : '${double.parse(cartController.cartModel!.totals!.total!) / 100}',
                                          cartController.cartList.isEmpty
                                              ? () {
                                                  commonToast("Cart is empty!");
                                                }
                                              : () {
                                                  String accessToken = Prefs.getToken();
                                                  print(".accessToken ==($accessToken)");
                                                  if (accessToken == '') {
                                                    Get.back();
                                                    Get.to(() => LoginScreen(
                                                          page: 3,
                                                          isBack: true,
                                                        ));
                                                  } else {
                                                    Navigator.of(context).push(MaterialPageRoute(
                                                      builder: (context) {
                                                        return CheckoutScreen();
                                                      },
                                                    ));
                                                  }
                                                  // : Get.to(() => CheckoutScreen());
                                                },
                                          isTap: cartController.cartList.isEmpty),
                                      verticalSpace(30),
                                    ],
                                  ),
                          );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDeleteButton() {
    bool isFalseAvailable = cartController.selectedCartItem.value.containsValue(true);
    if (isFalseAvailable) {
      return commonMenuIconWidget(
        onTap: () async {
          String accessToken = Prefs.getToken();
          print("accessToken====>$accessToken");

          if (accessToken == '') {
            cartController.cartList.removeWhere((element) {
              return element.isSelected == true;
            });
            print('length==== ${cartController.cartList.length}');

            await Cart.getInstance.removeCartItemForIndex(cartLineItems: cartController.cartList.value);
            await cartController.getCart();
            cartController.selectedCartItem.clear();
            cartController.selectedCartItemKeyList.clear();
          } else {
            if (cartController.selectedCartItem.isNotEmpty) {
              Loader.showLoader();
              for (int i = 0; i < cartController.selectedCartItemKeyList.length; i++) {
                print('12121==== ${cartController.selectedCartItemKeyList[i]}');
                print('12121====key ${cartController.selectedCartItemKeyList[i]['key']}');
                print('12121====index ${cartController.selectedCartItemKeyList[i]['index']}');
                await cartController.removeCartItemData(
                  itemKey: cartController.selectedCartItemKeyList[i]['key'].toString(),
                  index: cartController.selectedCartItemKeyList[i]['index'],
                );
              }
            }
            Get.back();
            cartController.cartList.refresh();
            cartController.selectedCartItem.refresh();
            cartController.selectedCartItemKeyList.refresh();
          }
        },
        icon: DefaultImages.trashIcn,
        bColor: AppColor.cBorder,
        height: 35,
        width: 35,
      );
    } else {
      return SizedBox();
    }
  }

  Widget buildContinueButton(String total, Function() onTap, {bool? isTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 53,
        decoration: BoxDecoration(
          color: isTap == true ? AppColor.cCategoryLabel : AppColor.blueThemeColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "\$$total",
              style: pBold14.copyWith(
                color: AppColor.cBtnTxt,
              ),
            ),
            horizontalSpace(10),
            Text(
              "|  ",
              style: pBold14.copyWith(
                color: AppColor.cLabel,
              ),
            ),
            Text(
              "Continue".tr,
              style: pBold14.copyWith(
                color: AppColor.cBtnTxt,
              ),
            ),
            horizontalSpace(10),
            assetSvdImageWidget(image: DefaultImages.arrowRightIcn)
          ],
        ),
      ),
    );
  }

  Widget buildCouponWidget(String code, Function() onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 52,
        decoration: BoxDecoration(
            color: AppColor.cLightBlue,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColor.blueThemeColor)),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                assetSvdImageWidget(image: DefaultImages.couponIcn),
                horizontalSpace(10),
                Text(
                  code,
                  style: pMedium14,
                ),
                // SizedBox(
                //   width: 150,
                //   child: TextFormField(
                //     controller: cartController.couponController,
                //   ),
                // )
              ],
            ),
            GestureDetector(
              onTap: onTap,
              child: Container(
                height: 28,
                width: 89,
                decoration: BoxDecoration(
                    color: AppColor.blueThemeColor,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: AppColor.blueThemeColor)),
                child: FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.done_outlined,
                        color: AppColor.cBtnTxt,
                      ),
                      horizontalSpace(4),
                      Text(
                        "Apply".tr,
                        style: pBold12.copyWith(color: AppColor.cBtnTxt),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget buildTotalWidget(
  String price,
  int? totalProduct,
  String totalPrice,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${"Price".tr} ($totalProduct item)",
            style: pBold14,
          ),
          verticalSpace(9),
          Text(
            "Total Price".tr,
            style: pBold14,
          ),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "\$$price",
            style: pBold14,
          ),
          verticalSpace(9),
          Text(
            "\$$totalPrice",
            style: pBold14.copyWith(color: AppColor.cText),
          ),
        ],
      ),
    ],
  );
}

Widget buildCartWidget({
  bool isCheckout = false,
  ValueChanged<bool?>? onChanged,
  bool? value,
  Color? backGroundColor,
  Color? bColor,
  bool? isSale,
  String? image,
  String? title,
  String? color,
  String? price,
  String? regularPrice,
  String? qty,
  Function()? incrementFun,
  Function()? decrementFun,
}) {
  return GestureDetector(
    // onTap: (){return onChanged!;},
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 86.48,
        width: Get.width,
        decoration: BoxDecoration(
            color: backGroundColor ?? AppColor.cBackGround,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: bColor ?? AppColor.cBorder)),
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            isCheckout
                ? horizontalSpace(0)
                : SizedBox(
                    width: 24,
                    child: Checkbox(
                      value: value,
                      onChanged: onChanged,
                      checkColor: AppColor.cBtnTxt,
                      activeColor: AppColor.blueThemeColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      side: BorderSide(color: AppColor.blueThemeColor, width: 1.5),
                    ),
                  ),
            horizontalSpace(isCheckout ? 0 : 8),
            Container(
              height: 68.07,
              width: 64.54,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  image: DecorationImage(image: NetworkImage(image!), fit: BoxFit.fill)),
              padding: EdgeInsets.all(5),
              child: /*isCheckout
                  ? horizontalSpace(0)
                  : */isSale == true
                      ? Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            height: 14,
                            width: 18,
                            decoration: BoxDecoration(
                              color: AppColor.cFav,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                '%',
                                style: pBold12.copyWith(color: AppColor.cBtnTxt),
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
            ),
            horizontalSpace(8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title!,
                        style: pBold12.copyWith(fontSize: 10.98),
                      ),
                      verticalSpace(4),
                      Text(
                        color == null ? "" : '${"Color"}: $color',
                        style: pSemiBold8.copyWith(color: AppColor.cGreyFont),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '\$$price',
                            style: pBold12.copyWith(fontSize: 17, color: AppColor.cText),
                          ),
                          horizontalSpace(4),
                          isSale == true
                              ? Text(
                                  '\$$regularPrice',
                                  style: pSemiBold8.copyWith(color: AppColor.cGreyFont),
                                )
                              : horizontalSpace(0),
                        ],
                      ),
                      isCheckout
                          ? horizontalSpace(0)
                          : Row(
                              children: [
                                GestureDetector(
                                  onTap: decrementFun,
                                  child: assetSvdImageWidget(
                                    image: DefaultImages.minusIcn,
                                    width: 18,
                                    height: 18,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    qty!,
                                    style: pBold12.copyWith(
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: incrementFun,
                                  child: assetSvdImageWidget(
                                    image: DefaultImages.blueAddIcn,
                                    width: 18,
                                    height: 18,
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
