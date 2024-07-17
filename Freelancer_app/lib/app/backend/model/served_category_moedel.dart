/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V3
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2024-present initappz.
*/
class ServedCategoryModel {
  int? id;
  String? name;
  String? cover;
  bool? isChecked;
  String? extraField;
  int? status;

  ServedCategoryModel({this.id, this.name, this.cover, this.extraField, this.isChecked, this.status});

  ServedCategoryModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    name = json['name'];
    cover = json['cover'];
    isChecked = json['isChecked'];
    extraField = json['extra_field'];
    status = int.parse(json['status'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['cover'] = cover;
    data['isChecked'] = isChecked;
    data['extra_field'] = extraField;
    data['status'] = status;
    return data;
  }
}
