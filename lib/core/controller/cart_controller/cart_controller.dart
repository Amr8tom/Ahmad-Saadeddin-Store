// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:gostore_app/core/local_model/cart.dart';
import 'package:gostore_app/core/model/cart_model.dart';
import 'package:gostore_app/config/repository/cart_repository.dart';
import 'package:gostore_app/core/model/product_model.dart';
import 'package:gostore_app/utils/constant.dart';
import 'package:gostore_app/utils/prefer.dart';
import 'package:gostore_app/view/screen/dashboard_manager/dashboard_manager.dart';
import 'package:gostore_app/view/widget/loading_widget.dart';

import '../../../utils/helper.dart';

class CartController extends GetxController {
  TextEditingController couponController = TextEditingController();
  CartRepository cartRepository = CartRepository();
  RxMap selectedCartItem = <int, bool>{}.obs;
  RxList selectedCartItemKeyList = [].obs;
  RxList itemKeyList = [].obs;
  RxInt quantity = 1.obs;
  RxInt totalCartItem = 0.obs;
  RxBool isDataAvailable = false.obs;
  CartModel? cartModel;

  CartModel? get cartData => cartModel;
  RxList<CartItems> cartList = <CartItems>[].obs;

  set cartData(CartModel? value) {
    cartModel = value;
    update();
  }

  addToCart({
    required String id,
    required String quantity,
    required String type,
    ProductsModel? productsModel,
    String? size,
    String? color,
    Map? quantityMap,
    bool hideLoader = false,
  }) async {
    String userId = Prefs.getString(AppConstant.userId) ?? '';
    String accessToken = Prefs.getToken();
    print("accessToken====>$accessToken");
    if (accessToken == '') {
      CartItems cartItems = CartItems.fromProduct(
          productsModel: productsModel!,
          quantityAmount: int.tryParse(quantity),
          productsColor: color,
          productsSize: size);

      await Cart.getInstance.addToCart(cartLineItem: cartItems);
      await getCart();
    } else {
      print("userId====>$userId");
      Loader.showLoader();
      Map data = {};
      if (type == "simple") {
        data = {
          // "user_id": userId,
          "id": id,
          "quantity": quantity,
        };
      } else if (type == "variable") {
        data = {
          // "user_id": userId,
          "id": id,
          "quantity": quantity,
          "variation": {
            "attribute_pa_color": color,
            "attribute_pa_size": size,
          }
        };
      } else {
        data = {
          // "user_id": userId,
          "id": id,
          "quantity": quantityMap
        }; //grouped product pending
      }
      var response = await cartRepository.addToCart(data: data);
      if (response != null) {
        log("addToCart-------> $response");
        getCart(hideLoader: hideLoader);
        Get.back();
      }
    }
  }

  totalCartItemValue() async {
    cartList.clear();
    List<CartItems> data = await Cart.getInstance.getCart();
    print("===============data length===${data.length}");
    cartList.value = data;

    List<int?> cartItems = data.map((e) => e.quantity!.value).toList();
    print("===============length lll===${data.length}==${cartItems.length}");

    if (cartItems.isNotEmpty) {
      totalCartItem.value = cartItems.reduce((value, element) => value! + element!)!;
      double total = parseWcPrice(await Cart.getInstance.getTotal());
      double subTotal = parseWcPrice(await Cart.getInstance.getSubtotal());

      CartModel cartModel = CartModel.fromProduct(
        total: total.toString(),
        subTotal: subTotal.toString(),
      );
      cartData = cartModel;
    } else {
      totalCartItem.value = 0;
    }
    print("===============totalCartItemValue=${cartList.length} ${totalCartItem.value}");
    cartList.refresh();
    totalCartItem.refresh();
  }

  getCart({bool hideLoader = false}) async {
    String accessToken = Prefs.getToken();
    print("accessToken====>$accessToken");

    if (accessToken == '') {
      totalCartItemValue();
    } else {
      Loader.showLoader();
      var response = await cartRepository.getCart();
      if (response != null) {
        cartList.clear();
        print("cartList11-------> ${cartList.length}");
        print("get Cart-------> $response");
        cartData = CartModel.fromJson(response);
        cartList.value = cartModel!.items!;
        totalCartItem.value = cartData!.itemCount!;
        print("cartList-------> ${cartList.length}");
        print("total Cart Item-------> ${totalCartItem.value}");

        cartList.refresh();
      }
      if (hideLoader == false) {
        Get.back();
      }
      isDataAvailable.value = false;

      update();
    }
  }

  clearCart() async {
    String accessToken = Prefs.getToken();
    print("accessToken====>$accessToken");

    Loader.showLoader();
    if (accessToken == '') {
      await Cart.getInstance.clear();
    } else {
      var response = await cartRepository.clearCart();
      if (response != null) {
        cartList.clear();
        print("get Cart-------> $response");
        cartData = CartModel.fromJson(response);
        cartList.value = cartModel!.items!;
        totalCartItem.value = cartData!.itemCount!;
        cartList.refresh();
      }
    }
  }

  updateCart({required int id, required String itemKey, required String quantity}) async {
    String accessToken = Prefs.getToken();
    print("accessToken====>$accessToken");

    if (accessToken == '') {
      await Cart.getInstance.updateQuantity(id: id, quantity: int.parse(quantity));
      await totalCartItemValue();
    } else {
      Loader.showLoader();
      var response = await cartRepository.updateCart(itemKey: itemKey, quantity: quantity);
      if (response != null) {
        print("updateCart-------> $response");
        cartList.clear();
        cartData = CartModel.fromJson(response);
        cartList.value = cartModel!.items!;
        totalCartItem.value = cartData!.itemCount!;
        cartList.refresh();
      }
      Get.back();
    }
  }

  Future removeCartItemData({
    required String itemKey,
    required int index,
  }) async {
    print("itemKey-------> $index::$itemKey");
    var response = await cartRepository.removeCartItem(itemKey);
    print("removeCartItem response-------> $response");
    if (response != null) {
      cartList.clear();
      cartData = CartModel.fromJson(response);
      cartList.value = cartModel!.items!;
      totalCartItem.value = cartData!.itemCount!;
      cartList.refresh();
      selectedCartItem.remove(index);
      selectedCartItemKeyList.remove(index);
      // getCart();
    }
  }

  applyCouponItem({
    required String couponCode,
  }) async {
    Loader.showLoader();
    var response = await cartRepository.applyCoupon({"coupon_code": couponCode});
    if (response != null) {
      print("applyCoupon-------> $response");
      getCart();
    }
    Get.back();
  }

  prefItemAddToCart(BuildContext context) async {
    String accessToken = Prefs.getToken();
    print("accessToken====>$accessToken");

    if (accessToken == '') {
    } else {
      isDataAvailable.value = true;
      for (int i = 0; i < cartList.length; i++) {
        CartItems cartItems = cartList[i];
        if (cartItems.meta!.productType == 'simple') {
          addToCart(
            id: cartItems.id.toString(),
            quantity: cartItems.quantity!.value.toString(),
            type: cartItems.meta!.productType!,
            hideLoader: true,
          );
        } else {
          addToCart(
            id: cartItems.id.toString(),
            quantity: cartItems.quantity!.value.toString(),
            type: cartItems.meta!.productType!,
            size: cartItems.meta!.variation!.size,
            color: cartItems.meta!.variation!.color,
            hideLoader: true,
          );
        }
      }
      await Cart.getInstance.clear();
      SchedulerBinding.instance.addPostFrameCallback((_) async {
        await myCart(context);
      });
      Get.back();
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getCart();
    });
  }
}
