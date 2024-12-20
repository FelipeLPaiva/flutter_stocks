import 'package:equatable/equatable.dart';

enum BullBearCondition {
  bull,
  bear,
  neutral,
}

class StockDetailModel extends Equatable {
  final String tickerSymbol;
  final double currentPrice;
  final double highPriceDay;
  final double lowPriceDay;
  final double openPriceDay;
  final double previousClosePrice;
  final BullBearCondition bullBearCondition;
  final int requestUnixTimestampSeconds;
  final DateTime requestDateTime;

  StockDetailModel({
    required this.tickerSymbol,
    required this.currentPrice,
    required this.highPriceDay,
    required this.lowPriceDay,
    required this.openPriceDay,
    required this.previousClosePrice,
    required this.bullBearCondition,
    required this.requestUnixTimestampSeconds,
    required this.requestDateTime,
  });

  @override
  List<Object> get props => [
        tickerSymbol,
        currentPrice,
        highPriceDay,
        lowPriceDay,
        openPriceDay,
        previousClosePrice,
        bullBearCondition,
        requestUnixTimestampSeconds,
        requestDateTime,
      ];

  static StockDetailModel generateModel(String tickerSymbol, dynamic json) {
    return StockDetailModel(
      tickerSymbol: tickerSymbol,
      currentPrice: json['c'].toDouble() as double,
      highPriceDay: json['h'].toDouble() as double,
      lowPriceDay: json['l'].toDouble() as double,
      openPriceDay: json['o'].toDouble() as double,
      previousClosePrice: json['pc'].toDouble() as double,
      bullBearCondition: _mapBullBearStockCondition(
          json['c'].toDouble() as double, json['pc'].toDouble() as double),
      requestUnixTimestampSeconds: json['t'].toInt() as int,
      requestDateTime: _convertUnixTimestampSecondsToDateTime(
          unixTimestampSeconds: json['t'].toInt() as int),
    );
  }

  static DateTime _convertUnixTimestampSecondsToDateTime(
      {required int unixTimestampSeconds}) {
    return DateTime.fromMillisecondsSinceEpoch(unixTimestampSeconds * 1000);
  }

  static BullBearCondition _mapBullBearStockCondition(
      double currentPrice, double previousClosePrice) {
    BullBearCondition stockCondition;
    if (currentPrice > previousClosePrice) {
      stockCondition = BullBearCondition.bull;
    } else if (currentPrice < previousClosePrice) {
      stockCondition = BullBearCondition.bear;
    } else {
      stockCondition = BullBearCondition.neutral;
    }
    return stockCondition;
  }
}