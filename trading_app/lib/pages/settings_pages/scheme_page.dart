import 'package:flutter/material.dart';
import 'package:trading_app/const/constant.dart';
import 'package:trading_app/const/textstyle.dart';

class SchemePage extends StatefulWidget {
  const SchemePage({super.key});

  @override
  State<SchemePage> createState() => _SchemePageState();
}

class _SchemePageState extends State<SchemePage> {

  String selectedScheme = 'Color on White';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scheme', style: bodyMBold),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left, size: 30, color: blue),
          onPressed: (){
            Navigator.pop(context, selectedScheme);
          },
        ),
      ),

      body: Container(
        color: grey.shade100,
        child: Column(
          children: [
            const SizedBox(height: 35),
            _button('Color on White', () { }),
            _button('Green on Black', () { }),
            _button('Black on White', () { }),
            _button('Custom', () { }),
          ],
        ),
      ),
    );
  }

  Widget _button(String title, VoidCallback onTap){

    bool isSelected = title == selectedScheme;

    return Column(
      children: [
        Material(
          color: Colors.white,
          child: ListTile(
            title: Text(title, style: bodyMRegular),
            trailing: isSelected? Icon(Icons.check, color: blue.shade700) : null,
            onTap: () {
              setState(() {
                selectedScheme = title;
              });
              Navigator.pop(context, selectedScheme);
            },
          ),
        ),
        Divider(thickness: 1, color: grey.shade200, height: 0),
      ],
    );
  }

}