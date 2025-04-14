import 'package:flutter/material.dart';
import 'package:trading_app/const/buttonWidget.dart';
import 'package:trading_app/const/constant.dart';
import 'package:trading_app/const/textstyle.dart';
import 'package:trading_app/pages/subpages/addTradePage.dart';

class TradePage extends StatefulWidget {
  const TradePage({super.key});

  @override
  State<TradePage> createState() => _TradePageState();
}

class _TradePageState extends State<TradePage> {
  double depositAmount = 0.0;
  bool isDepositSet = false;

  void _showDepositDialog(){
    
    if(isDepositSet) return; //prevent reopening

    final TextEditingController depositController = TextEditingController();

    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter Deposit Amount', style: heading5Bold),
          content: TextField(
            controller: depositController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Deposit',
              hintStyle: bodySRegular,
            ),
          ),
          
          actions: [
            TextButton(
              onPressed: (){
                Navigator.pop(context);
              }, 
              child: const Text('Cancel', style: bodySRegular),
            ),

            TextButton(
              onPressed: (){
                final input = depositController.text;
                final parsedAmount = double.tryParse(input);

                if(parsedAmount != null && parsedAmount > 0){
                  setState(() {
                    depositAmount = parsedAmount;
                    isDepositSet = true;
                  });
                }

                Navigator.pop(context);
              }, 
              child: const Text('OK', style: bodySBold),
            ),
          ],
        );
      }
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Unit', style: heading5Bold),
        
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, size: 25), 
            onPressed: (){
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => const AddTradePage(),
                ),
              );
            },
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [

            BlueButtonWithIcon(
              onPressed: isDepositSet? (){}: _showDepositDialog, 
              icon: Icons.account_balance_wallet_outlined, 
              text: 'Set Deposit'
            ),
            Text('The deposit is allowed to be set once', style: bodyXSRegular.copyWith(color: grey.shade600)),
            
            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Balance:', style: bodySRegular),
                Text('\$${depositAmount.toStringAsFixed(2)}', style: bodySBold),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Equity:', style: bodySRegular), //need add function
                Text('\$${depositAmount.toStringAsFixed(2)}', style: bodySBold), 
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Free Margin:', style: bodySRegular), //need add functions
                Text('\$${depositAmount.toStringAsFixed(2)}', style: bodySBold),
              ],
            ),
            const SizedBox(height: 80),
            Center(
              child: Icon(Icons.trending_up, size: 85, color: grey.shade300),
            ),
        
            
          ],
        ),
      ),
    );
  }
}