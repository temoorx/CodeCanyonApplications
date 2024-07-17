/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V3
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2024-present initappz.
*/
import 'package:get/get.dart';
import 'package:freelancer/app/backend/api/handler.dart';
import 'package:freelancer/app/backend/model/review_model.dart';
import 'package:freelancer/app/backend/parse/review_parse.dart';

class ReviewController extends GetxController implements GetxService {
  final ReviewParser parser;

  List<ReviewModel> _reviewList = <ReviewModel>[];
  List<ReviewModel> get reviewList => _reviewList;
  int freelancerId = 0;
  bool apiCalled = false;

  ReviewController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    getMyReviews();
  }

  Future<void> getMyReviews() async {
    var response = await parser.getMyReviews({"id": parser.getUID()});
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];

      _reviewList = [];
      body.forEach((element) {
        ReviewModel datas = ReviewModel.fromJson(element);
        _reviewList.add(datas);
      });
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }
}
