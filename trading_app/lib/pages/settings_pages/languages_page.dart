import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trading_app/const/constant.dart';
import 'package:trading_app/const/textstyle.dart';

class LanguagesPage extends StatefulWidget {
  const LanguagesPage({super.key});

  @override
  State<LanguagesPage> createState() => _LanguagesPageState();
}

class _LanguagesPageState extends State<LanguagesPage> {

  String selectedLanguage = 'System Language';


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
        actions: [
          TextButton(
            onPressed: (){
              //save function needed
              Navigator.pop(context);
            }, 
            child: Text('OK', style: bodySBold.copyWith(color: blue)),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Container(
          color: grey.shade100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('AUTOMATIC SELECTION', style: bodyXSRegular.copyWith(color: grey.shade600),),
              ),
              _button('System Language', (){}),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('MANUAL SELECTION', style: bodyXSRegular.copyWith(color: grey.shade600),),
              ),
              _button('German', () {}),
              _button('Arabic', () {}),
              _button('Greek', () {}), //not sure
              _button('Japanese', () {}),
              _button('English', () {}),
              _button('Russian', () {}),
              _button('Traditional Chinese', () {}),
              _button('Spanish', () {}),
              _button('Simplified Chinese', () {}),
              _button('Italian', () {}),
              _button('Bahasa Melayu', () {}),
              _button('Czech', () {}), //not sure
              _button('Korean', () { }),
              _button('Turkish', () { }),
              _button('Polish', () { }),
              _button('Vietnamese', () { }),
              _button('Russian', () { }),
              _button('French', () { }),
              _button('Indonesian', () { }),
              _button('Dutch', () { }), //not sure
              _button('Thai', () { }),
              _button('Portuguese', () { }),
              _button('Hindi', () {}),
        
        
              
            ],
          ),
        ),
      ),




    );
  }

  Widget _button(String title, VoidCallback onTap){
    bool isSelected = title == selectedLanguage;

    return Column(
      children: [
        Material(
          color: Colors.white,
          child: ListTile(
            title: Text(title, style: bodyMRegular),
            trailing: isSelected? Icon(Icons.check, color: blue.shade700) : null,
            onTap: (){
              setState(() {
                selectedLanguage = title;
              });
              onTap(); //need to add save the language function
            },
          ),
        ),
        Divider(thickness: 1, color: grey.shade200, height: 0),
      ],
    );
  }
}