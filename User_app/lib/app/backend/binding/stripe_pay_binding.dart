/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V3
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2024-present initappz.
*/
import 'package:get/get.dart';
import 'package:user/app/controller/stripe_pay_controller.dart';

class StripePayBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(() => StripePayController(parser: Get.find()));
  }
}
