/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V3
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2024-present initappz.
*/
import 'package:get/get.dart';
import 'package:user/app/backend/parse/popular_product_parse.dart';

class PopularProductController extends GetxController implements GetxService {
  final PopularProductParser parser;

  bool apiCalled = false;
  PopularProductController({required this.parser});
}
