import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'package:trading_app/const/constant.dart';
import 'package:trading_app/const/textstyle.dart';
import 'package:trading_app/pages/subpages/indicatorsFromChartPage.dart';
import 'package:trading_app/pages/subpages/objectFromChartPage.dart';

class ChartsPage extends StatefulWidget {
  const ChartsPage({super.key});

  @override
  State<ChartsPage> createState() => _ChartsPageState();
}

class _ChartsPageState extends State<ChartsPage> {
  List<CandleData> forexData = [];
  bool isLoading = true;
  String message = '';
  String selectedTimeFrame = 'M1';
  OverlayEntry? overlayEntry;
  bool isOverlayShown = false;
  final String apiKey = dotenv.env['6WQUG6UD4KDW7HL1'] ?? '';

  // GlobalKey to access the RenderBox of the leading widget
  final GlobalKey _leadingKey = GlobalKey();

  String currencyPairName = ''; // display the name of currency pair

  @override
  void initState() {
    super.initState();
    fetchForexData(timeframe: selectedTimeFrame);
  }

 /*  Future<void> fetchForexData() async {
   
    String apiUrl = 'https://www.alphavantage.co/query?function=FX_DAILY&from_symbol=EUR&to_symbol=USD&apikey=apiKey';
    // String apiUrl = 'https://www.alphavantage.co/query?function=$function&from_symbol=EUR&to_symbol=USD&apikey=$apiKey$interval';
    
    try {
      final response = await http.get(Uri.parse(apiUrl));
      print('Response Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        

        if(data.containsKey("Meta Data")){
          currencyPairName = '${data["Meta Data"]["2. From Symbol"]}/${data["Meta Data"]["3. To Symbol"]}';
        }

        if (data.containsKey("Time Series FX (Daily)")) {
          List<CandleData> tempData = [];
          final timeSeries = data["Time Series FX (Daily)"];

          timeSeries.forEach((time, values) {
            if (values is Map<String, dynamic>) {
              double open = double.tryParse(values["1. open"] ?? '0.0') ?? 0.0;
              double high = double.tryParse(values["2. high"] ?? '0.0') ?? 0.0;
              double low = double.tryParse(values["3. low"] ?? '0.0') ?? 0.0;
              double close = double.tryParse(values["4. close"] ?? '0.0') ?? 0.0;

              tempData.add(CandleData(time, open, high, low, close));
            }
          });

          setState(() {
            forexData = tempData.reversed.toList();
            isLoading = false;
          });
        } else {
          setState(() {
            message = "Invalid API response";
            isLoading = false;
          });
        }
      } else {
        setState(() {
          message = "Error fetching data";
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          message = "Failed to load data: $e";
          isLoading = false;
        });
      }
    }
  } */
 Future<void> fetchForexData({required String timeframe}) async {
    setState(() {
      isLoading = true;
      message = " ";
    });

    String function;
    String interval = "";
    Map<String, String> intervalMapping = {
      "M2": "M1", "M3": "M1", "M4": "M1", "M6": "M5", "M10":"M5",
      "M12": "M5", "M20": "M15", "H2": "H1", "H3": "H1", "H6": "H4",
      "H8": "H4", "H12": "H4"
    };

    String mappedTimeframe = intervalMapping[timeframe] ?? timeframe;

    if(["M1", "M5", "M15", "M30", "H1", "H4", "D1", "W1", "MN"].contains(mappedTimeframe)){
      function = 'FX_INTRADAY';
      interval = "&interval=${mappedTimeframe.toLowerCase()}";
    }else if(mappedTimeframe == 'D1'){
      function = 'FX_DAILY';
    }else if(mappedTimeframe == 'W1'){
      function = 'FX_WEEKLY';
    }else if(mappedTimeframe == 'MN'){
      function = 'FX_MONTHLY';
    }else{
      function = "FX_DAILY";
    }

    String apiUrl = 'https://www.alphavantage.co/query?function=$function&from_symbol=EUR&to_symbol=USD&apikey=$apiKey$interval';
      // Response Code: 200
      // I/flutter (22521): Response Body: {
      // I/flutter (22521):     "Error Message": "the parameter apikey is invalid or missing. Please claim your free API key on (https://www.alphavantage.co/support/#api-key). It should take less than 20 seconds."
      // I/flutter (22521): }
      // FX_DAILY is a free endpoint. FX_INTRADAY function requires a premium subscription

    try {
      final response = await http.get(Uri.parse(apiUrl));
      print('Response Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        String key = function == "FX_INTRADAY" ? "Time Series FX (${mappedTimeframe.toUpperCase()})"
                                  : "Time Series FX (Daily)";

        if(data.containsKey("Meta Data") && data.containsKey(key)){
          currencyPairName = '${data["Meta Data"]["2. From Symbol"]}/${data["Meta Data"]["3. To Symbol"]}'; 
        }

        if(data.containsKey(key)){
          List<CandleData> tempData = [];
          final timeSeries = data[key];
          timeSeries.forEach((time, values){
            if(values is Map<String, dynamic>){
              double open = double.tryParse(values["1. open"] ?? '0.0') ?? 0.0;
              double high = double.tryParse(values["2. high"] ?? '0.0') ?? 0.0;
              double low = double.tryParse(values["3. low"] ?? 0.0) ?? 0.0;
              double close = double.tryParse(values["4. close"] ?? 0.0) ?? 0.0;
              tempData.add(CandleData(time, open, high, low, close));
            }
          }); 

          setState(() {
            forexData = tempData.reversed.toList();
            isLoading = false;
          });

        }else{
          setState(() {
            message = 'Invalid API response';
            isLoading = false;
          });
        }

      }else{
        setState(() {
          message = 'Error fetching data';
          isLoading = false;
        });
      }
    }catch(e){
      if(mounted){
        setState(() {
          message = 'Failed to load data: $e';
          isLoading = false;
        });
      }
    }
 }




