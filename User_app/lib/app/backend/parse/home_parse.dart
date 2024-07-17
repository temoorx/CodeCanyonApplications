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

class HomeParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  HomeParser({required this.sharedPreferencesManager, required this.apiService});

  Future<Response> getHomeData(var body) async {
    return await apiService.postPublic(AppConstants.getHomeData, body);
  }

  void saveCateID(String id) {
    sharedPreferencesManager.putString('id', id);
  }

  String getCurrenySymbol() {
    return sharedPreferencesManager.getString('currencySymbol') ?? AppConstants.defaultCurrencySymbol;
  }

  String getCurrenySide() {
    return sharedPreferencesManager.getString('currencySide') ?? AppConstants.defaultCurrencySide;
  }

  String getAddressName() {
    return sharedPreferencesManager.getString('address') ?? 'Home';
  }

  double getLat() {
    return sharedPreferencesManager.getDouble('lat') ?? 0.0;
  }

  double getLng() {
    return sharedPreferencesManager.getDouble('lng') ?? 0.0;
  }
}
