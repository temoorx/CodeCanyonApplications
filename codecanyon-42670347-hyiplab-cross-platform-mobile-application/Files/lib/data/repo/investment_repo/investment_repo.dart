import 'package:hyip_lab/core/utils/url.dart';
import 'package:hyip_lab/data/services/api_service.dart';

import '../../../core/utils/method.dart';

class InvestmentRepo{

  ApiClient apiClient;
  InvestmentRepo({required this.apiClient});

  Future<dynamic>getInvestmentData(String type,int page)async{
    String url='${UrlContainer.baseUrl}${UrlContainer.investUrl}?type=$type&page=$page';
    final response=await apiClient.request(url,Method.getMethod,null,passHeader: true);
    return response;
  }


  Future<dynamic>updateInvestmentCapitalType(String selectedInvestmentCapital,String investmentId)async{
    String url='${UrlContainer.baseUrl}${UrlContainer.manageCapital}';
    final params = {
      "invest_id" : investmentId,
      "capital" : selectedInvestmentCapital.toLowerCase().replaceAll(" ", "_")
    };
    final response=await apiClient.request(url,Method.postMethod,params,passHeader: true);
    return response;
  }

}