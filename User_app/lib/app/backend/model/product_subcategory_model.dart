/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V3
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2024-present initappz.
*/
class ProductSubCategoryModel {
  int? id;
  String? name;
  String? cover;
  int? cateId;
  String? extraField;
  int? status;

  ProductSubCategoryModel({this.id, this.name, this.cover, this.cateId, this.extraField, this.status});

  ProductSubCategoryModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    name = json['name'];
    cover = json['cover'];
    cateId = int.parse(json['cate_id'].toString());
    extraField = json['extra_field'];
    status = int.parse(json['status'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['cover'] = cover;
    data['cate_id'] = cateId;
    data['extra_field'] = extraField;
    data['status'] = status;
    return data;
  }
}
