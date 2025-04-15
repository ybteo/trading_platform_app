import 'package:flutter/material.dart';
import 'package:trading_app/const/constant.dart';
import 'package:trading_app/const/textstyle.dart';

class MessageAndChatPage extends StatefulWidget {
  const MessageAndChatPage({super.key});

  @override
  State<MessageAndChatPage> createState() => _MessageAndChatPageState();
}

class _MessageAndChatPageState extends State<MessageAndChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat and Messages', style: bodyMBold),
        leading: IconButton(
          onPressed: (){}, 
          icon: Icon(Icons.keyboard_arrow_left, color: blue, size: 20),
        ),
      ),

      body: Column(
        children: [
          
        ],
      )




    );
  }
}
