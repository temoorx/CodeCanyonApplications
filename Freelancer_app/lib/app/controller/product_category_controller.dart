/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V3
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2024-present initappz.
*/
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:freelancer/app/backend/api/handler.dart';
import 'package:freelancer/app/backend/model/product_category_model.dart';
import 'package:freelancer/app/backend/parse/product_category_parse.dart';
import 'package:freelancer/app/controller/add_product_controller.dart';

class ProductCategoryController extends GetxController implements GetxService {
  final ProductCategoryParser parser;

  String selectedProductCateId = '';
  String selectedProductCateName = '';
  List<ProductCategoryModel> _categoriesList = <ProductCategoryModel>[];
  List<ProductCategoryModel> get categoriesList => _categoriesList;

  bool apiCalled = false;

  ProductCategoryController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    selectedProductCateId = Get.arguments[0];
    getMyProductCategory();
  }

  Future<void> getMyProductCategory() async {
    var response = await parser.getMyProductCategory();
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];
      _categoriesList = [];
      body.forEach((element) {
        ProductCategoryModel datas = ProductCategoryModel.fromJson(element);
        _categoriesList.add(datas);
      });
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void saveCate(String id) {
    selectedProductCateId = id;
    var name = _categoriesList.firstWhere((element) => element.id.toString() == id).name;
    selectedProductCateName = name as String;
    update();
  }

  void saveAndCloe() {
    Get.find<AddProductController>().onSaveProductCategory(selectedProductCateId, selectedProductCateName);
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }
}
