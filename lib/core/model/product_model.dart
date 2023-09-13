// ignore_for_file: unnecessary_this, prefer_collection_literals

class ProductsModel {
  int ? id;
  String ? name;
  String ? slug;
  String ? permalink;
  String ? dateCreated;
  String ? dateCreatedGmt;
  String ? dateModified;
  String ? dateModifiedGmt;
  String ? type;
  String ? status;
  bool ? featured;
  bool ? isWishList;
  String ? catalogVisibility;
  String ? description;
  String ? shortDescription;
  String ? sku;
  String ? price;
  String ? regularPrice;
  String ? salePrice;
  dynamic dateOnSaleFrom;
  dynamic dateOnSaleFromGmt;
  dynamic dateOnSaleTo;
  dynamic dateOnSaleToGmt;
  bool ? onSale;
  bool ? purchasable;
  int ? totalSales;
  bool ? virtual;
  bool ? downloadable;
  List<dynamic> ? downloads;
  int ? downloadLimit;
  int ? downloadExpiry;
  String ? externalUrl;
  String ? buttonText;
  String ? taxStatus;
  String ? taxClass;
  bool ? manageStock;
  dynamic  stockQuantity;
  bool ?inStock;
  String ?backorders;
  bool ?backordersAllowed;
  bool ?backordered;
  bool ?soldIndividually;
  String ?weight;
  Dimensions ?dimensions;
  bool ?shippingRequired;
  bool ?shippingTaxable;
  String ?shippingClass;
  int ?shippingClassId;
  bool ?reviewsAllowed;
  String ?averageRating;
  int ?ratingCount;
  List<dynamic> ?upsellIds;
  List<dynamic> ?crossSellIds;
  int? parentId;
  String? purchaseNote;
  List<Categories> ?categories;
  List<Categories> ?tags;
  List<ProductImages> ?images;
  List<Attributes> ?attributes;
  List<dynamic> ? defaultAttributes;
  List<int> ? variations;
  List<dynamic> ? groupedProducts;
  int ? menuOrder;
  String ? priceHtml;
  List<int> ? relatedIds;
  List<MetaData> ? metaData;
  Links ? lLinks;

