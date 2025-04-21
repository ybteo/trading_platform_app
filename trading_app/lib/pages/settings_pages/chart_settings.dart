import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trading_app/const/constant.dart';
import 'package:trading_app/const/textstyle.dart';
import 'package:trading_app/pages/settings_pages/color_settings.dart';

class ChartSettings extends StatefulWidget {
  const ChartSettings({super.key});

  @override
  State<ChartSettings> createState() => _ChartSettingsState();
}

class _ChartSettingsState extends State<ChartSettings> {
  String selectedChart = 'Bar Chart';

  final Map<String, bool> _switchStates = {
    'Volumes' : false,
    'Tick Volumes': false,
    'Ask Price Line': false,
    'Period Separators': false,
    'Countdown to Bar Close': false,
    'Trade Orders': true,
    'Trade Positions': true,
    'SL/TP Levels': true,
    'Trade History': true,
    'Preload Charts Data': true,
    'OHLC': false,
    'Data Window': false,
    'Trading Panel at the Bottom': false,

  };

  @override
  void initState(){
    super.initState();
    _loadSwitchButton();
  }

 /*  void _loadSwitchButton() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _switchStates['Volumes'] = prefs.getBool('Volumes')?? false;
      _switchStates['Tick Volumes'] = prefs.getBool('Tick Volumes') ?? false;
      _switchStates['Ask Price Line'] = prefs.getBool('Ask Price Line')?? false;
      _switchStates['Period Separators'] = prefs.getBool('Period Separators')?? false;
      _switchStates['Countdown to Bar Close'] = prefs.getBool('Countdown to Bar Close')?? false;
      _switchStates['Trade Orders'] = prefs.getBool('Trade Orders')?? true;
      _switchStates['Trade Positions'] = prefs.getBool('Trade Positions')?? true;
      _switchStates['SL/TP Levels'] = prefs.getBool('SL/TP Levels')?? true;
      _switchStates['Trade History'] = prefs.getBool('Trade History')?? true;
      _switchStates['Preload Charts Data'] = prefs.getBool('Preload Charts Data')?? true;
      _switchStates['OHLC'] = prefs.getBool('OHLC')?? false;
      _switchStates['Data Window'] = prefs.getBool('Data Window')?? false;
      _switchStates['Trading Panel at the Bottom'] = prefs.getBool('Trading Panel at the Bottom')?? false;
    });

  }
 */
  void _loadSwitchButton() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

      setState(() {
        List<String> keys = [
          'Volumes',
          'Tick Volumes',
          'Ask Price Line',
          'Period Separators',
          'Countdown to Bar Close',
          'Trade Orders',
          'Trade Positions',
          'SL/TP Levels',
          'Trade History',
          'Preload Charts Data',
          'OHLC',
          'Data Window',
          'Trading Panel at the Bottom'
        ];

        for(String key in keys){
          final dynamic storedValue = prefs.get(key);

          if(storedValue is bool){
            _switchStates[key] = storedValue;
          }else{
            _switchStates[key] = false;
            prefs.remove(key);
          }
        }


      });
  }




  void _saveSwitchStates(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Charts', style: bodyMBold),
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
              const SizedBox(height: 35),
              _chartButton(Icons.bar_chart_outlined, 'Bar Chart', () {}),//bar_chart_outlined constant
              _chartButton(Icons.candlestick_chart, 'Candlesticks', () {}),//candlestick_chart constant
              _chartButton(Icons.stacked_line_chart_sharp, 'Line Chart', () {}), //stacked_line_chart_sharp constant //show_chart constant
        
              const SizedBox(height: 35),
              _button('Volumes'),
              _button('Tick Volumes'),
              _button('Ask Price Line'),
              _button('Period Separators'),
              _button('Countdown to Bar Close'),
              _button('Trade Orders'),
              _button('Trade Positions'),
              _button('SL/TP Levels'),
              _button('Trade History'),
              _button('Preload Charts Data'),

              const SizedBox(height: 35),
              _button('OHLC'),
              _button('Data Window'),
              _button('Trading Panel at the Bottom'),
              const SizedBox(height: 35),

              Material(
                color: Colors.white,
                child: ListTile(
                  title: const Text('Colors', style: bodyMRegular),
                  leading: Image.asset('assets/icon/color_icon.png', width: 35, height: 35),
                  trailing: Icon(Icons.keyboard_arrow_right_outlined, color: grey.shade500),
                  onTap: (){
                    Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context)=> const ColorSettings(),
                      )
                    );
                  },
                ),
              ),

              const SizedBox(height: 55),

            ],
          ),
        ),
      ),
    );
  }

  Widget _chartButton(IconData icon, String title, VoidCallback onTap){

    bool isSelected = title == selectedChart;

    return Column(
      children: [
        Material(
          color: Colors.white,
          child: ListTile(
            title: Text(title, style: bodyMRegular),
            leading: Icon(icon, size: 30, color: blue),
            trailing: isSelected? Icon(Icons.check, color: blue.shade700): null,
            onTap: (){
              setState(() {
                selectedChart = title;
              });
              onTap();
            },
          ),
        ),
        Divider(thickness: 1, color: grey.shade200, height: 0),
      ],
    );
  }

  Widget _button(String title){
    return Column(
      children: [
        Material(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: bodyMRegular),

                //switch button
                Switch(
                  value: _switchStates[title]?? false, 
                  onChanged: (value){
                    setState(() {
                      _switchStates[title] = value;
                      _saveSwitchStates(title, value);
                    });
                  },
                  activeColor: Colors.white,
                  inactiveThumbColor: Colors.white,
                  activeTrackColor: Colors.green,
                  inactiveTrackColor: grey.shade400,
                  trackOutlineColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
                ),
                
              ],
            ),
          ),
        ),
        Divider(thickness: 1, color: grey.shade200, height: 0),
      ],
    );
  }


}