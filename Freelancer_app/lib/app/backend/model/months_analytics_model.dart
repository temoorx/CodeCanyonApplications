/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V3
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2024-present initappz.
*/
class MonthAnalyticsModel {
  int? count;
  int? dayName;
  int? day;
  double? total;

  MonthAnalyticsModel({this.count, this.dayName, this.day, this.total});

  MonthAnalyticsModel.fromJson(Map<String, dynamic> json) {
    count = int.parse(json['count'].toString());
    dayName = int.parse(json['day_name'].toString());
    day = int.parse(json['day'].toString());
    total = double.parse(json['total'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['day_name'] = dayName;
    data['day'] = day;
    data['total'] = total;
    return data;
  }
}
