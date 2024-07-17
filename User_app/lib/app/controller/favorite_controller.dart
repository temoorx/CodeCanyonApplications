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
import 'package:user/app/backend/api/handler.dart';
import 'package:user/app/backend/model/freelancer_model.dart';
import 'package:user/app/backend/parse/favorite_parse.dart';
import 'package:user/app/controller/handyman_profile_controller.dart';
import 'package:user/app/helper/router.dart';
import 'package:user/app/util/constant.dart';

class FavoriteController extends GetxController implements GetxService {
  final FavoriteParser parser;

  bool apiCalled = false;
  bool haveData = false;
  String distanceType = 'KM';
  String currencySide = AppConstants.defaultCurrencySide;
  String currencySymbol = AppConstants.defaultCurrencySymbol;

  List<FreelancerModel> _freelancerList = <FreelancerModel>[];
  List<FreelancerModel> get freelancerList => _freelancerList;
  FavoriteController({required this.parser});

  @override
  void onInit() {
    debugPrint('call api');
    super.onInit();
    currencySide = parser.getCurrencySide();
    currencySymbol = parser.getCurrencySymbol();
    getMyList();
  }

  Future<void> getMyList() async {
    var param = {"lat": parser.getLat(), "lng": parser.getLng(), "uid": parser.getUID()};
    Response response = await parser.getMyList(param);
    apiCalled = true;

    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      haveData = myMap['havedata'];
      distanceType = myMap['distanceType'];
      debugPrint(haveData.toString());
      var freelancers = myMap['data'];
      _freelancerList = [];
      freelancers.forEach((res) {
        FreelancerModel rests = FreelancerModel.fromJson(res);
        _freelancerList.add(rests);
      });
      debugPrint(_freelancerList.length.toString());
    } else {
      debugPrint(response.bodyString);
      ApiChecker.checkApi(response);
    }
    update();
  }

  void onHandymanProfile(int id, String name) {
    Get.delete<HandymanProfileController>(force: true);
    Get.toNamed(AppRouter.getHandymanProfileRoute(), arguments: [id, name]);
  }
}
