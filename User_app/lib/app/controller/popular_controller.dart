/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V3
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2024-present initappz.
*/
import 'package:get/get.dart';
import 'package:user/app/backend/parse/popular_parse.dart';
import 'package:user/app/controller/handyman_profile_controller.dart';
import 'package:user/app/helper/router.dart';

class PopularController extends GetxController implements GetxService {
  final PopularParser parser;

  bool apiCalled = false;
  PopularController({required this.parser});

  void onHandymanProfile(int id, String name) {
    Get.delete<HandymanProfileController>(force: true);
    Get.toNamed(AppRouter.getHandymanProfileRoute(), arguments: [id, name]);
  }
}
