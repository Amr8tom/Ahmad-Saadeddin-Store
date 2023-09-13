// ignore_for_file: unnecessary_this, prefer_collection_literals, avoid_print, unrelated_type_equality_checks

import 'package:gostore_app/core/model/product_model.dart';

class CartModel {
  String? cartHash;
  String? cartKey;
  Currency? currency;
  Customer? customer;
  List<CartItems>? items;
  int? itemCount;
  int? itemsWeight;
  List<Coupons>? coupons;
  bool? needsPayment;
  bool? needsShipping;
  Shipping? shipping;
  List<dynamic>? fees;
  List<dynamic>? taxes;
  ProductTotals? totals;
  List<dynamic>? removedItems;
  List<dynamic>? crossSells;
  Notices? notices;

  CartModel(
      {this.cartHash,
      this.cartKey,
      this.currency,
      this.customer,
      this.items,
      this.itemCount,
      this.itemsWeight,
      this.coupons,
      this.needsPayment,
      this.needsShipping,
      this.shipping,
      this.fees,
      this.taxes,
      this.totals,
      this.removedItems,
      this.crossSells,
      this.notices});

  CartModel.fromJson(Map<String, dynamic> json) {
    cartHash = json['cart_hash'];
    cartKey = json['cart_key'];
    currency =
        json['currency'] != null ? Currency.fromJson(json['currency']) : null;
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    if (json['items'] != null) {
      items = <CartItems>[];
      json['items'].forEach((v) {
        items!.add(CartItems.fromJson(v));
      });
    }
    itemCount = json['item_count'];
    itemsWeight = json['items_weight'];
    if (json['coupons'] != null) {
      coupons = <Coupons>[];
      json['coupons'].forEach((v) {
        coupons!.add(Coupons.fromJson(v));
      });
    }
    needsPayment = json['needs_payment'];
    needsShipping = json['needs_shipping'];
    shipping =
        json['shipping'] != null ? Shipping.fromJson(json['shipping']) : null;
    // if (json['fees'] != null) {
    //   fees = List<Null>();
    //   json['fees'].forEach((v) { fees.add(Null.fromJson(v)); });
    // }
    // if (json['taxes'] != null) {
    //   taxes = List<Null>();
    //   json['taxes'].forEach((v) { taxes.add(Null.fromJson(v)); });
    // }
    totals =
        json['totals'] != null ? ProductTotals.fromJson(json['totals']) : null;
    // if (json['removed_items'] != null) {
    //   removedItems = List<Null>();
    //   json['removed_items'].forEach((v) { removedItems.add(Null.fromJson(v)); });
    // }
    // if (json['cross_sells'] != null) {
    //   crossSells = List<Null>();
    //   json['cross_sells'].forEach((v) { crossSells.add(Null.fromJson(v)); });
    // }
    // if (json['notices'] != null) {
    //   notices = List<Null>();
    //   json['notices'].forEach((v) { notices.add(Null.fromJson(v)); });
    // }
    if (json['notices'].runtimeType == List<dynamic>) {
      notices = null;
    } else {
      notices = Notices.fromJson(json['notices']);
    }
    // notices =
    // json['notices'] != null ? Notices.fromJson(json['notices']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cart_hash'] = this.cartHash;
    data['cart_key'] = this.cartKey;
    if (this.currency != null) {
      data['currency'] = this.currency!.toJson();
    }
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['item_count'] = this.itemCount;
    data['items_weight'] = this.itemsWeight;
    if (this.coupons != null) {
      data['coupons'] = this.coupons!.map((v) => v.toJson()).toList();
    }
    data['needs_payment'] = this.needsPayment;
    data['needs_shipping'] = this.needsShipping;
    if (this.shipping != null) {
      data['shipping'] = this.shipping!.toJson();
    }
    if (this.fees != null) {
      data['fees'] = this.fees!.map((v) => v.toJson()).toList();
    }
    if (this.taxes != null) {
      data['taxes'] = this.taxes!.map((v) => v.toJson()).toList();
    }
    if (this.totals != null) {
      data['totals'] = this.totals!.toJson();
    }

    if (this.removedItems != null) {
      data['removed_items'] =
          this.removedItems!.map((v) => v.toJson()).toList();
    }
    if (this.crossSells != null) {
      data['cross_sells'] = this.crossSells!.map((v) => v.toJson()).toList();
    }
    // if (this.notices != null) {
    //   data['notices'] = this.notices!.map((v) => v.toJson()).toList();
    // }
    if (this.notices != null) {
      data['notices'] = this.notices!.toJson();
    }
    return data;
  }

