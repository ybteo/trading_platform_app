import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trading_app/const/button_widget.dart';
import 'package:trading_app/const/constant.dart';
import 'package:trading_app/const/textstyle.dart';
import 'package:trading_app/pages/chartpage.dart';
import 'package:trading_app/pages/historypage.dart';
import 'package:trading_app/pages/homepage.dart';
import 'package:trading_app/pages/settingspage.dart';
import 'package:trading_app/pages/tradepage.dart';

class BottomNaviBar extends StatefulWidget {
  final bool isNewUser;
  final int initialIndex;
  const BottomNaviBar({super.key, this.initialIndex = 0, this.isNewUser = false});

  @override
  State<BottomNaviBar> createState() => _BottomNaviBarState();
}

class _BottomNaviBarState extends State<BottomNaviBar> {
  final NavigationController naviController = Get.put(NavigationController());
  bool _welcomeDialogShown = false;

  @override
  void initState(){
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      naviController.selectedIndex.value = widget.initialIndex;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      registerWelcomeDialog();
    });
  }

  Future<void> registerWelcomeDialog() async {
    if(!widget.isNewUser || _welcomeDialogShown || !mounted) return;

    final prefs = await SharedPreferences.getInstance();
    bool hasSeenDialog = prefs.getBool('hasSeenWelcomeDialog')?? false;

    if(!hasSeenDialog){
      setState(() {
        _welcomeDialogShown = true;
      });
      await prefs.setBool('hasSeenWelcomeDialog', true);

      showDialog(
        barrierColor: Colors.white,
        context: context, 
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          insetPadding: const EdgeInsets.all(20),
          title: const Text('Welcome to TradingXXX', style: heading5Bold, textAlign: TextAlign.center),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              const Text('XXX is a software development company and does not provide any financial, investment, brokerage or trading services.', style: bodyXSRegular, textAlign: TextAlign.justify),
              const SizedBox(height: 15),
              const Text('By pressing the ACCEPT button, I agree with the terms and conditions of the EULA, the Privacy Policy and the Disclaimer.', style: bodyXSRegular, textAlign: TextAlign.justify),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: BlueButton(
                      onPressed: (){
                        //need save function for the acceptance of tnc 
                        Navigator.pop(context);
                      }, 
                      text: 'ACCEPT'
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const Text('None of the information available in the application is intended for investment purposes.', style: bodyXSRegular, textAlign: TextAlign.justify),
            ],
          ),

        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        ()=> NavigationBarTheme(
          data: NavigationBarThemeData(
            backgroundColor: grey.shade50,
            // indicatorColor: blue.shade400,
            labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>((states){
              if(states.contains(MaterialState.selected)){
                return bodySRegular.copyWith(color: blue.shade400);
              }
              return bodySRegular.copyWith(color: grey.shade900);
            })
          ), 
          child: NavigationBar(
            height: 65,
            elevation: 5,
            selectedIndex: naviController.selectedIndex.value,
            onDestinationSelected: (index)=> naviController.selectedIndex.value = index,
            destinations: [
              NavigationDestination(
                icon: naviController.selectedIndex.value == 0? Icon(Icons.swap_vert, color: blue.shade400): Icon(Icons.swap_vert, color: grey.shade900), 
                label: 'Quotes'
              ),
              NavigationDestination(
                icon: naviController.selectedIndex.value == 1? Icon(Icons.settings_input_composite_sharp, color: blue.shade400): Icon(Icons.settings_input_composite_sharp, color: grey.shade900), 
                label: 'Chart'
              ),
              NavigationDestination(
                icon: naviController.selectedIndex.value == 2? Icon(Icons.show_chart, color: blue.shade400): Icon(Icons.show_chart, color: grey.shade900), 
                label: 'Trade'
              ),
              NavigationDestination(
                icon: naviController.selectedIndex.value == 3? Icon(Icons.history, color: blue.shade400): Icon(Icons.history, color: grey.shade900), 
                label: 'History'
              ),
              NavigationDestination(
                icon: naviController.selectedIndex.value == 4? Icon(Icons.settings, color: blue.shade400): Icon(Icons.settings, color: grey.shade900), 
                label: 'Settings'
              ),
            ],
          ),
        ),
      ),

      body: Obx(()=> naviController.pages[naviController.selectedIndex.value]),

    );
  }
}


class NavigationController extends GetxController{
  final Rx<int>selectedIndex = 0.obs;
  final pages = [const Homepage(),const ChartsPage(),const TradePage(),const HistoryPage(),const SettingsPage()];
}