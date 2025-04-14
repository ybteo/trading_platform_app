import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trading_app/const/buttonWidget.dart';
import 'package:trading_app/const/constant.dart';
import 'package:trading_app/const/textstyle.dart';
import 'package:trading_app/pages/subpages/currencyPairPage.dart';

class AddTradePage extends StatefulWidget {
  const AddTradePage({super.key});

  @override
  State<AddTradePage> createState() => _AddTradePageState();
}

class _AddTradePageState extends State<AddTradePage> {
  String selectedCurrencyPair = 'AUDCAD';
  String? expandedTile;
  String selectedTile = 'Instant Execution';
  Color selectedColor = Colors.black;
  bool isExpanded = false; //to track the expansion state

  // final GlobalKey expansionTileKey = GlobalKey();

  final Map<String, String> currencyDescriptions = {
    'AUDCAD': 'Australian Dollar vs Canadian Dollar',
    'AUDCHF': 'Australian Dollar vs Swiss Franc',
    'AUDDKK': 'Australian Dollar vs Danish Krone',
    'AUDHKD': 'Australian Dollar vs Hong Kong Dollar',
    'AUDHUF': 'Australian Dollar vs Hungarian Forint',
    'AUDJPY': 'Australian Dollar vs Japanese Yen',
    'AUDNOK': 'Australian Dollar vs Norwegian Krone',
    'AUDNZD': 'Australian Dollar vs New Zealand Dollar',
    'AUDPLN': 'Australian Dollar vs Polish Zloty',
    'AUDSEK': 'Australian Dollar vs Swedish Krona ',
  };

  @override
  Widget build(BuildContext context) {
    String selectedCurrencyPairDes = currencyDescriptions[selectedCurrencyPair] ?? '';
   
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          }, 
          icon: Icon(Icons.keyboard_arrow_left, size: 30, color: blue.shade400),
        ),
        centerTitle: true,
        //dropdown menu for currency pair
        title: Column(
          children: [
            GestureDetector(
              onTap: () async {
               final result = await Navigator.push(context, 
                  MaterialPageRoute(builder: (context)=> CurrencyPairPage(selectedChoice: selectedCurrencyPair)),
                );
                if(result != null && result is String){
                  setState(() {
                    selectedCurrencyPair = result;
                  });
                }
              },
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: selectedCurrencyPair, style: bodySBold),
                    WidgetSpan(
                      child: Icon(Icons.keyboard_arrow_down, size: 15, color: grey.shade900),
                      alignment: PlaceholderAlignment.middle
                    )
                  ]
                )
              ),
            ),

            Text(selectedCurrencyPairDes, style: bodyXSRegular),
          ],
        ),
        
      ),


      body: SingleChildScrollView(
        child: Column(
          children: [
            
            ExpansionTile(
              key: ValueKey(isExpanded), // for collapse
              initiallyExpanded:  isExpanded, 
              onExpansionChanged: (expand) {
                setState(() {
                  isExpanded = expand;
                });
              },
              title: Text(
                selectedTile,
                style: bodySRegular.copyWith(color: selectedColor),
              ),
              children: [
                listTile('Instant Execution', Colors.black),
                listTile('Buy Limit', blue),
                listTile('Sell Limit', Colors.red),
                listTile('Buy Stop', blue),
                listTile('Sell Stop', Colors.red),
                listTile('Buy Stop Limit', blue),
                listTile('Sell Stop Limit', Colors.red),
            
              ],
            ),
        
            const SizedBox(height: 15),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('-0.5', style: bodyXSRegular.copyWith(color: blue),),
                Text('-0.1', style: bodyXSRegular.copyWith(color: blue),),
                const Text('0.11', style: bodyXSRegular),
                Text('+0.1', style: bodyXSRegular.copyWith(color: blue),),
                Text('+0.5', style: bodyXSRegular.copyWith(color: blue),),
              ],
            ),
        
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Price', style: bodySRegular),
                  const SizedBox(width: 45),
                  IconButton(onPressed: (){}, icon: Icon(Icons.remove, size: 15, color: blue)),
                  Text('not set', style: bodySRegular.copyWith(color: grey)),
                  IconButton(onPressed: (){}, icon: Icon(Icons.add, size: 15, color: blue)),
                ],
              ),
            ),
            inputRow('Stop Loss'),
            inputRow('Take Profit'),
            inputRow('Expiration'),
        
        
            //button
            if(selectedTile == 'Instant Execution')
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: RedButton(onPressed: (){}, text: 'Sell')),
                Expanded(child: BlueButton(onPressed: (){}, text: 'Buy')),
              ],
            )
        
            else
            Row(
              children: [
                Expanded(child: GreyButton(onPressed: (){}, text: 'Place')), //button turn red when the above things are filled
              ],
            ),
          ],
        ),
      ),

    );
  }

  Widget listTile(String title, Color color/* , {bool showTick = false} */){
    return ListTile(
      title: Text(title, style: bodySRegular.copyWith(color: color)),
      trailing:  selectedTile == title? Icon(Icons.check, color: blue, size: 20): null,
      onTap: (){
        setState(() {
          selectedTile = title;
          selectedColor = color;
          isExpanded = false; //collapse the expansion
        });
       
      },
    );
  }


  Widget inputRow(String label){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: bodySRegular),
          const SizedBox(width: 15),
          IconButton(onPressed: (){}, icon: Icon(Icons.remove, size: 15, color: blue)),
          Text('not set', style: bodySRegular.copyWith(color: grey)),
          IconButton(onPressed: (){}, icon: Icon(Icons.add, size: 15, color: blue)),
        ],
      ),
    );
  }

 
}