  void showHorizontalMenu(BuildContext context, Offset position) {
    hideOverlayMenu();

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx + 45, // Expand to the right
        top: position.dy + 10, // Drag from the top
        child: Material(
          color: Colors.transparent,
          child: Container(
            height: 30,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(color: Colors.black26, blurRadius: 5),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                timeFrameButton('M1'),
                timeFrameButton('M5'),
                timeFrameButton('M15'),
                timeFrameButton('M30'),
                timeFrameButton('H1'),
                timeFrameButton('H4'),
                timeFrameButton('D1'),
                timeFrameButton('W1'),
                timeFrameButton('MN'),
                IconButton(
                  alignment: Alignment.topCenter,
                  onPressed: (){
                    //need to pop out filter table for timeframe
                    showFilterTable(context);
                  }, 
                  icon: const Icon(Icons.more_horiz)//need to align at middle
                ),

              ], 
            ),
          ),
          
        ),
      ),
    );

    // Ensure the context is valid before inserting the overlay
    if (mounted && overlayEntry != null) {
      Overlay.of(context).insert(overlayEntry!);
      isOverlayShown = true;
    }
  }

  void hideOverlayMenu() {
    if (overlayEntry != null) {
      overlayEntry!.remove();
      overlayEntry = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,

        leading: GestureDetector(
          key: _leadingKey, // Assign the GlobalKey to the leading widget
          onTapDown: (TapDownDetails details) {
            if (mounted) {
              final RenderBox renderBox = _leadingKey.currentContext?.findRenderObject() as RenderBox;
              final Offset offset = renderBox.localToGlobal(Offset.zero);
              showHorizontalMenu(context, offset);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(selectedTimeFrame, style: bodySBold.copyWith(color: blue.shade400, fontSize: 14.5)), // selection for time
              ],
            ),
          ),
        ),
        
        
        title: Row(
          children: [
            const SizedBox(width: 55),
            IconButton(
              onPressed: () {


              },
              icon: Icon(Icons.add, color: blue.shade300, size: 20),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const IndicatorPage(),
                  ),
                );
              },
              icon: Icon(Icons.mode_edit, color: blue.shade300, size: 20),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ObjectPage(),
                  ),
                );
              },
              icon: Icon(Icons.bubble_chart, color: blue.shade300, size: 20),
            ),
          ],
        ),

        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.access_time, color: blue.shade300, size: 20),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.local_activity_sharp, color: blue.shade300, size: 20),
          ),
        ],

      ),


      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : forexData.isEmpty
                ? Text(message)
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(currencyPairName, style: bodyXSBold),
                    ),
                    Expanded(
                      child: SfCartesianChart(
                          primaryXAxis: CategoryAxis(),
                          primaryYAxis: NumericAxis(),
                          zoomPanBehavior: ZoomPanBehavior(
                            enablePinching: true,
                            enablePanning: true,
                            enableDoubleTapZooming: true,
                            enableSelectionZooming: true,
                          ),
                          series: <CandleSeries<CandleData, String>>[
                            CandleSeries<CandleData, String>(
                              dataSource: forexData,
                              xValueMapper: (CandleData data, _) => data.date,
                              lowValueMapper: (CandleData data, _) => data.low,
                              highValueMapper: (CandleData data, _) => data.high,
                              openValueMapper: (CandleData data, _) => data.open,
                              closeValueMapper: (CandleData data, _) => data.close,
                              enableSolidCandles: true,
                              bullColor: Colors.green,
                              bearColor: Colors.red,
                            ),
                          ],
                        ),
                    ),
                  ],
                ),
      ),
    );
  }

  Widget timeFrameButton(String title) {
    return GestureDetector(
      onTap: () {
        if(mounted){
          setState(() {
          selectedTimeFrame = title;
        });
        hideOverlayMenu();
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Text(
          title,
          style: bodyMBold.copyWith(color: title == selectedTimeFrame ? Colors.blue : Colors.black),
        ),
      ),
    );
  }

  void showFilterTable(BuildContext context){
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context, 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      builder: (context){
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCategory('Minutes', ['M1', 'M2', 'M3', 'M4', 'M5', 'M6', 'M10', 'M12', 'M15', 'M20', 'M30']),
              const SizedBox(height: 8),
              _buildCategory('Hours', ['H1', 'H2', 'H3', 'H4', 'H6', 'H8', 'H12']),
              const SizedBox(height: 8),
              _buildCategory('Days', ['D1', 'W1', 'MN']),
            ],
          ),
        );
      }
    );
  }
  //default time with blue outline frame
  //choose one time then close the table

  Widget _buildCategory(String title, List<String> options){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: bodySBold),
        Wrap(
          spacing: 5, 
          runSpacing: 5, 
          children: options.map((option) {
            return FilterChip(
              label: Text(option), 
              selected: selectedTimeFrame == option,
              onSelected: (bool selected){
                //need to filter the time 
                if(selected){
                  setState(() {
                    selectedTimeFrame = option;
                    fetchForexData(timeframe: option);
                  });
                  
                }
                hideOverlayMenu();
                Navigator.pop(context);
              }
            );
          }).toList(),
        )
      ],
    );
  }


}

class CandleData {
  final String date;
  final double open;
  final double high;
  final double low;
  final double close;

  CandleData(this.date, this.open, this.high, this.low, this.close);
}