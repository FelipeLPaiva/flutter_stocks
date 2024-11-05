import 'package:flutter/material.dart';
import 'package:flutter_sample_app/src/data/response/api_reponse.dart';
import 'package:flutter_sample_app/src/models/stock_detail_model.dart';
import 'package:flutter_sample_app/src/models/stock_list_model.dart';
import 'package:flutter_sample_app/src/repository/stocks_repository.dart';

class StocksItemViewModel with ChangeNotifier {
  final _stocksRepository = StocksRepository();

  ApiResponse<StocDetailkModel> stocksList = ApiResponse.loading();

  setStocksDetail(ApiResponse<StocDetailkModel> response){
    stocksList = response;
    notifyListeners();
  }

  void fetchStockDetail(String stockId) async {
    _stocksRepository.fetchStocData(stockId).then((data) {
      print('before the data fetch is complete');
      setStocksDetail(ApiResponse.completed(data));
      print(data);
    }).onError((error, stackTrace){
      print(ApiResponse.error(error.toString()));
      setStocksDetail(ApiResponse.error(error.toString()));
    });
  }
}