  CartModel.fromProduct({String? total, required String subTotal}) {
    totals = ProductTotals(total: total.toString(), subtotal: subTotal);
  }
}

class CartItems {
  bool isSelected = false;
  String? itemKey;
  int? id;
  String? name;
  String? title;
  String? price;
  String? regularPrice;
  String? salePrice;
  String? color;
  String? size;
  double? total;
  Quantity? quantity;
  Totals? totals;
  String? slug;
  Meta? meta;
  String? backorders;
  List<dynamic>? cartItemData;
  String? featuredImage;

  CartItems(
      {this.isSelected = false,
      this.itemKey,
      this.id,
      this.name,
      this.title,
      this.price,
      this.salePrice,
      this.color,
      this.size,
      this.total = 0.0,
      this.regularPrice,
      this.quantity,
      this.totals,
      this.slug,
      this.meta,
      this.backorders,
      this.cartItemData,
      this.featuredImage});

  CartItems.fromJson(Map<String, dynamic> json) {
    itemKey = json['item_key'];
    id = json['id'];
    name = json['name'];
    title = json['title'];
    price = json['price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price']==null?"0":json['sale_price'].toString();
    quantity =
        json['quantity'] != null ? Quantity.fromJson(json['quantity']) : null;
    totals = json['totals'] != null ? Totals.fromJson(json['totals']) : null;
    slug = json['slug'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    backorders = json['backorders'];
    if (json['cart_item_data'] != null) {
      cartItemData = [];
      json['cart_item_data'].forEach((v) {
        cartItemData!.add(v);
      });
    }
    featuredImage = json['featured_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item_key'] = this.itemKey;
    data['id'] = this.id;
    data['name'] = this.name;
    data['title'] = this.title;
    data['price'] = this.price;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;
    if (this.quantity != null) {
      data['quantity'] = this.quantity!.toJson();
    }
    if (this.totals != null) {
      data['totals'] = this.totals!.toJson();
    }
    data['slug'] = this.slug;
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    data['backorders'] = this.backorders;
    if (this.cartItemData != null) {
      data['cart_item_data'] =
          this.cartItemData!.map((v) => v.toJson()).toList();
    }
    data['featured_image'] = this.featuredImage;
    return data;
  }

  CartItems.fromProduct(
      {int? quantityAmount,
      required ProductsModel productsModel,
      String? productsColor,
      String? productsSize}) {
    name = productsModel.name;
    id = productsModel.id;
    quantity = Quantity(value: quantityAmount);
    totals = Totals(subtotal:(int.parse(productsModel.price!)*100).toString(), total: double.parse((int.parse(productsModel.price!)*100).toString()));
    id = productsModel.id;
    title = productsModel.name;
    featuredImage = productsModel.images!.first.src;
    color = productsColor ?? '';
    size = productsSize ?? '';
    meta = Meta(productType: productsModel.type,variation: Variation(color: productsColor, size: productsSize));
    price =( int.parse(productsModel.price!)*100).toString();
    regularPrice = productsModel.regularPrice;
    itemKey = productsModel.id.toString();
    print("color===$color.");
    print("size===$size.");
    print("regularPrice===$regularPrice.");
    print("quantity===${quantity?.value}.");
    print("total===$total");
    print("price===$price");
    print("totals===${totals!.total}");
    print("meta===${meta!.variation!.color}");
    print("meta===${meta!.variation!.size}");
    print("productType===${meta!.productType}");
  }
}

class Quantity {
  int? value;
  int? minPurchase;
  int? maxPurchase;

  Quantity({this.value, this.minPurchase, this.maxPurchase});

  Quantity.fromJson(Map<String, dynamic> json) {
    value = json['value'] ?? 1;
    minPurchase = json['min_purchase'];
    maxPurchase = json['max_purchase'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = this.value;
    data['min_purchase'] = this.minPurchase;
    data['max_purchase'] = this.maxPurchase;

    return data;
  }
}

class Totals {
  String? subtotal;
  int? subtotalTax;
  double? total;
  int? tax;

  Totals({this.subtotal, this.subtotalTax, this.total, this.tax});

  Totals.fromJson(Map<String, dynamic> json) {
    subtotal = json['subtotal'];
    subtotalTax = json['subtotal_tax'];
    total = double.parse(json['total'].toString());
    tax = json['tax'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subtotal'] = this.subtotal;
    data['subtotal_tax'] = this.subtotalTax;
    data['total'] = this.total;
    data['tax'] = this.tax;
    return data;
  }
}

class Meta {
  String? productType;
  String? sku;
  Dimensions? dimensions;
  int? weight;
  Variation? variation;

