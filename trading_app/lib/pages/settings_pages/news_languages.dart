import 'package:flutter/material.dart';
import 'package:trading_app/const/constant.dart';
import 'package:trading_app/const/textstyle.dart';

class NewsLanguages extends StatefulWidget {
  const NewsLanguages({super.key});

  @override
  State<NewsLanguages> createState() => _NewsLanguagesState();
}

class _NewsLanguagesState extends State<NewsLanguages> {

  String selectedLanguage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Languages', style: bodyMBold),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left, size: 30, color: blue),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),

      body: SingleChildScrollView(
        child: Container(
          color: grey.shade100,
          child: Column(
            children: [
              const SizedBox(height: 25),
              _button('Afrikaans'),
              _button('Albanian'),
              _button('Arabic'),
              _button('Armenian'),
              _button('Azeri'),
              _button('Basque'),
              _button('Belarusian'),
              _button('Chinese'),
              _button('Czech'),
              _button('Danish'),
              _button('Dutch'),
              _button('English'),
              _button('Estonian'),
              _button('Farsi'),
              _button('Finnish'),
              _button('French'),
              _button('Georgian'),
              _button('German'),
              _button('Greek'),
              _button('Hebrew'),
              _button('Hindi'),
              _button('Hungarian'),
              _button('Indonesian'),
              _button('Italian'),
              _button('Japanese'),
              _button('Korean'),
              _button('Latvian'),
              _button('Lithuanian'),
              _button('Macedonian'),
              _button('Norwegian'),
              _button('Polish'),
              _button('Portuguese'),
              _button('Romanian'),
              _button('Russian'),
              _button('Serbian'),
              _button('Slovak'),
              _button('Slovenian'),
              _button('Spanish'),
              _button('Swedish'),
              _button('Tatar'),
              _button('Thai'),
              _button('Turkish'),
              _button('Ukrainian'),
              _button('Urdu'),
              _button('Vietnamese'),
        
              const SizedBox(height: 25),
              
        
        
            ],
          ),
        ),
      ),



    );
  }


  Widget _button(String title){
    bool isSelected = title == selectedLanguage;

    return Column(
      children: [
        Material(
          color: Colors.white,
          child: ListTile(
            title: Text(title, style: bodyMRegular),
            trailing: isSelected? Icon(Icons.check, color: blue.shade700): null,
            onTap: (){
              setState(() {
                selectedLanguage = title;
              });
              //need to add save the language function
              
            },
        
          ),
        ),
        Divider(thickness: 1, color: grey.shade200, height: 0),
      ],
    );
  }
}