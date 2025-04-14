import 'package:flutter/material.dart';
import 'package:trading_app/const/constant.dart';
import 'package:trading_app/const/textstyle.dart';

class MailInboxPage extends StatefulWidget {
  const MailInboxPage({super.key});

  @override
  State<MailInboxPage> createState() => _MailInboxPageState();
}

class _MailInboxPageState extends State<MailInboxPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mailbox', style: bodyMBold),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left, size: 30, color: blue),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.note_alt_outlined, color: blue, size: 25), 
              onPressed: (){},
            ),
          ),
        ],
      ),


      body: Column(
        children: [
          ListTile(
            title: const Text('Welcome to the trading platform', style: bodySRegular),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Trading platform', style: bodyXSRegular.copyWith(color: grey.shade800),),
                Text('06/02/2025', style: bodyXSRegular.copyWith(color: grey.shade800),)
              ],
            ),
            leading: Image.asset('assets/logo/trade_sampleLogo.png', width: 40, height: 40),
            onTap: () {
              
            },
          ),


        ],
      ),
    );
  }
}