  Meta(
      {this.productType,
      this.sku,
      this.dimensions,
      this.weight,
      this.variation});

  Meta.fromJson(Map<String, dynamic> json) {
    productType = json['product_type'];
    sku = json['sku'];
    dimensions = json['dimensions'] != null
        ? Dimensions.fromJson(json['dimensions'])
        : null;
    weight = json['weight'];
    if (json['variation'].runtimeType == List<dynamic>) {
      variation = null;
    } else {
      variation = Variation.fromJson(json['variation']);
    }
    // variation = json['variation'] != null ? Variation.fromJson(json['variation']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['product_type'] = this.productType;
    data['sku'] = this.sku;
    if (this.dimensions != null) {
      data['dimensions'] = this.dimensions!.toJson();
    }
    data['weight'] = this.weight;
    if (this.variation != null) {
      data['variation'] = this.variation!.toJson();
    }
    return data;
  }
}

class Dimensions {
  String? length;
  String? width;
  String? height;
  String? unit;

  Dimensions({this.length, this.width, this.height, this.unit});

  Dimensions.fromJson(Map<String, dynamic> json) {
    length = json['length'];
    width = json['width'];
    height = json['height'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['length'] = this.length;
    data['width'] = this.width;
    data['height'] = this.height;
    data['unit'] = this.unit;
    return data;
  }
}

class Variation {
  String? color;
  String? size;

  Variation({this.color, this.size});

  Variation.fromJson(Map<String, dynamic> json) {
    color = json['Color'];
    size = json['Size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Color'] = this.color;
    data['Size'] = this.size;
    print('Variation=======>$data');
    return data;
  }
}

class Shipping {
  int? totalPackages;
  bool? showPackageDetails;
  bool? hasCalculatedShipping;
  Packages? packages;

  Shipping(
      {this.totalPackages,
      this.showPackageDetails,
      this.hasCalculatedShipping,
      this.packages});

  Shipping.fromJson(Map<String, dynamic> json) {
    totalPackages = json['total_packages'];
    showPackageDetails = json['show_package_details'];
    hasCalculatedShipping = json['has_calculated_shipping'];
    print("packages======>${json['packages']}");
    print("packages======>00${json['packages'].runtimeType}");
    if (json['packages'].runtimeType != List<dynamic>) {
      packages =
          json['packages'] != null ? Packages.fromJson(json['packages']) : null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_packages'] = this.totalPackages;
    data['show_package_details'] = this.showPackageDetails;
    data['has_calculated_shipping'] = this.hasCalculatedShipping;
    // if (this.packages != null) {
    print("packages======>111${this.packages}");

    if (this.packages != List<dynamic>) {
      data['packages'] = this.packages!.toJson();
    }
    return data;
  }
}

class Coupons {
  String? coupon;
  String? label;
  String? saving;
  String? savingHtml;

  Coupons({this.coupon, this.label, this.saving, this.savingHtml});

  Coupons.fromJson(Map<String, dynamic> json) {
    coupon = json['coupon'];
    label = json['label'];
    saving = json['saving'];
    savingHtml = json['saving_html'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['coupon'] = this.coupon;
    data['label'] = this.label;
    data['saving'] = this.saving;
    data['saving_html'] = this.savingHtml;
    return data;
  }
}

class Notices {
  List<String>? error;

  Notices({this.error});

  Notices.fromJson(Map<String, dynamic> json) {
    error =json['success']==null?null: json['success'].cast<String>()??'';
    error = json['error']==null?null: json['error'].cast<String>()??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = this.error;
    data['error'] = this.error;
    return data;
  }
}

class Currency {
  String? currencyCode;
  String? currencySymbol;
  int? currencyMinorUnit;
  String? currencyDecimalSeparator;
  String? currencyThousandSeparator;
  String? currencyPrefix;
  String? currencySuffix;

  Currency(
      {this.currencyCode,
      this.currencySymbol,
      this.currencyMinorUnit,
      this.currencyDecimalSeparator,
      this.currencyThousandSeparator,
      this.currencyPrefix,
      this.currencySuffix});

