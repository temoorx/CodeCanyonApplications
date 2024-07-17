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

class SingleProductReviewParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  SingleProductReviewParser({required this.sharedPreferencesManager, required this.apiService});

  Future<Response> getProductReviews(var body) async {
    var response = await apiService.postPrivate(AppConstants.getProductReviews, body, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  Future<Response> saveReview(var body) async {
    var response = await apiService.postPrivate(AppConstants.saveProductReviews, body, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  Future<Response> updateProductInfo(var body) async {
    var response = await apiService.postPrivate(AppConstants.updateProductInfo, body, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  String getUID() {
    return sharedPreferencesManager.getString('uid') ?? '';
  }
}
