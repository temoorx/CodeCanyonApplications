/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V3
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2024-present initappz.
*/
import 'package:get/get.dart';
import 'package:freelancer/app/backend/api/api.dart';
import 'package:freelancer/app/helper/shared_pref.dart';
import 'package:freelancer/app/util/constant.dart';
import 'package:image_picker/image_picker.dart';

class AddProductParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  AddProductParser({required this.sharedPreferencesManager, required this.apiService});

  Future<Response> onSubmitProduct(dynamic body) async {
    var response = await apiService.postPrivate(AppConstants.productCreate, body, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  Future<Response> uploadImage(XFile data) async {
    return await apiService.uploadFiles(AppConstants.uploadImage, [MultipartBody('image', data)]);
  }

  Future<Response> getProductByID(var body) async {
    var response = await apiService.postPrivate(AppConstants.getProductByID, body, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  Future<Response> onUpdateProduct(var body) async {
    var response = await apiService.postPrivate(AppConstants.updateProduct, body, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  String getUID() {
    return sharedPreferencesManager.getString('uid') ?? '0';
  }
}
