import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trading_app/const/constant.dart';
import 'package:trading_app/const/textstyle.dart';
import 'package:trading_app/pages/settings_pages/news_languages.dart';

class GeneralSettings extends StatefulWidget {
  const GeneralSettings({super.key});

  @override
  State<GeneralSettings> createState() => _GeneralSettingsState();
}

class _GeneralSettingsState extends State<GeneralSettings> {

  final Map<String, bool> _switchStates = {
    'Sounds': false,
    'Auto-Lock': false,
    'Enable News': false,
  };

  @override
  void initState(){
    super.initState();
    _loadSwitchSettings();
  }

  void _loadSwitchSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _switchStates['Sounds'] = prefs.getBool('Sounds')?? false;
      _switchStates['Auto-Lock'] = prefs.getBool('Auto-Lock')?? false;
      _switchStates['Enable News'] = prefs.getBool('Enable News')?? false;
      
    });
  }

  void _saveSwitchStates(String key, bool value)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings', style: bodyMBold),
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
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                Image.asset('assets/logo/trade_sampleLogo.png', width: 150, height: 150),
                const SizedBox(height: 15),
                _buttonWithSwitch('Sounds'),
                _buttonWithSwitch('Auto-Lock'),
                const SizedBox(height: 30),
                _buttonWithSwitch('Enable News'),
                _buttonExpansion('News Languages', () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context)=> const NewsLanguages()),
                  );
                }),
                const SizedBox(height: 30),
                _buttonExpansion('Lock Screen', () { }),
                const SizedBox(height: 30),
                _buttonExpansion('Rate this App!', () { }),
                _buttonExpansion('User Guide', () { }),
                const SizedBox(height: 30),
                _buttonExpansion('Storage', () { }),
                const SizedBox(height: 30),
                _buttonExpansion('Contact Developer', () { }),
                const SizedBox(height: 30),
            ],
          ),
        ),
      ),


    );
  }


  Widget _buttonWithSwitch(String title){
    return Column(
      children: [
        Material(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: bodyMRegular),
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

  Widget _buttonExpansion(String title, VoidCallback onTap){
    return Column(
      children: [
        Material(
          color: Colors.white,
          child: ListTile(
            title: Text(title, style: bodyMRegular),
            trailing: Icon(Icons.keyboard_arrow_right, size: 25, color: grey.shade500),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
            onTap: onTap,
          ),
        ),
        Divider(thickness: 1, color: grey.shade200, height: 0),
      ],
    );
  }
}