  Currency.fromJson(Map<String, dynamic> json) {
    currencyCode = json['currency_code'];
    currencySymbol = json['currency_symbol'];
    currencyMinorUnit = json['currency_minor_unit'];
    currencyDecimalSeparator = json['currency_decimal_separator'];
    currencyThousandSeparator = json['currency_thousand_separator'];
    currencyPrefix = json['currency_prefix'];
    currencySuffix = json['currency_suffix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currency_code'] = this.currencyCode;
    data['currency_symbol'] = this.currencySymbol;
    data['currency_minor_unit'] = this.currencyMinorUnit;
    data['currency_decimal_separator'] = this.currencyDecimalSeparator;
    data['currency_thousand_separator'] = this.currencyThousandSeparator;
    data['currency_prefix'] = this.currencyPrefix;
    data['currency_suffix'] = this.currencySuffix;
    return data;
  }
}

class Customer {
  BillingAddress? billingAddress;
  ShippingAddress? shippingAddress;

  Customer({this.billingAddress, this.shippingAddress});

  Customer.fromJson(Map<String, dynamic> json) {
    billingAddress = json['billing_address'] != null
        ? BillingAddress.fromJson(json['billing_address'])
        : null;
    shippingAddress = json['shipping_address'] != null
        ? ShippingAddress.fromJson(json['shipping_address'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.billingAddress != null) {
      data['billing_address'] = this.billingAddress!.toJson();
    }
    if (this.shippingAddress != null) {
      data['shipping_address'] = this.shippingAddress!.toJson();
    }
    return data;
  }
}

class BillingAddress {
  String? billingFirstName;
  String? billingLastName;
  String? billingCompany;
  String? billingCountry;
  String? billingAddress1;
  String? billingAddress2;
  String? billingCity;
  String? billingState;
  String? billingPostcode;
  String? billingPhone;
  String? billingEmail;

  BillingAddress(
      {this.billingFirstName,
      this.billingLastName,
      this.billingCompany,
      this.billingCountry,
      this.billingAddress1,
      this.billingAddress2,
      this.billingCity,
      this.billingState,
      this.billingPostcode,
      this.billingPhone,
      this.billingEmail});

  BillingAddress.fromJson(Map<String, dynamic> json) {
    billingFirstName = json['billing_first_name'];
    billingLastName = json['billing_last_name'];
    billingCompany = json['billing_company'];
    billingCountry = json['billing_country'];
    billingAddress1 = json['billing_address_1'];
    billingAddress2 = json['billing_address_2'];
    billingCity = json['billing_city'];
    billingState = json['billing_state'];
    billingPostcode = json['billing_postcode'];
    billingPhone = json['billing_phone'];
    billingEmail = json['billing_email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['billing_first_name'] = this.billingFirstName;
    data['billing_last_name'] = this.billingLastName;
    data['billing_company'] = this.billingCompany;
    data['billing_country'] = this.billingCountry;
    data['billing_address_1'] = this.billingAddress1;
    data['billing_address_2'] = this.billingAddress2;
    data['billing_city'] = this.billingCity;
    data['billing_state'] = this.billingState;
    data['billing_postcode'] = this.billingPostcode;
    data['billing_phone'] = this.billingPhone;
    data['billing_email'] = this.billingEmail;
    return data;
  }
}

class ShippingAddress {
  String? shippingFirstName;
  String? shippingLastName;
  String? shippingCompany;
  String? shippingCountry;
  String? shippingAddress1;
  String? shippingAddress2;
  String? shippingCity;
  String? shippingState;
  String? shippingPostcode;

  ShippingAddress(
      {this.shippingFirstName,
      this.shippingLastName,
      this.shippingCompany,
      this.shippingCountry,
      this.shippingAddress1,
      this.shippingAddress2,
      this.shippingCity,
      this.shippingState,
      this.shippingPostcode});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    shippingFirstName = json['shipping_first_name'];
    shippingLastName = json['shipping_last_name'];
    shippingCompany = json['shipping_company'];
    shippingCountry = json['shipping_country'];
    shippingAddress1 = json['shipping_address_1'];
    shippingAddress2 = json['shipping_address_2'];
    shippingCity = json['shipping_city'];
    shippingState = json['shipping_state'];
    shippingPostcode = json['shipping_postcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['shipping_first_name'] = this.shippingFirstName;
    data['shipping_last_name'] = this.shippingLastName;
    data['shipping_company'] = this.shippingCompany;
    data['shipping_country'] = this.shippingCountry;
    data['shipping_address_1'] = this.shippingAddress1;
    data['shipping_address_2'] = this.shippingAddress2;
    data['shipping_city'] = this.shippingCity;
    data['shipping_state'] = this.shippingState;
    data['shipping_postcode'] = this.shippingPostcode;
    return data;
  }
}

class Packages {
  Default? defaultData;

  Packages({this.defaultData});

