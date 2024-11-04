
class StockListModel {
  List<StockModel>? stockListModel = <StockModel>[];

  StockListModel({this.stockListModel});

  StockListModel.fromJson(List<dynamic> json) {
    if (json.isNotEmpty) {
      stockListModel = <StockModel>[];
      json.forEach((v) {
        stockListModel!.add(StockModel.fromJson(v as Map<String, dynamic>));
      });
    } else{
      print("test");
    }
  }
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (stockListModel != null) {
      data[''] = stockListModel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StockModel {
  String? company;
  String? description;
  String? initialPrice;
  String? price_2002;
  String? price_2007;
  String? symbol;

  StockModel({this.company, this.description, this.initialPrice, this.price_2002, this.price_2007, this.symbol});

 StockModel.fromJson(Map<String, dynamic> json){
    company = json['company'];
    description = json['description'];
    initialPrice = json['initial_price'].toString();
    price_2002 = json['price_2002'].toString();
    price_2007 = json['price_2007'].toString();
    symbol = json['symbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['company'] = company;
    data['description'] = description;
    data['initial_price'] = initialPrice;
    data['price_2002'] = price_2002;
    data['price_2007'] = price_2007;
    data['symbol'] = symbol;
    return data;
  }
}