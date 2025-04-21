
class SimpleViewForexData{
  final String currencyPair;
  final String bid;
  final String ask;
  final String day;
  final String spread;
  final String? bidHigh;
  final String? bidLow;
  final String? askHigh;
  final String? askLow;
  final String? last;
  final String? lastHigh;
  final String? lastLow;
  final DateTime time;

  SimpleViewForexData({
    required this.currencyPair,
    required this.bid,
    required this.ask,
    required this.day,
    required this.spread,
    this.askHigh,
    this.askLow,
    this.bidHigh,
    this.bidLow,
    this.last,
    this.lastHigh,
    this.lastLow,
    required this.time,
  });

  Map<String, dynamic> toJson() =>{
    'currencyPair': currencyPair,
    'bid': bid,
    'ask': ask,
    'day': day,
    'spread': spread,
    'askHigh': askHigh,
    'askLow': askLow,
    'bidLow': bidLow,
    'bidHigh': bidHigh,
    'last': last, 
    'lastHigh': lastHigh,
    'lastLow': lastLow,
    'time': time.toIso8601String(),
  };

  factory SimpleViewForexData.fromJson(Map<String, dynamic>json) => SimpleViewForexData(
    currencyPair: json['currencyPair'], 
    bid: json['bid'], 
    ask: json['ask'], 
    day: json['day'], 
    spread: json['spread'], 
    askHigh: json['askHigh'] ?? '-', 
    askLow: json['askLow']?? '-', 
    bidHigh: json['bidHigh']?? '-', 
    bidLow: json['bidLow']?? '-', 
    last: json['last']?? '-', 
    lastHigh: json['lastHigh']?? '-', 
    lastLow: json['lastLow']?? '-', 
    time: DateTime.parse(json['time'])
  );


  static List<SimpleViewForexData> defaultSimpleForexDataList = [
    SimpleViewForexData(
      currencyPair: 'AUDDKK', 
      bid: '4.45852', 
      ask: '4.46016', 
      day: '-0.06', 
      spread: '164', 
      time: DateTime.now().copyWith(hour: 20, minute: 6, second: 36),
    ),
    SimpleViewForexData(
      currencyPair: 'AUDCAD', 
      bid: '0.90858', 
      ask: '0.90868', 
      day: '0.06', 
      spread: '10', 
      time: DateTime.now().copyWith(hour: 10, minute: 15, second: 19),
    ),
    SimpleViewForexData(
      currencyPair: 'AUDHKD', 
      bid: '5.25944', 
      ask: '5.25953', 
      day: '0.59', 
      spread: '9', 
      time: DateTime.now().copyWith(hour: 03, minute: 45, second: 49),
    ),
    SimpleViewForexData(
      currencyPair: 'AUDCHF', 
      bid: '0.55510', 
      ask: '0.55519', 
      day: '-0.03', 
      spread: '9', 
      time: DateTime.now().copyWith(hour: 09, minute: 14, second: 55),
    )
  ];

}