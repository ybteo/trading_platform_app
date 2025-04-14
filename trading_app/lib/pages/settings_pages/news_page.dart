import 'package:flutter/material.dart';
import 'package:trading_app/const/constant.dart';
import 'package:trading_app/const/textstyle.dart';
import 'package:trading_app/pages/settings_pages/categories_news.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextButton.icon(
          onPressed: (){
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context)=> const CategoriesNewsPage()),);
          }, 
          icon: Icon(Icons.arrow_drop_down, color: blue, size: 20), 
          label: Text('Categories', style: bodyMBold.copyWith(color: blue)),
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
            icon: Icon(Icons.delete, color: blue, size: 25)
          )
        ],
      ),

      body: Column(
        children: [
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


        //display
        


        ],
      ),


    );
  }


  //if no news 
  Widget emptyNews(){
    return Column(
      children: [

      ],
    );
  }


  //if got news
}