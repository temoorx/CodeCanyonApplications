/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V3
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2024-present initappz.
*/
import 'package:user/app/backend/api/api.dart';
import 'package:user/app/helper/shared_pref.dart';
import 'package:user/app/util/constant.dart';
import 'package:get/get.dart';

class TopProductsParse {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  TopProductsParse({required this.sharedPreferencesManager, required this.apiService});

  String getCurrenySymbol() {
    return sharedPreferencesManager.getString('currencySymbol') ?? AppConstants.defaultCurrencySymbol;
  }

  String getCurrenySide() {
    return sharedPreferencesManager.getString('currencySide') ?? AppConstants.defaultCurrencySide;
  }

  Future<Response> getHomeData(var body) async {
    return await apiService.postPublic(AppConstants.topProducts, body);
  }
}
