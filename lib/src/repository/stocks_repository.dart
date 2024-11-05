import 'dart:convert';

import 'package:flutter_sample_app/src/data/network/base_api_service.dart';
import 'package:flutter_sample_app/src/data/network/network_api_services.dart';
import 'package:flutter_sample_app/src/models/stock_list_model.dart';
import 'package:flutter_sample_app/src/res/app_urls.dart';
import 'package:flutter_sample_app/src/utils/text_utils.dart';

import '../models/stock_detail_model.dart';

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

  Future<StocDetailkModel> fetchStocData(String symbolId) async {
    try {
      print('fetching stock detail - $symbolId');
      var searchString = TextUtils().trimAndUppercaseString(symbolId);
      print('${AppUrls.API_BASE_URL}/api/v1/quote?symbol=$searchString&token=${AppUrls.FINHUB_Key}');
      dynamic response = await _apiServices.getApiResponse(
        '${AppUrls.API_BASE_URL}/api/v1/quote?symbol=$searchString&token=${AppUrls.FINHUB_Key}');
      return response = StocDetailkModel.generateModel(searchString, response);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}