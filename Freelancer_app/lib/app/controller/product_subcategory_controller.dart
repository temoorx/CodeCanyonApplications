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
import 'package:freelancer/app/backend/model/product_subcategory_model.dart';
import 'package:freelancer/app/backend/parse/product_subcategory_parse.dart';
import 'package:freelancer/app/controller/add_product_controller.dart';

class ProductSubCategoryController extends GetxController implements GetxService {
  final ProductSubCategoryParser parser;

  String selectedSubCateId = '';
  String selectedSubCateName = '';

  String cateId = '';
  List<ProductSubCategoryModel> _subCategoriesList = <ProductSubCategoryModel>[];
  List<ProductSubCategoryModel> get subCategoriesList => _subCategoriesList;
  ProductSubCategoryController({required this.parser});

  bool apiCalled = false;

  @override
  void onInit() {
    super.onInit();
    cateId = Get.arguments[0];
    selectedSubCateId = Get.arguments[1];
    getMyProductSubCategory();
  }

  Future<void> getMyProductSubCategory() async {
    var response = await parser.getMyProductSubCategory({"id": cateId});
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];
      _subCategoriesList = [];
      body.forEach((element) {
        ProductSubCategoryModel datas = ProductSubCategoryModel.fromJson(element);
        _subCategoriesList.add(datas);
      });
    } else {
      ApiChecker.checkApi(response);
    }
    debugPrint('call cate');
    update();
  }

  void saveCate(String id) {
    selectedSubCateId = id;
    var name = _subCategoriesList.firstWhere((element) => element.id.toString() == id).name;
    selectedSubCateName = name as String;
    update();
  }

  void saveAndCloe() {
    Get.find<AddProductController>().onSaveProductSubCategory(selectedSubCateId, selectedSubCateName);
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }
}
