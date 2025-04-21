import 'package:flutter/material.dart';
import 'package:trading_app/const/constant.dart';
import 'package:trading_app/const/textstyle.dart';
import 'package:trading_app/pages/subpages/more_indicators.dart';

class IndicatorPage extends StatefulWidget {
  const IndicatorPage({super.key});

  @override
  State<IndicatorPage> createState() => _IndicatorPageState();
}

class _IndicatorPageState extends State<IndicatorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Indicators', style: bodyMBold),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left, size: 30, color: blue),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),

      body: Container(
        color: grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 35),
            Material(
              color: Colors.white,
              child: ListTile(
                
                title: Text('Main window', style: bodySBold.copyWith(color: blue)),
                trailing: Icon(Icons.add_circle_outline, color: blue),
                onTap: (){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context)=> const AddIndicator()),
                  );
                },
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('To add an indicator tap window title', style: bodyXSRegular.copyWith(color: grey.shade800)),
            ),
            
          ],
        ),
      ),




    );
  }
}