import 'package:flutter/material.dart';
import 'package:trading_app/const/constant.dart';
import 'package:trading_app/const/textstyle.dart';

class CategoriesNewsPage extends StatefulWidget {
  const CategoriesNewsPage({super.key});

  @override
  State<CategoriesNewsPage> createState() => _CategoriesNewsPageState();
}

class _CategoriesNewsPageState extends State<CategoriesNewsPage> {

  String selectedChoice = 'News by Category';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories', style: bodyMBold),
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
          children: [
            const SizedBox(height: 15),
            _button('Favorite News', 'No news marked as Favorite. You can add news to Favorites when viewing.'),
            _button('News by Category', 'Total news: 0'),
          ],
        ),
      ),
    );

  }

  Widget _button(String title, String subtitle){

    bool isSelected = title == selectedChoice;

    return Material(
      color: Colors.white,
      child: Column(
        children: [
          ListTile(
            title: Text(title, style: bodyMRegular),
            subtitle: Text(subtitle, style: bodyXSRegular),
            onTap: (){
              setState(() {
                selectedChoice = title;
              });
            },
            trailing: isSelected? Icon(Icons.check, color: blue, size: 15): null,
          ),
          Divider(thickness: 1, height: 0, color: grey.shade300),
        ],
      ),
    );
  }
}