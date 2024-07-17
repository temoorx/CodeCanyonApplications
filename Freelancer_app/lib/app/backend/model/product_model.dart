/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V3
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2024-present initappz.
*/
class ProductModel {
  int? id;
  int? freelacerId;
  String? cover;
  String? name;
  String? images;
  double? originalPrice;
  double? sellPrice;
  double? discount;
  int? cateId;
  int? subCateId;
  int? inHome;
  int? isSingle;
  int? haveGram;
  String? gram;
  int? haveKg;
  String? kg;
  int? havePcs;
  String? pcs;
  int? haveLiter;
  String? liter;
  int? haveMl;
  String? ml;
  String? descriptions;
  String? keyFeatures;
  String? disclaimer;
  String? expDate;
  int? inOffer;
  int? inStock;
  double? rating;
  int? totalRating;
  int? status;
  String? extraField;
  late int quantity;

  ProductModel({
    this.id,
    this.freelacerId,
    this.cover,
    this.name,
    this.images,
    this.originalPrice,
    this.sellPrice,
    this.discount,
    this.cateId,
    this.subCateId,
    this.inHome,
    this.isSingle,
    this.haveGram,
    this.gram,
    this.haveKg,
    this.kg,
    this.havePcs,
    this.pcs,
    this.haveLiter,
    this.liter,
    this.haveMl,
    this.ml,
    this.descriptions,
    this.keyFeatures,
    this.disclaimer,
    this.expDate,
    this.inOffer,
    this.inStock,
    this.rating,
    this.totalRating,
    this.status,
    this.extraField,
    this.quantity = 0,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    freelacerId = int.parse(json['freelacer_id'].toString());
    cover = json['cover'];
    name = json['name'];
    images = json['images'];
    originalPrice = double.parse(json['original_price'].toString());
    sellPrice = double.parse(json['sell_price'].toString());
    discount = double.parse(json['discount'].toString());
    cateId = int.parse(json['cate_id'].toString());
    subCateId = json['sub_cate_id'] != null && json['sub_cate_id'] != '' ? int.parse(json['sub_cate_id'].toString()) : 0;
    inHome = int.parse(json['in_home'].toString());
    isSingle = int.parse(json['is_single'].toString());
    haveGram = int.parse(json['have_gram'].toString());
    gram = json['gram'];
    haveKg = int.parse(json['have_kg'].toString());
    kg = json['kg'];
    havePcs = int.parse(json['have_pcs'].toString());
    pcs = json['pcs'];
    haveLiter = int.parse(json['have_liter'].toString());
    liter = json['liter'];
    haveMl = int.parse(json['have_liter'].toString());
    ml = json['ml'];
    descriptions = json['descriptions'];
    keyFeatures = json['key_features'];
    disclaimer = json['disclaimer'];
    expDate = json['exp_date'];
    inOffer = int.parse(json['in_offer'].toString());
    inStock = int.parse(json['in_stock'].toString());
    rating = double.parse(json['rating'].toString());
    totalRating = int.parse(json['total_rating'].toString());
    status = int.parse(json['status'].toString());
    extraField = json['extra_field'];
    if (json['quantity'] != null && json['quantity'] != 0 && json['quantity'] != '') {
      quantity = json['quantity'];
    } else {
      quantity = 0;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['freelacer_id'] = freelacerId;
    data['cover'] = cover;
    data['name'] = name;
    data['images'] = images;
    data['original_price'] = originalPrice;
    data['sell_price'] = sellPrice;
    data['discount'] = discount;
    data['cate_id'] = cateId;
    data['sub_cate_id'] = subCateId;
    data['in_home'] = inHome;
    data['is_single'] = isSingle;
    data['have_gram'] = haveGram;
    data['gram'] = gram;
    data['have_kg'] = haveKg;
    data['kg'] = kg;
    data['have_pcs'] = havePcs;
    data['pcs'] = pcs;
    data['have_liter'] = haveLiter;
    data['liter'] = liter;
    data['have_ml'] = haveMl;
    data['ml'] = ml;
    data['descriptions'] = descriptions;
    data['key_features'] = keyFeatures;
    data['disclaimer'] = disclaimer;
    data['exp_date'] = expDate;
    data['in_offer'] = inOffer;
    data['in_stock'] = inStock;
    data['rating'] = rating;
    data['total_rating'] = totalRating;
    data['status'] = status;
    data['extra_field'] = extraField;
    data['quantity'] = quantity;
    return data;
  }
}

class CateData {
  int? id;
  String? name;
  String? cover;
  String? extraField;
  int? status;

  CateData({this.id, this.name, this.cover, this.extraField, this.status});

  CateData.fromJson(Map<String, dynamic> json) {
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

class SubCateData {
  int? id;
  String? name;
  String? cover;
  int? cateId;
  String? extraField;
  int? status;

  SubCateData({this.id, this.name, this.cover, this.cateId, this.extraField, this.status});

  SubCateData.fromJson(Map<String, dynamic> json) {
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
