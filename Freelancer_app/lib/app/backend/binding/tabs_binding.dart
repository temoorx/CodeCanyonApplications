/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V3
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2024-present initappz.
*/
import 'package:get/get.dart';
import 'package:freelancer/app/controller/account_controller.dart';
import 'package:freelancer/app/controller/analyze_controller.dart';
import 'package:freelancer/app/controller/home_controller.dart';
import 'package:freelancer/app/controller/inbox_controller.dart';
import 'package:freelancer/app/controller/product_order_controller.dart';
import 'package:freelancer/app/controller/tabs_controller.dart';

class TabsBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(() => TabsController(parser: Get.find()), fenix: true);
    Get.lazyPut(() => ProductOrderController(parser: Get.find()), fenix: true);
    Get.lazyPut(() => HomeController(parser: Get.find()), fenix: true);
    Get.lazyPut(() => AnalyzeController(parser: Get.find()), fenix: true);
    Get.lazyPut(() => InboxController(parser: Get.find()), fenix: true);
    Get.lazyPut(() => AccountController(parser: Get.find()), fenix: true);
  }
}
