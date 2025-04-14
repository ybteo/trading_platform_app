import 'package:flutter/material.dart';
import 'package:trading_app/const/constant.dart';
import 'package:trading_app/const/textstyle.dart';

class CurrencyPairPage extends StatefulWidget {
  final String selectedChoice;
  const CurrencyPairPage({super.key, required this.selectedChoice});

  @override
  State<CurrencyPairPage> createState() => _CurrencyPairPageState();
}

class _CurrencyPairPageState extends State<CurrencyPairPage> {

  late String selectedCurrencyPair;
  final List<String> currencyPair = [
    "AUDCAD", "AUDCHF", "AUDDKK", "AUDHKD", "AUDHUF", "AUDJPY", "AUDNOK", "AUDNZD", "AUDPLN", "AUDSEK"
  ];

  @override
  void initState(){
    super.initState();
    selectedCurrencyPair = widget.selectedChoice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left, color: blue.shade400),
          onPressed: (){
            Navigator.pop(context, selectedCurrencyPair);
          },
        ),
        
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back', style: bodySRegular.copyWith(color: blue)),
            )
          ],
        ),
      ),

      body: ListView.builder(
        itemCount: currencyPair.length,
        itemBuilder: (context, index){
          return currencyPairListTile(currencyPair[index]);
      }),
    );
  }


  //example of button
  Widget currencyPairListTile(
    String currencyPair
  ){
    bool isSelected = selectedCurrencyPair == currencyPair;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),
      margin: EdgeInsets.zero,
      child: ListTile(
        visualDensity: const VisualDensity(vertical: -4),
        tileColor: Colors.white,
        title: Text(
          currencyPair, style: bodySRegular,
        ),
        trailing: isSelected? Icon(Icons.check, color: blue.shade400): null,
        shape: Border.all(color: grey.shade400, width: 0),
        onTap: () {
          setState(() {
            selectedCurrencyPair = currencyPair;
          });
          Navigator.pop(context, currencyPair);
        },
      ),
      
    );
  }




}