  ProductsModel(
      {this.id,
        this.name,
        this.slug,
        this.permalink,
        this.dateCreated,
        this.dateCreatedGmt,
        this.dateModified,
        this.dateModifiedGmt,
        this.type,
        this.status,
        this.featured,
        this.isWishList,
        this.catalogVisibility,
        this.description,
        this.shortDescription,
        this.sku,
        this.price,
        this.regularPrice,
        this.salePrice,
        this.dateOnSaleFrom,
        this.dateOnSaleFromGmt,
        this.dateOnSaleTo,
        this.dateOnSaleToGmt,
        this.onSale,
        this.purchasable,
        this.totalSales,
        this.virtual,
        this.downloadable,
        this.downloads,
        this.downloadLimit,
        this.downloadExpiry,
        this.externalUrl,
        this.buttonText,
        this.taxStatus,
        this.taxClass,
        this.manageStock,
        this.stockQuantity,
        this.inStock,
        this.backorders,
        this.backordersAllowed,
        this.backordered,
        this.soldIndividually,
        this.weight,
        this.dimensions,
        this.shippingRequired,
        this.shippingTaxable,
        this.shippingClass,
        this.shippingClassId,
        this.reviewsAllowed,
        this.averageRating,
        this.ratingCount,
        this.upsellIds,
        this.crossSellIds,
        this.parentId,
        this.purchaseNote,
        this.categories,
        this.tags,
        this.images,
        this.attributes,
        this.defaultAttributes,
        this.variations,
        this.groupedProducts,
        this.menuOrder,
        this.priceHtml,
        this.relatedIds,
        this.metaData,
        this.lLinks});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    permalink = json['permalink'];
    dateCreated = json['date_created'];
    dateCreatedGmt = json['date_created_gmt'];
    dateModified = json['date_modified'];
    dateModifiedGmt = json['date_modified_gmt'];
    type = json['type'];
    status = json['status'];
    featured = json['featured'];
    catalogVisibility = json['catalog_visibility'];
    description = json['description'];
    shortDescription = json['short_description'];
    sku = json['sku'];
    price = json['price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    dateOnSaleFrom = json['date_on_sale_from'];
    dateOnSaleFromGmt = json['date_on_sale_from_gmt'];
    dateOnSaleTo = json['date_on_sale_to'];
    dateOnSaleToGmt = json['date_on_sale_to_gmt'];
    onSale = json['on_sale'];
    purchasable = json['purchasable'];
    totalSales = json['total_sales'];
    virtual = json['virtual'];
    downloadable = json['downloadable'];
    // if (json['downloads'] != null) {
    //   downloads = List<Null>();
    //   json['downloads'].forEach((v) {
    //     downloads.add(Null.fromJson(v));
    //   });
    // }
    downloadLimit = json['download_limit'];
    downloadExpiry = json['download_expiry'];
    externalUrl = json['external_url'];
    buttonText = json['button_text'];
    taxStatus = json['tax_status'];
    taxClass = json['tax_class'];
    manageStock = json['manage_stock'];
    stockQuantity = json['stock_quantity'];
    inStock = json['in_stock'];
    backorders = json['backorders'];
    backordersAllowed = json['backorders_allowed'];
    backordered = json['backordered'];
    soldIndividually = json['sold_individually'];
    weight = json['weight'];
    dimensions = json['dimensions'] != null
        ? Dimensions.fromJson(json['dimensions'])
        : null;
    shippingRequired = json['shipping_required'];
    shippingTaxable = json['shipping_taxable'];
    shippingClass = json['shipping_class'];
    shippingClassId = json['shipping_class_id'];
    reviewsAllowed = json['reviews_allowed'];
    averageRating = json['average_rating'];
    ratingCount = json['rating_count'];
    // if (json['upsell_ids'] != null) {
    //   upsellIds = List<Null>();
    //   json['upsell_ids'].forEach((v) {
    //     upsellIds.add(Null.fromJson(v));
    //   });
    // }
    // if (json['cross_sell_ids'] != null) {
    //   crossSellIds = List<Null>();
    //   json['cross_sell_ids'].forEach((v) {
    //     crossSellIds.add(Null.fromJson(v));
    //   });
    // }
    parentId = json['parent_id'];
    purchaseNote = json['purchase_note'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
    if (json['tags'] != null) {
      tags =<Categories>[];
      json['tags'].forEach((v) {
        tags!.add(Categories.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = <ProductImages>[];
      json['images'].forEach((v) {
        images!.add(ProductImages.fromJson(v));
      });
    }
    if (json['attributes'] != null) {
      attributes = <Attributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(Attributes.fromJson(v));
      });
    }
    // if (json['default_attributes'] != null) {
    //   defaultAttributes = List<Null>();
    //   json['default_attributes'].forEach((v) {
    //     defaultAttributes.add(Null.fromJson(v));
    //   });
    // }
    if (json['variations'] != null) {
        variations = json['variations'].cast<int>();
    }
    if (json['grouped_products'] != null) {
      groupedProducts = [];
      json['grouped_products'].forEach((v) {
        groupedProducts!.add(v);
      });
    }
    menuOrder = json['menu_order'];
    priceHtml = json['price_html'];
    if (json['related_ids'] != null) {
      relatedIds = json['related_ids'].cast<int>();

      // relatedIds = List<Null>();
      // json['related_ids'].forEach((v) {
      //   relatedIds.add(Null.fromJson(v));
      // });
    }
    // if (json['meta_data'] != null) {
    //   metaData = <MetaData>[];
    //   json['meta_data'].forEach((v) {
    //     metaData!.add(MetaData.fromJson(v));
    //   });
    // }
    lLinks = json['_links'] != null ? Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['permalink'] = this.permalink;
    data['date_created'] = this.dateCreated;
    data['date_created_gmt'] = this.dateCreatedGmt;
    data['date_modified'] = this.dateModified;
    data['date_modified_gmt'] = this.dateModifiedGmt;
    data['type'] = this.type;
    data['status'] = this.status;
    data['featured'] = this.featured;
    data['catalog_visibility'] = this.catalogVisibility;
    data['description'] = this.description;
    data['short_description'] = this.shortDescription;
    data['sku'] = this.sku;
    data['price'] = this.price;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;
    data['date_on_sale_from'] = this.dateOnSaleFrom;
    data['date_on_sale_from_gmt'] = this.dateOnSaleFromGmt;
    data['date_on_sale_to'] = this.dateOnSaleTo;
    data['date_on_sale_to_gmt'] = this.dateOnSaleToGmt;
    data['on_sale'] = this.onSale;
    data['purchasable'] = this.purchasable;
    data['total_sales'] = this.totalSales;
    data['virtual'] = this.virtual;
    data['downloadable'] = this.downloadable;
    if (this.downloads != null) {
      data['downloads'] = this.downloads!.map((v) => v.toJson()).toList();
    }
    data['download_limit'] = this.downloadLimit;
    data['download_expiry'] = this.downloadExpiry;
    data['external_url'] = this.externalUrl;
    data['button_text'] = this.buttonText;
    data['tax_status'] = this.taxStatus;
    data['tax_class'] = this.taxClass;
    data['manage_stock'] = this.manageStock;
    data['stock_quantity'] = this.stockQuantity;
    data['in_stock'] = this.inStock;
    data['backorders'] = this.backorders;
    data['backorders_allowed'] = this.backordersAllowed;
    data['backordered'] = this.backordered;
    data['sold_individually'] = this.soldIndividually;
    data['weight'] = this.weight;
    if (this.dimensions != null) {
      data['dimensions'] = this.dimensions!.toJson();
    }
    data['shipping_required'] = this.shippingRequired;
    data['shipping_taxable'] = this.shippingTaxable;
    data['shipping_class'] = this.shippingClass;
    data['shipping_class_id'] = this.shippingClassId;
    data['reviews_allowed'] = this.reviewsAllowed;
    data['average_rating'] = this.averageRating;
    data['rating_count'] = this.ratingCount;
    if (this.upsellIds != null) {
      data['upsell_ids'] = this.upsellIds!.map((v) => v.toJson()).toList();
    }
    if (this.crossSellIds != null) {
      data['cross_sell_ids'] =
          this.crossSellIds!.map((v) => v.toJson()).toList();
    }
    data['parent_id'] = this.parentId;
    data['purchase_note'] = this.purchaseNote;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.tags != null) {
      data['tags'] = this.tags!.map((v) => v.toJson()).toList();
    }
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.map((v) => v.toJson()).toList();
    }
    if (this.defaultAttributes != null) {
      data['default_attributes'] =
          this.defaultAttributes!.map((v) => v.toJson()).toList();
    }
    data['variations'] = this.variations;

    if (this.groupedProducts != null) {
      data['grouped_products'] =
          this.groupedProducts!.map((v) => v.toJson()).toList();
    }
    data['menu_order'] = this.menuOrder;
    data['price_html'] = this.priceHtml;

    data['related_ids'] = this.relatedIds;

    // if (this.metaData != null) {
    //   data['meta_data'] = this.metaData!.map((v) => v.toJson()).toList();
    // }
    if (this.lLinks != null) {
      data['_links'] = this.lLinks!.toJson();
    }
    return data;
  }
}

