/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V3
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2024-present initappz.
*/
import 'package:get/get.dart';
import 'package:user/app/controller/account_controller.dart';
import 'package:user/app/helper/router.dart';
import 'package:user/app/util/toast.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if (response.statusCode == 401) {
      showToast('Session expired!'.tr);
      Get.find<AccountController>().cleanData();
      Get.toNamed(AppRouter.getLoginRoute(), arguments: ['account']);
    } else {
      showToast(response.statusText.toString().tr);
    }
  }
}
