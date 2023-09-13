// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:convert';
import 'package:gostore_app/utils/constant.dart';
import 'package:gostore_app/utils/helper.dart';
import 'package:gostore_app/utils/prefer.dart';

import '../model/cart_model.dart';

class Cart {
  Cart._privateConstructor();

  static final Cart getInstance = Cart._privateConstructor();

  Future<List<CartItems>> getCart() async {
    List<CartItems> cartLineItems = [];
    String? currentCartArrJSON = await (Prefs.getString(AppConstant.cart));

    if (currentCartArrJSON != null) {
      cartLineItems = (jsonDecode(currentCartArrJSON) as List<dynamic>)
          .map((i) => CartItems.fromJson(i))
          .toList();
    }
    print('cartLineItems---> ${cartLineItems.length}');

    return cartLineItems;
  }

  Future addToCart({required CartItems cartLineItem}) async {
    List<CartItems> cartLineItems = await getCart();

    cartLineItems.removeWhere((item) {
      return item.id == cartLineItem.id;
    });
    cartLineItems.add(cartLineItem);
    cartLineItems.forEach((element) {
      print('55555555::${element.id}:${element.name}');
    });
    await saveCartToPref(cartLineItems: cartLineItems);
  }

  Future<String> getTotal({bool withFormat = false}) async {
    List<CartItems> cartLineItems = await getCart();
    double total = 0;
    for (var cartItem in cartLineItems) {
      total += (parseWcPrice(cartItem.price) *
          parseWcPrice(cartItem.quantity!.value.toString()));
    }

    if (withFormat == true) {
      return formatDoubleCurrency(total: total);
    }
    return total.toStringAsFixed(2);
  }

  Future<String> getSubtotal({bool withFormat = false}) async {
    List<CartItems> cartLineItems = await getCart();
    double subtotal = 0;
    for (var cartItem in cartLineItems) {
      subtotal +=
          (parseWcPrice(cartItem.totals!.subtotal) * cartItem.quantity!.value!);
    }
    if (withFormat == true) {
      return formatDoubleCurrency(total: subtotal);
    }
    return subtotal.toStringAsFixed(2);
  }

  Future<String> cartShortDesc() async {
    List<CartItems> cartLineItems = await getCart();
    return cartLineItems
        .map((cartItem) =>
            "${cartItem.quantity.toString()} x | ${cartItem.name}")
        .toList()
        .join(",");
  }

  updateQuantity({required int id, required int quantity}) async {
    List<CartItems> cartLineItems = await getCart();
    List<CartItems> tmpCartItem = [];
    for (var cartItem in cartLineItems) {
      if (cartItem.id == id) {
        // if ((cartItem.quantity!.value! + incrementQuantity) > 0) {
        cartItem.quantity!.value = quantity;
        // }
      }
      tmpCartItem.add(cartItem);
    }
    await saveCartToPref(cartLineItems: tmpCartItem);
  }

 removeCartItemForIndex(
      {int? index, required List<CartItems> cartLineItems}) async {
    // List<CartItems> cartLineItems = await getCart();
    // cartLineItems.removeAt(index);
    await saveCartToPref(cartLineItems: cartLineItems);
  }

  clear() async => Prefs.remove(AppConstant.cart);

  saveCartToPref({required List<CartItems> cartLineItems}) async {
    String json = jsonEncode(cartLineItems.map((i) => i.toJson()).toList());
    await Prefs.setString(AppConstant.cart, json);
  }
}
