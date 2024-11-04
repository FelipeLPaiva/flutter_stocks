import 'package:flutter_sample_app/src/data/network/base_api_service.dart';
import 'package:flutter_sample_app/src/data/network/network_api_services.dart';
import 'package:flutter_sample_app/src/models/stock_list_model.dart';
import 'package:flutter_sample_app/src/res/app_urls.dart';

class StocksRepository {
  final BaseApiServices _apiServices = NetworkApiServices();
  Future<StockListModel> fetchStockList() async {
    try {
      print('fetching stocks');
      dynamic response = await _apiServices.getApiResponse(AppUrls.stocksBaseUrl);
      return response = StockListModel.fromJson(response);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}