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

class ProductDetailParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  ProductDetailParser({required this.sharedPreferencesManager, required this.apiService});

  Future<Response> getProductInfo(var body) async {
    var response = await apiService.postPublic(AppConstants.getProductInfo, body);
    return response;
  }

  Future<Response> getAllProductReviews(var body) async {
    var response = await apiService.postPublic(AppConstants.getAllProductReviews, body);
    return response;
  }

  String getCurrenySymbol() {
    return sharedPreferencesManager.getString('currencySymbol') ?? AppConstants.defaultCurrencySymbol;
  }

  String getCurrenySide() {
    return sharedPreferencesManager.getString('currencySide') ?? AppConstants.defaultCurrencySide;
  }
}
