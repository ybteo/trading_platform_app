import 'package:flutter/material.dart';
import 'package:trading_app/const/constant.dart';
import 'package:trading_app/const/textstyle.dart';

class SettingsDetails extends StatelessWidget {
  final String topic;
  final String imageIcon;
  final VoidCallback onPress;
  const SettingsDetails({
    super.key,
    required this.topic,
    required this.onPress,
    required this.imageIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: ListTile(
        onTap: onPress,
        // tileColor: Colors.white,
        leading: Image.asset(imageIcon, width: 20, height: 20),
        title: Text(topic, style: bodyMRegular),
        trailing: Icon(Icons.keyboard_arrow_right, size: 20, color: grey.shade600),
      ),
    );
  }
}