import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trading_app/const/constant.dart';
import 'package:trading_app/const/textstyle.dart';
import 'package:trading_app/pages/settings_pages/scheme_page.dart';

class ColorSettings extends StatefulWidget {
  const ColorSettings({super.key});

  @override
  State<ColorSettings> createState() => _ColorSettingsState();
}

class _ColorSettingsState extends State<ColorSettings> {

  //Map to store colors
  Map<String, Color> selectedColors = {
    'Foreground': blue,
    'Grid': blue,
    'Bar up': blue,
    'Bar down': blue,
    'Bull candle': blue,
    'Bear candle': blue,
    'Line chart': blue,
    'Volumes': blue,
    'Bid price line': blue,
    'Ask price line': blue,
    'Stops levels': blue,
  };

  @override
  void initState(){
    super.initState();
    _loadColors();
  }

  Future<void>_saveColors(String key, Color color) async {
    final prefs = await SharedPreferences.getInstance();
    // String colorString = color.value.toRadixString(16);
    String colorString = color.value.toRadixString(16).padLeft(8,'0');
    await prefs.setString(key, colorString);
  }

  Future<void> _loadColors() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedColors.forEach((key, _) {
        final dynamic storedValue = prefs.get(key); // Get value without assuming type
        if (storedValue is String && storedValue.length == 8) {
          selectedColors[key] = Color(int.parse('0xFF${storedValue.substring(2)}'));
        } else {
          prefs.remove(key); // Remove invalid entry (likely a bool)
        }
      });
    });
  }


  void _pickColor(BuildContext context, String title){
    Color tempColor = selectedColors[title] ?? blue;

    showDialog(
      context: context, 
      builder: (context){

        return AlertDialog(
          title: const Text('Pick a color', style: bodyMBold),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor:  tempColor,
              onColorChanged: (Color color){
                tempColor = color;
              },
              // showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () { 
                Navigator.pop(context);
              }, 
              child: const Text('Cancel', style: bodySRegular),
            ),
            TextButton(
              onPressed: () async {
                setState(() {
                  selectedColors[title] = tempColor;
                });
                await _saveColors(title, tempColor);
                Navigator.pop(context);
              }, 
              child: const Text('Select', style: bodySRegular)
            ),
          ],
        );
      }
    );
  }

  String selectedScheme = 'Color on White';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Colors', style: bodyMBold),
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          }, 
          icon: Icon(Icons.keyboard_arrow_left, size: 30, color: blue),
        ),
        
      ),

      body: Container(
        color: grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            Material(
              color: Colors.white,
              child: ListTile(
                onTap: () async {
                  final result = await Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: ((context) => const SchemePage()),
                    ),
                  );
                  if(result != null && result is String){
                    setState(() {
                      selectedScheme = result;
                    });
                  }


                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Scheme', style: bodyMRegular),
                    Text(selectedScheme, style: bodySRegular.copyWith(color: grey.shade500),),
                  ],
                ),
                trailing: 
                    // Text('selectedScheme', style: bodySRegular.copyWith(color: grey.shade500),),
                    Icon(Icons.keyboard_arrow_right, size: 25, color: grey.shade500),
                  
              ),
            ),
            const SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('COLORS', style: bodyXSRegular.copyWith(color: grey.shade600),),
            ),
            _button('Foreground'),
            _button('Grid'),
            _button('Bar up'),
            _button('Bar down'),
            _button('Bull candle'),
            _button('Bear candle'),
            _button('Line chart'),
            _button('Volumes'),
            _button('Bid price line'),
            _button('Ask price line'),
            _button('Stops levels')
          ],    
        ),
      ),
    );
  }


  Widget _button (String title){
    return Column(
      //radio_button_checked_outlined constant icon
      children: [
        Material(
          color: Colors.white,
          child: ListTile(
            title: Text(title, style: bodyMRegular),
            trailing: Icon(Icons.radio_button_checked_rounded, size: 30, color: selectedColors[title]),
            onTap: (){
              _pickColor(context, title);
            }, //package: flutter_colorpicker: ^1.1.0 implemented    //web_color_picker: ^2.0.0
          ),
        ),
        Divider(thickness: 1, color: grey.shade200, height: 0),
      ],

    );
  }
}