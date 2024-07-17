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
import 'package:get/get.dart';
import 'package:user/app/util/constant.dart';

class ForgotPasswordParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  ForgotPasswordParser({required this.sharedPreferencesManager, required this.apiService});

  Future<Response> resetWithOTPMail(dynamic param) async {
    return await apiService.postPublic(AppConstants.resetWithEmail, param);
  }

  Future<Response> verifyOTP(dynamic param) async {
    return await apiService.postPublic(AppConstants.verifyOTPForReset, param);
  }

  Future<Response> updatePassword(var param, String token) async {
    return await apiService.postPrivate(AppConstants.updatePasswordWithToken, param, token);
  }
}
