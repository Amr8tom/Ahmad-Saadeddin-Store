// ignore_for_file: prefer_collection_literals, unnecessary_this

class AllAttributesModel {
  int? id;
  String? name;
  String? slug;
  String? type;
  String? orderBy;
  bool? hasArchives;
  Links? lLinks;

  AllAttributesModel(
      {this.id,
      this.name,
      this.slug,
      this.type,
      this.orderBy,
      this.hasArchives,
      this.lLinks});

  AllAttributesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    type = json['type'];
    orderBy = json['order_by'];
    hasArchives = json['has_archives'];
    lLinks = json['_links'] != null ? Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['type'] = this.type;
    data['order_by'] = this.orderBy;
    data['has_archives'] = this.hasArchives;
    if (this.lLinks != null) {
      data['_links'] = this.lLinks!.toJson();
    }
    return data;
  }
}

class Links {
  List<Self>? self;
  List<Self>? collection;

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
  String? href;

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

class AttributesModel {
  int? id;
  String? name;
  String? slug;
  String? description;
  String? colorCode;
  int? menuOrder;
  int? count;
  Links? lLinks;
  bool? isSelected;

  AttributesModel({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.colorCode,
    this.menuOrder,
    this.count,
    this.lLinks,
    this.isSelected = false,
  });

  AttributesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    colorCode = json['color_code'];
    menuOrder = json['menu_order'];
    count = json['count'];
    lLinks = json['_links'] != null ? Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['color_code'] = this.colorCode;
    data['menu_order'] = this.menuOrder;
    data['count'] = this.count;
    if (this.lLinks != null) {
      data['_links'] = this.lLinks!.toJson();
    }
    return data;
  }
}
