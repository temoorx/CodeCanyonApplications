/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V3
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2024-present initappz.
*/
import 'package:get/get.dart';
import 'package:freelancer/app/backend/api/api.dart';
import 'package:freelancer/app/helper/shared_pref.dart';
import 'package:freelancer/app/util/constant.dart';

class ServedCategoryParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  ServedCategoryParser({required this.sharedPreferencesManager, required this.apiService});

  Future<Response> getAllServedCategory() async {
    var response = await apiService.getPrivate(AppConstants.getAllServedCategory, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  Future<Response> onUpdateCate(var body) async {
    var response = await apiService.postPrivate(AppConstants.updateFreelancerInfo, body, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  String getUID() {
    return sharedPreferencesManager.getString('uid') ?? '';
  }

  String getFreelancerId() {
    return sharedPreferencesManager.getString('freelancerId') ?? '';
  }
}
