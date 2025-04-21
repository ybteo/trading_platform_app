import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trading_app/const/constant.dart';
import 'package:trading_app/const/textstyle.dart';
import 'package:trading_app/pages/settings_pages/chart_bubble.dart';

class MessageAndChatPage extends StatefulWidget {
  const MessageAndChatPage({super.key});

  @override
  State<MessageAndChatPage> createState() => _MessageAndChatPageState();
}

class _MessageAndChatPageState extends State<MessageAndChatPage> {
  bool isTyping = false;
  ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> _messages = [];
  TextEditingController textController = TextEditingController();

  void sendMessage(){
    String message = textController.text.trim();
    if(message.isEmpty) return;


    setState(() {
      _messages.add({
        'message': message, 'isSentByMe':true,
      });
      isTyping = true;
    });


    textController.clear();
    Timer(const Duration(seconds: 2), (){
      setState(() {
        isTyping = false;
        _messages.add({
          'message': 'Your friend\'s auto-generated reply',
          'isSentByMe': false,
        });

      });
    });
  }

  void scrollToBottom(){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(_scrollController.hasClients){
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent, 
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Message inbox', style: bodyMBold),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          }, 
          icon: Icon(Icons.keyboard_arrow_left, color: blue, size: 20),
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index){
                return ChatBubble(
                  message: _messages[index]['message'],
                  isSentByMe: _messages[index]['isSentByMe'],
                );
              },
            ),
          ),
          if(isTyping)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Your friend is typing...', style: bodySRegular),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textController,
                      decoration: const InputDecoration(
                        hintText: 'Enter a message...',
                        border: OutlineInputBorder(),
                      ),
                      minLines: 1,
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                    ),
                  ),
                  IconButton(
                    onPressed: sendMessage, 
                    icon: Icon(Icons.send, color: blue, size: 20)
                  ),
                ],
              ),
            ),
            

        ],
      ),


    );
  }


  //message chat widget


}
