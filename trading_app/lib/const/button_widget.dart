import 'package:flutter/material.dart';
import 'package:trading_app/const/textstyle.dart';

import 'constant.dart';

class RedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const RedButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith((states) => Colors.red),
        fixedSize: MaterialStateProperty.all<Size>(const Size.fromHeight(10)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        ),
      ), 
      child: Text(text, style: bodySRegular),
    );
  }
}


class BlueButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const BlueButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith((states) => blue.shade400),
        fixedSize: MaterialStateProperty.all<Size>(const Size.fromHeight(10)),
         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        ),
      ), 
      child: Text(text, style: bodySRegular),
    );
  }
}

class GreyButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const GreyButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith((states) => grey.shade600),
        fixedSize: MaterialStateProperty.all<Size>(const Size.fromHeight(10)),
         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        ),
      ), 
      child: Text(text, style: bodySRegular),
    );
  }
}

class BlueButtonWithIcon extends StatelessWidget{
  final VoidCallback onPressed;
  final String text;
  final IconData icon;
  const BlueButtonWithIcon({super.key, required this.onPressed, required this.icon, required this.text});

  @override
  Widget build(BuildContext context){
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith((states) => grey),
      ),
      onPressed: onPressed, 
      icon: Icon(icon, color: blue, size: 15), 
      label: Text(text, style: bodySBold.copyWith(color: blue)),
    );
  }
}