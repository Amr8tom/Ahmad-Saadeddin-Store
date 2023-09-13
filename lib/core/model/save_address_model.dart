// ignore_for_file: prefer_collection_literals, unnecessary_this

class SaveAddressModel {
  bool? success;
  List<AddressData>? data;

  SaveAddressModel({this.success, this.data});

  SaveAddressModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <AddressData>[];
      json['data'].forEach((v) {
        data!.add(AddressData.fromJson(v));
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

class AddressData {
  String? id;
  String? userId;
  String? addressTitle;
  String? address;
  bool? isSelected;

  AddressData({this.id, this.userId, this.addressTitle, this.address,this.isSelected=false});

  AddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    addressTitle = json['address_title'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['address_title'] = this.addressTitle;
    data['address'] = this.address;
    return data;
  }
}
