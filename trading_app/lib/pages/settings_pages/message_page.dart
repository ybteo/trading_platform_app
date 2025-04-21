import 'package:flutter/material.dart';
import 'package:trading_app/const/constant.dart';
import 'package:trading_app/const/textstyle.dart';
import 'package:trading_app/pages/settings_pages/message_chat.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(//link to chat and message page
        title: const Text('Messages and Chats', style: bodyMBold),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left, size: 30, color: blue),
          onPressed: (){
            Navigator.pop(context);
          },
        ), 
      ),

      body: ListView(
        children: [
          const SizedBox(height: 10),
          Divider(thickness: 1, height: 0, color: grey.shade300),
          _chatDisplay('Friend A', 'How\'s it going?'),
          _chatDisplay('Friend B', 'Hi'),
          _chatDisplay('Trade Club', 'Latest trading news: ...'),

        ],
      )
    );
  }

  //widget for chat display 

  Widget _chatDisplay(String title, String latestMessage){
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundColor: blue.shade400,
            child: const Icon(Icons.person, color: Colors.white),
            
          ),
          title: Text(title, style: bodyMBold),
          subtitle: Text(latestMessage, style: bodySRegular),
          onTap: () {
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context)=> const MessageAndChatPage(),
              ),
            );
          },
        ),
        Divider(thickness: 1, height: 0, color: grey.shade300),
      ],
    );
  }




}