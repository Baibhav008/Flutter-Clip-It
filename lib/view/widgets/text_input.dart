import 'package:clip_it/constants.dart';
import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {

  final TextEditingController controller;
  final IconData myIcon;
  final String myLabelText;
  final bool toHide;

   TextInputField({super.key, required this.controller, required this.myIcon, required this.myLabelText, this.toHide=false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: toHide,
      controller: controller,
      decoration:
      InputDecoration(
          icon: Icon(myIcon),
      labelText: myLabelText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: borderColor),

        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: borderColor),

        )
      ),

    );
  }
}

