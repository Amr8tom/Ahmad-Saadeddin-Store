import 'package:gostore_app/core/model/product_model.dart';
import 'package:gostore_app/utils/constant.dart';
import 'package:gostore_app/utils/prefer.dart';
import 'dart:convert';

class WishList {
  WishList._privateConstructor();

  static final WishList getInstance = WishList._privateConstructor();

  Future<List<dynamic>> getWishlistProducts() async {
    List<dynamic> favouriteProducts = [];
    String? currentProductsJSON =
        await (Prefs.getString(AppConstant.wishlistProducts)??'');
    if (currentProductsJSON != '') {
      favouriteProducts = (jsonDecode(currentProductsJSON!)).toList();
    }
    return favouriteProducts;
  }

  hasAddedWishlistProduct(int? productId) async {
    List<dynamic> favouriteProducts = await getWishlistProducts();
    List<int> productIds =
        favouriteProducts.map((e) => e['id']).cast<int>().toList();
    if (productIds.isEmpty) {
      return false;
    }
    return productIds.contains(productId);
  }

  saveWishlistProduct({required ProductsModel product}) async {
    List<dynamic> products = await getWishlistProducts();
    if (products.any((wishListProduct) => wishListProduct['id'] == product.id) ==
        false) {
      products.add({"id": product.id});
    }
    String json = jsonEncode(products.map((i) => {"id": i['id']}).toList());
    await Prefs.setString(AppConstant.wishlistProducts, json);
  }

  removeWishlistProduct({required ProductsModel product}) async {
    List<dynamic> products = await getWishlistProducts();
    products.removeWhere((element) => element['id'] == product.id);

    String json = jsonEncode(products.map((i) => {"id": i['id']}).toList());
    await Prefs.setString(AppConstant.wishlistProducts, json);
  }
  clear() async => Prefs.remove(AppConstant.wishlistProducts);

}
