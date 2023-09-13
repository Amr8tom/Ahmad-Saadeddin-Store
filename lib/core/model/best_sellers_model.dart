// ignore_for_file: prefer_collection_literals, unnecessary_this

class BestSellersModel {
  bool ?success;
  List<BestSellerData> ?data;

  BestSellersModel({this.success, this.data});

  BestSellersModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <BestSellerData>[];
      json['data'].forEach((v) {
        data!.add(BestSellerData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BestSellerData {
  String? title;
  String? description;
  String? image;

  BestSellerData({this.title, this.description, this.image});

  BestSellerData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    return data;
  }
}
