// ignore_for_file: must_be_immutable, prefer_const_constructors, prefer_const_constructors_in_immutables, avoid_print

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gostore_app/core/model/order_history_model.dart';
import 'package:gostore_app/utils/colors.dart';
import 'package:gostore_app/utils/images.dart';
import 'package:gostore_app/utils/text_style.dart';
import 'package:gostore_app/view/screen/my_cart/cart_widget.dart';
import 'package:gostore_app/view/widget/common_appbar_widget.dart';
import 'package:gostore_app/view/screen/my_cart/finalize_screen.dart';
import 'package:gostore_app/view/widget/common_space_divider_widget.dart';
import 'package:gostore_app/core/controller/setting_controller/order_history_controller.dart';

class OrderHistoryDetailScreen extends StatefulWidget {
  final String orderId;

  OrderHistoryDetailScreen({Key? key, required this.orderId}) : super(key: key);

  @override
  State<OrderHistoryDetailScreen> createState() =>
      _OrderHistoryDetailScreenState();
}

class _OrderHistoryDetailScreenState extends State<OrderHistoryDetailScreen>
    with TickerProviderStateMixin {
  OrderHistoryController orderHistoryController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getHistoryData();
    });
  }

  getHistoryData() {
    orderHistoryController.getOrderHistoryDetail(widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Obx(() {
              print( orderHistoryController.cartList.length);
              return orderHistoryController.ordersHistory == null
                  ? SizedBox()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildAppBar(
                            orderHistoryController.ordersHistory!.orderKey!),
                        verticalSpace(18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Products".tr,
                              style: pBold14,
                            ),
                          ],
                        ),
                        ListView.builder(
                          itemCount: orderHistoryController.cartList.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            LineItems data =
                                orderHistoryController.cartList[index];
                            print("regularPrice----------${data.regularPrice}");
                            return buildOrderDetailWidget(
                              image: data.image!.src,
                              title: data.name,
                              qty:data.quantity.toString() ,
                              // color: data.productId.,
                              price: data.total.toString(),
                              regularPrice: data.regularPrice,
                              isSale:data.regularPrice==null?false: data.price != int.parse(double.parse(data.regularPrice!).toStringAsFixed(0)),
                              // isSale: data.salePrice != '',
                            );
                          },
                        ),
                        verticalSpace(10),
                        buildTotalWidget(
                            orderHistoryController.ordersHistory!.total!,
                            orderHistoryController.cartList.length,
                            orderHistoryController.ordersHistory!.total!),
                        verticalSpace(30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Delivery".tr,
                              style: pBold14,
                            ),
                          ],
                        ),
                        buildDeliveryWidget(
                          image: DefaultImages.fedExImage,
                          label: orderHistoryController
                              .ordersHistory!.shippingLines!.isNotEmpty?orderHistoryController
                              .ordersHistory!.shippingLines!.first.methodTitle:'',
                          title: "",
                          address:
                              "${orderHistoryController.ordersHistory!.billing!.address1!}, ${orderHistoryController.ordersHistory!.billing!.city!}",
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Payment".tr,
                              style: pBold14,
                            ),
                          ],
                        ),
                        buildDeliveryWidget(
                          image: DefaultImages.masterCardImage,
                          // label: "MasterCard",
                          label: orderHistoryController
                              .ordersHistory!.paymentMethodTitle,
                        ),
                      ],
                    );
            }),
          ),
        ),
      ),
    );
  }
  Widget buildOrderDetailWidget({
    Color? backGroundColor,
    Color? bColor,
    bool? isSale,
    String? image,
    String? title,
    String? color,
    String? price,
    String? regularPrice,
    String? qty,

  }) {
    return Padding(
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
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        Text(
                          "Quantity: ",
                          style: pBold12.copyWith(
                            fontSize: 10,
                          ),
                        ),     Text(
                          qty!,
                          style: pBold12.copyWith(
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
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
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
