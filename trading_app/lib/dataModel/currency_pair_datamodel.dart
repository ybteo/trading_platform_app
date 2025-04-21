
class CurrencyPairData{
  final String currencyPair;
  final String change;
  final String buy;
  final String sell;
  final String high;
  final String low;
  final DateTime time;
  final String spread;
  final String day;


  CurrencyPairData({
    required this.currencyPair,
    required this.change,
    required this.buy,
    required this.sell,
    required this.high,
    required this.low,
    required this.time,
    required this.spread,
    required this.day,
  });

  Map<String, dynamic> toJson() =>{
    'currencyPair': currencyPair,
    'change': change,
    'buy': buy,
    'sell': sell,
    'high': high,
    'low': low,
    'time': time.toIso8601String(),
    'spread': spread,
  };

  factory CurrencyPairData.fromJson(Map<String, dynamic>json) => CurrencyPairData(
    currencyPair: json['currencyPair'], 
    change: json['change'], 
    buy: json['buy'], 
    sell: json['sell'], 
    high: json['high'], 
    low: json['low'], 
    time: DateTime.parse(json['time']),
    spread: json['spread'],
    day: json['day'],
  );



//default display
  static List<CurrencyPairData> advancForexDataList = [
    CurrencyPairData(
      currencyPair: 'AUDCAD', 
      change: '+53', 
      buy: '0.90867', 
      sell: '0.90857', 
      high: '0.91016', 
      low: '0.90767', 
      time: DateTime.now().copyWith(hour: 09, minute: 59, second: 44),
      spread: '0.06',
      day: '10',
    ),
    
    CurrencyPairData(
      currencyPair: 'AUDCHF', 
      change: '-12', 
      buy: '0.55522', 
      sell: '0.55512', 
      high: '0.55630', 
      low: '0.55397', 
      time: DateTime.now().copyWith(hour: 9, minute: 59, second: 45),
      spread: '-0.02',
      day: '10',
    ),

    CurrencyPairData(
      currencyPair: 'AUDDKK', 
      change: '-280', 
      buy: '4.46016', 
      sell: '4.45852', 
      high: '4.47500', 
      low: '4.45602', 
      time: DateTime.now().copyWith(hour: 20, minute: 6, second: 36),
      spread: '-0.06',
      day: '164',
    ),

    CurrencyPairData(
      currencyPair: 'AUDHKD', 
      change: '+3078', 
      buy: '5.25953', 
      sell: '5.25944', 
      high: '5.26202', 
      low: '5.22274', 
      time: DateTime.now().copyWith(hour: 8, minute: 28, second: 9),
      spread: '0.59',
      day: '9',
    ),
  ];
  
}