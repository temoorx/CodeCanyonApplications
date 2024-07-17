/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V3
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2024-present initappz.
*/
import 'package:freelancer/app/backend/api/api.dart';
import 'package:freelancer/app/helper/shared_pref.dart';
import 'package:freelancer/app/util/constant.dart';
import 'package:get/get.dart';

class AnalyzeParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  AnalyzeParser({required this.sharedPreferencesManager, required this.apiService});

  String getCurrenySymbol() {
    return sharedPreferencesManager.getString('currencySymbol') ?? AppConstants.defaultCurrencySymbol;
  }

  String getCurrenySide() {
    return sharedPreferencesManager.getString('currencySide') ?? AppConstants.defaultCurrencySide;
  }

  String getUID() {
    return sharedPreferencesManager.getString('uid') ?? '';
  }

  Future<Response> getStats(var month, var year) async {
    return await apiService.postPrivate(AppConstants.getStats, {'id': getUID(), "month": month, "year": year}, sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> getMonthsStatus(var year) async {
    return await apiService.postPrivate(AppConstants.getMonthsStats, {'id': getUID(), "year": year}, sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> getAllStats() async {
    return await apiService.postPrivate(AppConstants.getAllStats, {'id': getUID()}, sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> getStatsProducts(var month, var year) async {
    return await apiService.postPrivate(AppConstants.getStatsProducts, {'id': getUID(), "month": month, "year": year}, sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> getMonthsStatusProducts(var year) async {
    return await apiService.postPrivate(AppConstants.getMonthsStatsProducts, {'id': getUID(), "year": year}, sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> getAllStatsProducts() async {
    return await apiService.postPrivate(AppConstants.getAllStatsProducts, {'id': getUID()}, sharedPreferencesManager.getString('token') ?? '');
  }
}
