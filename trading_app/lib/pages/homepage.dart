import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:trading_app/const/constant.dart';
import 'package:trading_app/const/textstyle.dart';
import 'package:trading_app/dataModel/currency_pair_datamodel.dart';
import 'package:trading_app/dataModel/simple_view_forexdata.dart';
import 'package:trading_app/pages/subpages/column_page_from_homepage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with SingleTickerProviderStateMixin {
  Timer? _timer;
  bool isLoading = true;
  String message = "";
  String searchQuery = "";
  final ScrollController _horizontalScrollController = ScrollController();
  late TabController _tabController;
  bool isApiFetched = false;
  DateTime? lastInvalidDataAlertTime;
  
  
  final String apiKey = dotenv.env['6WQUG6UD4KDW7HL1'] ?? '';//finnhub //https://finnhub.io/register 

  // List for the column
  List<String> selectedColumns = ['Bid', 'Ask', 'Day %', 'Spread']; //default columns for the simple view of forex rate

  // Mock data for testing or api unavailable
  final List<Map<String, dynamic>> mockForexData = [
    {'pair': 'AUD/CAD', 'bid': 0.90858, 'ask': 0.90868, 'day %': 0.06, 'spread': 10},
    {'pair': 'AUD/CHF', 'bid': 0.55510, 'ask': 0.55519, 'day %': -0.03, 'spread': 9},
    {'pair': 'AUD/DKK', 'bid': 4.45852, 'ask': 4.46016, 'day %': -0.06, 'spread': 164},
    {'pair': 'AUD/HKD', 'bid': 5.25944, 'ask': 5.25953, 'day %': 0.59, 'spread': 9},
  ];

  List<SimpleViewForexData> simpleForexData = SimpleViewForexData.defaultSimpleForexDataList; //default simple forex data
  List<CurrencyPairData> advanceForexData = CurrencyPairData.advancForexDataList; //default advance forex data
  List<SimpleViewForexData> filteredSimpleForexData = [];
  List<CurrencyPairData> filteredAdvanceForexData = [];

  @override
  void initState() {
    super.initState();
    fetchForexDigitData();
    _tabController = TabController(length: 2, vsync: this);
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted) {
        fetchForexDigitData();
      }
    });

  }

  @override
  void dispose() {
    _timer?.cancel();
    _horizontalScrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

/*   void didChangeDependencies(){
    super.didChangeDependencies();
    if(widget.isNewlyRegistered && !_dialogShown){
      _dialogShown = true;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context, 
          builder: (context) =>  AlertDialog(
            title: Text('Welcome to TradingXXX', style: heading5Bold),
            content: Column(
              children: [
                Text('XXX is a software development company and does not provide any financial, investment, brokerage or trading services.', style: bodyXSRegular),
                SizedBox(height: 10),
                Text('By pressing the ACCEPT button, I agree with the terms and conditions of the EULA, the Privacy Policy and the Disclaimer.'),

              ],
            ),
            actions: [
              BlueButton(
                onPressed: (){}, 
                text: 'ACCEPT'
              )
            ],
          ),
        );
      });
    }
  } */

  

  Future<void> fetchForexDigitData() async {

    //get live price - use web socket package(web_socket_channel)

    //use REST api to place buy/sell orders

    //Use flutter_bloc to handle real-time updates


    try {
      final url = "https://www.alphavantage.co/query?function=CURRENCY_EXCHANGE_RATE&from_currency=USD&to_currency=EUR&apikey=apiKey";
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("API response: $data");

        // Check for API rate limits
        if (data.containsKey("Note")) {
          showMessage("API rate limit exceeded. Please try again later. Default data is used.");
          setState(() {
            simpleForexData = SimpleViewForexData.defaultSimpleForexDataList;
            advanceForexData = CurrencyPairData.advancForexDataList;
            filteredAdvanceForexData = advanceForexData;
            filteredSimpleForexData = simpleForexData;
            isLoading = false;
          });
          return;
        }

        // Check for valid data
        if (data.containsKey("Realtime Currency Exchange Rate")) {
          final exchangeRate = data['Realtime Currency Exchange Rate'];

          double bidPrice = double.parse(exchangeRate["8. Bid Price"]);
          double askPrice = double.parse(exchangeRate["9. Ask Price"]);
          double spread = askPrice - bidPrice;

          setState(() {
            simpleForexData = [
              SimpleViewForexData(
                currencyPair: '${exchangeRate['1. From_Currency Code']}/${exchangeRate["3. To_Currency Code"]}', 
                bid: bidPrice.toStringAsFixed(4), 
                ask: askPrice.toStringAsFixed(4), 
                day: '0.0', 
                spread: spread.toStringAsFixed(4), 
                time: DateTime.now().copyWith(hour: 0, minute: 0, second: 0),
              ),
            ];
            filteredSimpleForexData = simpleForexData;//api data

            advanceForexData = [
              CurrencyPairData(
                currencyPair: '${exchangeRate['1. From_Currency Code']}/${exchangeRate["3. To_Currency Code"]}', 
                change: '0.00', 
                buy: askPrice.toStringAsFixed(4), 
                sell: bidPrice.toStringAsFixed(4), 
                high: (askPrice + 0.01).toStringAsFixed(4),  //need to check back api
                low: (askPrice - 0.01).toStringAsFixed(4),  //need to check back
                time:  DateTime.now().copyWith(hour: 0, minute: 0, second: 0), 
                spread: spread.toStringAsFixed(4), 
                day: '0.00'
              ),
            ];
            filteredAdvanceForexData = advanceForexData;
            isApiFetched = true;
            isLoading = false;
          });
          return;
        } else {
          final now = DateTime.now();
          if(lastInvalidDataAlertTime == null || now.difference(lastInvalidDataAlertTime!) > const Duration(minutes: 2)){
            showMessage("Invalid data received: No time series found");
            lastInvalidDataAlertTime = now;
          }
          
          if(mounted){
            setState(() {
              simpleForexData = SimpleViewForexData.defaultSimpleForexDataList;
              advanceForexData = CurrencyPairData.advancForexDataList;
              filteredAdvanceForexData = advanceForexData;
              filteredSimpleForexData = simpleForexData;
              isApiFetched = false;
              isLoading = false;
            });
          }
          
        }
      } else {
        showMessage("Failed to load Forex data: ${response.statusCode}");
        if(mounted){
          setState(() {
            simpleForexData = SimpleViewForexData.defaultSimpleForexDataList;
            advanceForexData = CurrencyPairData.advancForexDataList;
            filteredAdvanceForexData = advanceForexData;
            filteredSimpleForexData = simpleForexData;
            isApiFetched = false;
            isLoading = false;
          });
        }
        
      }
    } catch (e) {
      showMessage("Error fetching Forex data: $e");
      if(mounted){
        setState(() {
          simpleForexData = SimpleViewForexData.defaultSimpleForexDataList;
          advanceForexData = CurrencyPairData.advancForexDataList;
          filteredAdvanceForexData = advanceForexData;
          filteredSimpleForexData = simpleForexData;
          isApiFetched = false;
          isLoading = false;
        });
      }
    }
  }

  Future<void> selectColumnFromPage() async {
    final updatedColumns = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ColumnPage(selectedColumns: selectedColumns),
      ),
    );

    if (updatedColumns != null) {
      setState(() {
        selectedColumns = updatedColumns;
      });
    }
  }

  void searchResults(String query){
    setState(() {
      if(query.isEmpty){
        filteredSimpleForexData = simpleForexData;
        filteredAdvanceForexData = advanceForexData;

      }else{
        filteredSimpleForexData = simpleForexData
                  .where((element) => element.currencyPair.toLowerCase().contains(query.toLowerCase())).toList();
        filteredAdvanceForexData = advanceForexData
                  .where((element) => element.currencyPair.toLowerCase().contains(query.toLowerCase())).toList();
      }
      // searchQuery = query.toLowerCase();
      // filteredForexData = forexData.where((item){
      //   return item['pair'].toLowerCase().contains(searchQuery);
      // }).toList();
    });
  }


  void showMessage(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message, style: bodyMRegular),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // List<CurrencyPairData> displayData = isApiFetched ? forexData: mockForexData;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Quotes', style: bodyMBold),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              //change the tab page
              if(_tabController.index == 0){
                _tabController.animateTo(1);
              }else{
                _tabController.animateTo(0);
              }
            },
            icon: const Icon(Icons.format_list_bulleted, size: 20),
          ),
          actions: [
            IconButton(
              onPressed: selectColumnFromPage,
              icon: const Icon(Icons.format_align_justify_outlined, size: 20),
            ),
          ],
        ),
      
      
        body: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                onChanged: searchResults,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: grey.shade800),
                  hintText: 'Enter symbol for search',
                  hintStyle: bodyMRegular.copyWith(color: grey.shade800),
                  contentPadding: const EdgeInsets.all(10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: grey.shade100,
                  labelStyle: bodyMRegular.copyWith(color: grey.shade200),
                ),
              ),
            ),
            
      
            // Display forex data
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      //simple view
                      simpleForexView(),

                      //advance view
                      advanceForexView(),
                    ]
                  ),
                ),
          ],
        ),
      ),
    );
  }

  Widget simpleForexView(){
    return isLoading
      ? const Center(child: CircularProgressIndicator())
      : filteredSimpleForexData.isEmpty
          ? const Center(child: Text("No data available", style: bodyMBold))

          : Scrollbar(
            controller: _horizontalScrollController,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _horizontalScrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Table header
                  Row(
                    children: [
                      const SizedBox(
                        width: 100, // Fixed width for the 'Symbol' column
                        child: Text('Symbol', style: bodyMRegular, textAlign: TextAlign.center),
                      ),
                      for (var column in selectedColumns)
                        SizedBox(
                          width: 100,
                          child: Text(column, style: bodyMRegular, textAlign: TextAlign.center),
                        ),
                    ],
                  ),
          
                  // List of forex data
                  Column(
                    children: [
                      for (var item in filteredSimpleForexData)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 100, // Fixed width for the 'Symbol' column
                                child: Text(item.currencyPair, style: bodySBold, textAlign: TextAlign.start),
                              ),
                              for (var column in selectedColumns)
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    getColumnValue(item, column),
                                    style: bodySSemiBold,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                            ],
                          ),
                        ),
          
                    ],
                  ),
                ],
              ),
            ),
          );
  }

  String getColumnValue(SimpleViewForexData item, String column) {
    switch (column.toLowerCase()) {
      case 'bid':
        return item.bid;
      case 'ask':
        return item.ask;
      case 'spread':
        return item.spread;
      case 'day %':
        return item.day;
      default:
        return '--'; // Fallback for unknown columns
    }
  }


  Widget advanceForexView(){
    //fetch data from api
    //default data when no api
    // List<CurrencyPairData> advanceForexList = CurrencyPairData.advancForexDataList;

    return 
      isLoading ? const Center(child: CircularProgressIndicator())
        : filteredAdvanceForexData.isEmpty
            ? const Center(child: Text("No data available", style: bodyMBold))

        : ListView.builder(
          itemCount: filteredAdvanceForexData.length,
          itemBuilder: (context, index){
            final data = filteredAdvanceForexData[index];
        
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal:10),
        
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [ 

                  //for one pair
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      
                      //left side
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(data.change, style: bodyXSRegular),
                              const SizedBox(width: 5),
                              Text('${data.spread}%', style: bodyXSRegular.copyWith(color: data.spread.startsWith('-') ? Colors.red : Colors.blue,)),
                            ],
                          ),
                          Text(data.currencyPair, style: bodySBold),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('${data.time.hour}:${data.time.minute}:${data.time.second}', style: bodyXSRegular),
                              const SizedBox(width: 3),
                              Icon(Icons.space_bar, size: 15, color: grey.shade600),
                              const SizedBox(width: 3),
                              Text(data.day, style: bodyXSRegular),

                            ],
                          ),
                        ],
                      ),

                      //right side     

                      //Blue Values: Prices have increased compared to the previous price or session.
                      //Red Values: Prices have decreased compared to the previous price or session.     
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(data.sell, style: bodyMBold.copyWith(color: Colors.black)),
                              Text('L:${data.low}', style: bodyXSRegular),
                            ],
                          ),
                          const SizedBox(width: 15),          
                          Column(
                            children: [
                              Text(data.buy, style: bodyMBold.copyWith(color: Colors.black)),
                              Text('H:${data.high}', style: bodyXSRegular),
                            ],
                          ),
                        ],
                      ),
        
                    ],
                  ),
                  const SizedBox(height: 8),
        
                ],
              ),
            );
          }
        );
  }

  //values changed with color (blue, red, black)
  Color getValueColor(double currentValue, double previousValue){
    if(currentValue>previousValue){
      return Colors.blue;

    }else if(currentValue<previousValue){
      return Colors.red;

    }else{
      return Colors.black;
    }
  }


}