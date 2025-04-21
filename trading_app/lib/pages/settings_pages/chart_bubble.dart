import 'package:flutter/material.dart';
import 'package:trading_app/const/constant.dart';
import 'package:trading_app/const/textstyle.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSentByMe;
  const ChatBubble({super.key, required this.message, required this.isSentByMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSentByMe? Alignment.centerRight: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.all(10),
        constraints: const BoxConstraints(maxWidth: 250),
        decoration: BoxDecoration(
          color: isSentByMe? blue: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15),
            topRight: const Radius.circular(15),
            bottomLeft: isSentByMe? const Radius.circular(15): Radius.zero,
            bottomRight: isSentByMe? Radius.zero: const Radius.circular(15),
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
            ),
          ],

        ),
        child: Text(
          message, style: bodyMRegular.copyWith(color: isSentByMe? Colors.white: Colors.black),
          softWrap: true,
        ),
        
      ),
      
    );
  }
}