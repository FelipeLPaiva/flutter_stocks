import 'package:flutter/material.dart';
import 'package:flutter_sample_app/src/data/response/api_reponse.dart';
import 'package:flutter_sample_app/src/models/stock_list_model.dart';
import 'package:flutter_sample_app/src/repository/stocks_repository.dart';

class StocksViewModel with ChangeNotifier {
  final _stocksRepository = StocksRepository();

  ApiResponse<StockListModel> stocksList = ApiResponse.loading();

  setStocksList(ApiResponse<StockListModel> response){
    stocksList = response;
    notifyListeners();
  }
  
  void fetchStocksApi() async {
    setStocksList(ApiResponse.loading());
    _stocksRepository.fetchStockList().then((data) {
      print('before the data fetch is complete');
      setStocksList(ApiResponse.completed(data));
    }).onError((error, stackTrace){
      setStocksList(ApiResponse.error(error.toString()));
    });
  }

  void fetchStockDetail(String stockId) async {
    _stocksRepository.fetchStocData(stockId).then((data) {
      print('before the data fetch is complete');
      print(data);
    }).onError((error, stackTrace){
      print(ApiResponse.error(error.toString()));
    });
  }
}