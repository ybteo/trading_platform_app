import 'package:flutter/material.dart';
import 'package:trading_app/const/constant.dart';
import 'package:trading_app/const/textstyle.dart';
import 'package:trading_app/pages/settings_pages/chart_settings.dart';
import 'package:trading_app/pages/settings_pages/general_settings.dart';
import 'package:trading_app/pages/settings_pages/journal.dart';
import 'package:trading_app/pages/settings_pages/languages_page.dart';
import 'package:trading_app/pages/settings_pages/mailnbox.dart';
import 'package:trading_app/pages/settings_pages/message_page.dart';
import 'package:trading_app/pages/settings_pages/news_page.dart';
import 'package:trading_app/widget/settings_details.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings', style: bodyMBold),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        
        child: Container(
          color: grey.shade100,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Material(
                color: Colors.white,
                child: ListTile(
                  onTap: (){},
                  title: const Text('User account name', style: bodyMBold),
                  subtitle: const Text('Account number', style: bodySRegular),
                  trailing: Icon(Icons.keyboard_arrow_right, size: 20, color: grey.shade600),
                ),
              ),
          
          
          
              Divider(thickness: 1, color: grey.shade300, height: 0),
              SettingsDetails(
                topic: 'New Account', 
                onPress: (){}, 
                imageIcon: 'assets/image/add_acc_icon.png'
              ),
              Divider(thickness: 1, color: grey.shade300, height: 0, indent: 50),
          
              SettingsDetails(
                topic: 'Mailbox', 
                onPress: (){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context)=> const MailInboxPage()),
                  );
                }, 
                imageIcon: 'assets/image/mail_icon.png'
              ),
              Divider(thickness: 1, color: grey.shade300, height: 0, indent: 50),
          
              SettingsDetails(
                topic: 'News', 
                onPress: (){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => const NewsPage()),
                  );
                }, 
                imageIcon: 'assets/image/news_icon.png'
              ),
              Divider(thickness: 1, color: grey.shade300, height: 0, indent: 50),
          
              SettingsDetails(
                topic: 'Tradays', 
                onPress: (){}, 
                imageIcon: 'assets/image/calendar_icon.jpg'
              ),
              Divider(thickness: 1, color: grey.shade300, height: 0, indent: 50),
              const SizedBox(height: 30),

              SettingsDetails(
                topic: 'Chat and Messages', 
                onPress: (){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context)=> const MessagePage(),
                    ),
                  );
                }, 
                imageIcon: 'assets/image/chat_right_icon.png'
              ),
              Divider(thickness: 1, color: grey.shade300, height: 0, indent: 50),
          
              SettingsDetails(
                topic: 'Traders Community', 
                onPress: (){}, 
                imageIcon: 'assets/image/trader_icon.png'
              ),
              Divider(thickness: 1, color: grey.shade300, height: 0, indent: 50),
          
              SettingsDetails(
                topic: 'XXX Algo Trading', 
                onPress: (){}, 
                imageIcon: 'assets/image/telegram_icon.png'
              ),
              Divider(thickness: 1, color: grey.shade300, height: 0, indent: 50),
              const SizedBox(height: 30),

              SettingsDetails(
                topic: 'OTP', 
                onPress: (){}, 
                imageIcon: 'assets/image/lock_icon2.jpg'
              ),
              Divider(thickness: 1, color: grey.shade300, height: 0, indent: 50),
          
              SettingsDetails(
                topic: 'Interface', 
                onPress: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context)=> const LanguagesPage(),
                    ),
                  );
                }, 
                imageIcon: 'assets/image/translate_icon.png'
              ),
              Divider(thickness: 1, color: grey.shade300, height: 0, indent: 50),
          
              SettingsDetails(
                topic: 'Charts', 
                onPress: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context)=> const ChartSettings(),
                    ),
                  );
                }, 
                imageIcon: 'assets/image/trading_icon.png'
              ),
              Divider(thickness: 1, color: grey.shade300, height: 0, indent: 50),
          
              SettingsDetails(
                topic: 'Journal', 
                onPress: (){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => const JournalPage()),
                  );
                }, 
                imageIcon: 'assets/image/journal_icon.jpg'
              ),
              Divider(thickness: 1, color: grey.shade300, height: 0, indent: 50),
          
              SettingsDetails(
                topic: 'Settings', 
                onPress: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context)=> const GeneralSettings(),
                    ),
                  );
                }, 
                imageIcon: 'assets/image/setting_icon.png'
              ),
              Divider(thickness: 1, color: grey.shade300, height: 0, indent: 50),
              const SizedBox(height: 30),
          
                
            ],
          ),
        ),
      ),


    );
  }



}