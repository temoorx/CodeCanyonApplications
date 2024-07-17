/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V3
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2024-present initappz.
*/
import 'package:get/get.dart';
import 'package:user/app/controller/web_payment_controller.dart';

class WebPaymentBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(() => WebPaymentController(parser: Get.find()));
  }
}
