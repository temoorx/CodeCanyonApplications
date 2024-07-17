/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V3
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2024-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/app/backend/api/api.dart';
import 'package:user/app/helper/shared_pref.dart';
import 'package:user/app/util/constant.dart';

class BookingParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  BookingParser({required this.sharedPreferencesManager, required this.apiService});

  Future<Response> getSlotsForBookings(var body) async {
    debugPrint('---------');
    debugPrint(body.toString());
    debugPrint('---------');
    var response = await apiService.postPublic(AppConstants.getSlotsForBookings, body);
    return response;
  }

  String? isToken() {
    return sharedPreferencesManager.getString('token');
  }

  bool isLogin() {
    return sharedPreferencesManager.getString('uid') != '' && sharedPreferencesManager.getString('uid') != null ? true : false;
  }
}
