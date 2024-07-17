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
import 'package:freelancer/app/backend/parse/firebase_parse.dart';
import 'package:freelancer/app/controller/login_controller.dart';
import 'package:freelancer/app/controller/register_controller.dart';

class FirebaseController extends GetxController implements GetxService {
  final FirebaseParser parser;
  String countryCode = '';
  String phoneNumber = '';
  String apiURL = '';
  bool haveClicked = false;
  String from = '';
  FirebaseController({required this.parser});

  @override
  void onInit() async {
    super.onInit();
    apiURL = parser.apiService.appBaseUrl;
    countryCode = Get.arguments[0];
    phoneNumber = Get.arguments[1];
    from = Get.arguments[2];
  }

  void onLogin() {
    if (from == 'register') {
      Get.find<RegisterController>().verifyPhoneFromFirebase();
    } else {
      Get.find<LoginController>().loginWithPhoneToken();
    }
    onBack();
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }
}
