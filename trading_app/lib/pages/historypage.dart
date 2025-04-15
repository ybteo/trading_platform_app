import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:trading_app/const/constant.dart';
import 'package:trading_app/const/textstyle.dart';
import 'package:trading_app/pages/subpages/historyFromHistoryPage.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  String selectedSortOption = 'Default';
  List<String> orderHistory = [];
  DateTime timeNow = DateTime.now();

  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose(){
    _tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 30,
          decoration: BoxDecoration(
            color: grey.shade200,
            borderRadius: BorderRadius.circular(8)
          ),
          child: Container(
            width: 265, height: 40,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: TabBar(
                controller: _tabController,
                labelColor: Colors.black,
                labelStyle: bodyXSBold,
                dividerColor: Colors.transparent,
                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  
                ),
                tabs: const [
                  Tab(text: "Positions"),
                  Tab(text: "Orders"),
                  Tab(text: "Deals"),
                ],
              ),
            ),
          ),
        ),
        
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.format_line_spacing, size: 20), 
          onPressed: ()=> showSortMenu(context),
        ),
        
        actions: [
          IconButton( 
            icon: const Icon(Icons.access_time, size: 25), 
            onPressed: (){
              //history page
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context)=> const HistoryFromHistory()),
              );

            },
          ),
          
        ],
        
      ),

      body: TabBarView(
              controller: _tabController,
              children: [
                _positionTab(), _ordersTab(), _dealsTab()
              ]
            ),
              
    );
  }

  Widget _positionTab(){

    return orderHistory.isEmpty? _noHistoryData()
      : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Balance', style: bodySBold),
                  Text('Amount in double', style: bodySBold.copyWith(color: blue)),
                ],
              ),
              Text(DateFormat('yyyy.MM.dd HH:mm:ss').format(timeNow), style: bodyXSRegular.copyWith(color: grey.shade800)),
              Divider(thickness: 1, color: grey),
        
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Deposit', style: bodySRegular),
                  Text('Amount in double', style: bodySBold),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Profit', style: bodySRegular),
                  Text('Amount in double', style: bodySBold),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Swap', style: bodySRegular),
                  Text('Amount in double', style: bodySBold),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Commission', style: bodySRegular),
                  Text('Amount in double', style: bodySBold),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Balance', style: bodySRegular),
                  Text('Amount in double', style: bodySBold),
                ],
              ),
              Divider(thickness: 1, color: grey),
              
        
            ],
          ),
        ),
      );
  }

  Widget _ordersTab(){
    return orderHistory.isEmpty? _noHistoryData():
      Column(
        children: [

        ],
      );
  }

  Widget _noHistoryData(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.file_open, size: 125, color: grey.shade700),
        Text('No history data', style: bodyXSBold.copyWith(color: grey.shade900)),
      ],
    );
  }

  
  void showSortMenu(BuildContext context) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    showMenu(
      color: Colors.white,
      context: context, 
      position: RelativeRect.fromLTRB(0, offset.dy+50, 0, 0), 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      items: <PopupMenuEntry<dynamic>>[
        const PopupMenuItem(
          enabled: false,
          child: Text('sort by', style: bodyXSRegular),
        ),
        const PopupMenuDivider(),
        menuItem('Default'),
        menuItem('Symbol'),
        menuItem('Order'),
        menuItem('Type'),
        menuItem('Volumn'),
        menuItem('Open Time'),
        menuItem('Close Time'),
        menuItem('State'),

      ],
    );
  }

    PopupMenuItem<dynamic> menuItem(String title) {
      bool isSelected = title == selectedSortOption;

      return PopupMenuItem(
        onTap: () {
          setState(() {
            selectedSortOption = title;
          });
        }, // Disable tap for greyed-out item
        child: Container(
          // color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title, style: bodyXSRegular
              ),
              if(isSelected)
              Icon(Icons.check, color: blue.shade700),
              
            ],
          ),
        ),
      );
    }

  Widget _dealsTab(){
    return orderHistory.isEmpty? _noHistoryData()
      : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Balance', style: bodySBold),
                  Text('Amount in double', style: bodySBold.copyWith(color: blue)),
                ],
              ),
              Text('Date Time', style: bodyXSRegular.copyWith(color: grey.shade800)),
              Divider(thickness: 1, color: grey),
        
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Deposit', style: bodySRegular),
                  Text('Amount in double', style: bodySBold),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Profit', style: bodySRegular),
                  Text('Amount in double', style: bodySBold),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Swap', style: bodySRegular),
                  Text('Amount in double', style: bodySBold),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Commission', style: bodySRegular),
                  Text('Amount in double', style: bodySBold),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Balance', style: bodySRegular),
                  Text('Amount in double', style: bodySBold),
                ],
              ),
              Divider(thickness: 1, color: grey),
              
        
            ],
          ),
        ),
      );
  }


}