/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V3
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2024-present initappz.
*/
class ServiceModel {
  int? id;
  int? uid;
  int? cateId;
  String? name;
  String? cover;
  double? duration;
  double? price;
  double? off;
  double? discount;
  String? descriptions;
  String? images;
  String? extraField;
  int? status;
  late bool? isChecked;
  WebCatesData? webCatesData;

  ServiceModel(
      {this.id,
      this.uid,
      this.cateId,
      this.name,
      this.cover,
      this.duration,
      this.price,
      this.off,
      this.discount,
      this.descriptions,
      this.images,
      this.extraField,
      this.status,
      this.webCatesData,
      this.isChecked = false});

  ServiceModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    uid = int.parse(json['uid'].toString());
    cateId = int.parse(json['cate_id'].toString());
    name = json['name'];
    cover = json['cover'];
    duration = double.parse(json['duration'].toString());
    price = double.parse(json['price'].toString());
    off = double.parse(json['off'].toString());
    discount = double.parse(json['discount'].toString());
    descriptions = json['descriptions'];
    images = json['images'];
    extraField = json['extra_field'];
    status = int.parse(json['status'].toString());
    isChecked = json['isChecked'];
    webCatesData = json['web_cates_data'] != null ? WebCatesData.fromJson(json['web_cates_data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['cate_id'] = cateId;
    data['name'] = name;
    data['cover'] = cover;
    data['duration'] = duration;
    data['price'] = price;
    data['off'] = off;
    data['discount'] = discount;
    data['descriptions'] = descriptions;
    data['images'] = images;
    data['extra_field'] = extraField;
    data['status'] = status;
    data['isChecked'] = isChecked;
    if (webCatesData != null) {
      data['web_cates_data'] = webCatesData!.toJson();
    }
    return data;
  }
}

class WebCatesData {
  int? id;
  String? name;
  String? cover;
  String? extraField;
  int? status;

  WebCatesData({this.id, this.name, this.cover, this.extraField, this.status});

  WebCatesData.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    name = json['name'];
    cover = json['cover'];
    extraField = json['extra_field'];
    status = int.parse(json['status'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['cover'] = cover;
    data['extra_field'] = extraField;
    data['status'] = status;
    return data;
  }
}
