import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trading_app/const/constant.dart';
import 'package:trading_app/const/textstyle.dart';

class JournalPage extends StatefulWidget {
  const JournalPage({super.key});

  @override
  State<JournalPage> createState() => JournalPageState();
}

class JournalPageState extends State<JournalPage> {

  DateTime currentDate = DateTime.now();

  void _changeDate(int days){
    setState(() {
      currentDate = currentDate.add(Duration(days: days));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: ()=> _changeDate(-1),
              icon: Icon(Icons.keyboard_arrow_left, size: 20, color: blue),
            ),
            Text(DateFormat('dd MMM yyyy').format(currentDate), style: bodyMBold.copyWith(color: blue)),
            IconButton(
              onPressed: ()=> _changeDate(1),
              icon: Icon(Icons.keyboard_arrow_right, size: 20, color: blue),
            ),
          ],
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left, size: 30, color: blue),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: Icon(Icons.ios_share_outlined, color: blue, size: 25)
          )
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //search bar
        
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: grey.shade800),
                  hintText: 'Search',
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
        
            //list of info
            Text('List of info', style: bodySRegular.copyWith(color: grey.shade600),),
          ],
        ),
      ),




    );
  }
}