class Dimensions {
  String? length;
  String? width;
  String? height;

  Dimensions({this.length, this.width, this.height});

  Dimensions.fromJson(Map<String, dynamic> json) {
    length = json['length'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['length'] = this.length;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}

class Categories {
  int ? id;
  String ? name;
  String ? slug;

  Categories({this.id, this.name, this.slug});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    return data;
  }
}

class ProductImages {
  int ? id;
  String ? dateCreated;
  String ? dateCreatedGmt;
  String ? dateModified;
  String ? dateModifiedGmt;
  String ? src;
  String ? name;
  String ? alt;
  int ? position;

  ProductImages(
      {this.id,
        this.dateCreated,
        this.dateCreatedGmt,
        this.dateModified,
        this.dateModifiedGmt,
        this.src,
        this.name,
        this.alt,
        this.position});

  ProductImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateCreated = json['date_created'];
    dateCreatedGmt = json['date_created_gmt'];
    dateModified = json['date_modified'];
    dateModifiedGmt = json['date_modified_gmt'];
    src = json['src'];
    name = json['name'];
    alt = json['alt'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['date_created'] = this.dateCreated;
    data['date_created_gmt'] = this.dateCreatedGmt;
    data['date_modified'] = this.dateModified;
    data['date_modified_gmt'] = this.dateModifiedGmt;
    data['src'] = this.src;
    data['name'] = this.name;
    data['alt'] = this.alt;
    data['position'] = this.position;
    return data;
  }
}
class Attributes {
  int ? id;
  String ? name;
  int ? position;
  bool ? visible;
  bool ? variation;
  List<String> ? options;

  Attributes(
      {this.id,
        this.name,
        this.position,
        this.visible,
        this.variation,
        this.options});

  Attributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    position = json['position'];
    visible = json['visible'];
    variation = json['variation'];
    options = json['options'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['position'] = this.position;
    data['visible'] = this.visible;
    data['variation'] = this.variation;
    data['options'] = this.options;
    return data;
  }
}
class MetaData {
  int ? id;
  String ? key;
  String ? value;

  MetaData({this.id, this.key, this.value});

  MetaData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}

class Links {
  List<Self>?self;
  List<Self>?collection;

  Links({this.self, this.collection});

  Links.fromJson(Map<String, dynamic> json) {
    if (json['self'] != null) {
      self = <Self>[];
      json['self'].forEach((v) {
        self!.add(Self.fromJson(v));
      });
    }
    if (json['collection'] != null) {
      collection = <Self>[];
      json['collection'].forEach((v) {
        collection!.add(Self.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.self != null) {
      data['self'] = this.self!.map((v) => v.toJson()).toList();
    }
    if (this.collection != null) {
      data['collection'] = this.collection!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Self {
  String ?href;

  Self({this.href});

  Self.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['href'] = this.href;
    return data;
  }
}
