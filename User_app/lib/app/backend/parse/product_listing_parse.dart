/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V3
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2024-present initappz.
*/
import 'package:get/get.dart';
import 'package:user/app/backend/api/api.dart';
import 'package:user/app/helper/shared_pref.dart';
import 'package:user/app/util/constant.dart';

class ProductListingParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  ProductListingParser({required this.sharedPreferencesManager, required this.apiService});

  Future<Response> productSubCategorybyCate(var body) async {
    var response = await apiService.postPublic(AppConstants.productSubCategorybyCate, body);
    return response;
  }

  Future<Response> getProductByCateandSubCate(var body) async {
    var response = await apiService.postPublic(AppConstants.getProductByCateandSubCate, body);
    return response;
  }

  bool isLogin() {
    return sharedPreferencesManager.getString('uid') != '' && sharedPreferencesManager.getString('uid') != null ? true : false;
  }

  String getCurrenySymbol() {
    return sharedPreferencesManager.getString('currencySymbol') ?? AppConstants.defaultCurrencySymbol;
  }

  String getCurrenySide() {
    return sharedPreferencesManager.getString('currencySide') ?? AppConstants.defaultCurrencySide;
  }
}