  Packages.fromJson(Map<String, dynamic> json) {
    defaultData =
        json['default'] != null ? Default.fromJson(json['default']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.defaultData != null) {
      data['default'] = this.defaultData!.toJson();
    }
    return data;
  }
}

class Default {
  String? packageName;
  Rates? rates;
  String? packageDetails;
  int? index;
  String? chosenMethod;
  String? formattedDestination;

  Default(
      {this.packageName,
      this.rates,
      this.packageDetails,
      this.index,
      this.chosenMethod,
      this.formattedDestination});

  Default.fromJson(Map<String, dynamic> json) {
    packageName = json['package_name'];
    rates = json['rates'] != null ? Rates.fromJson(json['rates']) : null;
    packageDetails = json['package_details'];
    index = json['index'];
    chosenMethod = json['chosen_method'];
    formattedDestination = json['formatted_destination'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['package_name'] = this.packageName;
    if (this.rates != null) {
      data['rates'] = this.rates!.toJson();
    }
    data['package_details'] = this.packageDetails;
    data['index'] = this.index;
    data['chosen_method'] = this.chosenMethod;
    data['formatted_destination'] = this.formattedDestination;
    return data;
  }
}

class Rates {
  FreeShipping1? freeShipping1;

  Rates({this.freeShipping1});

  Rates.fromJson(Map<String, dynamic> json) {
    freeShipping1 = json['free_shipping:1'] != null
        ? FreeShipping1.fromJson(json['free_shipping:1'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.freeShipping1 != null) {
      data['free_shipping:1'] = this.freeShipping1!.toJson();
    }
    return data;
  }
}

class FreeShipping1 {
  String? key;
  String? methodId;
  int? instanceId;
  String? label;
  String? cost;
  String? html;
  String? taxes;
  bool? chosenMethod;
  MetaData? metaData;

  FreeShipping1(
      {this.key,
      this.methodId,
      this.instanceId,
      this.label,
      this.cost,
      this.html,
      this.taxes,
      this.chosenMethod,
      this.metaData});

  FreeShipping1.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    methodId = json['method_id'];
    instanceId = json['instance_id'];
    label = json['label'];
    cost = json['cost'];
    html = json['html'];
    taxes = json['taxes'];
    chosenMethod = json['chosen_method'];
    metaData =
        json['meta_data'] != null ? MetaData.fromJson(json['meta_data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = this.key;
    data['method_id'] = this.methodId;
    data['instance_id'] = this.instanceId;
    data['label'] = this.label;
    data['cost'] = this.cost;
    data['html'] = this.html;
    data['taxes'] = this.taxes;
    data['chosen_method'] = this.chosenMethod;
    if (this.metaData != null) {
      data['meta_data'] = this.metaData!.toJson();
    }
    return data;
  }
}

class MetaData {
  String? items;

  MetaData({this.items});

  MetaData.fromJson(Map<String, dynamic> json) {
    items = json['items'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['items'] = this.items;
    return data;
  }
}

class ProductTotals {
  String? subtotal;
  String? subtotalTax;
  String? feeTotal;
  String? feeTax;
  String? discountTotal;
  String? discountTax;
  String? shippingTotal;
  String? shippingTax;
  String? total;
  String? totalTax;

  ProductTotals(
      {this.subtotal,
      this.subtotalTax,
      this.feeTotal,
      this.feeTax,
      this.discountTotal,
      this.discountTax,
      this.shippingTotal,
      this.shippingTax,
      this.total,
      this.totalTax});

  ProductTotals.fromJson(Map<String, dynamic> json) {
    subtotal = json['subtotal'];
    subtotalTax = json['subtotal_tax'];
    feeTotal = json['fee_total'];
    feeTax = json['fee_tax'];
    discountTotal = json['discount_total'];
    discountTax = json['discount_tax'];
    shippingTotal = json['shipping_total'];
    shippingTax = json['shipping_tax'];
    total = json['total'];
    totalTax = json['total_tax'];
  }

  ProductTotals.fromProduct({String? total}) {
    total = total;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subtotal'] = this.subtotal;
    data['subtotal_tax'] = this.subtotalTax;
    data['fee_total'] = this.feeTotal;
    data['fee_tax'] = this.feeTax;
    data['discount_total'] = this.discountTotal;
    data['discount_tax'] = this.discountTax;
    data['shipping_total'] = this.shippingTotal;
    data['shipping_tax'] = this.shippingTax;
    data['total'] = this.total;
    data['total_tax'] = this.totalTax;
    return data;
  }
}
