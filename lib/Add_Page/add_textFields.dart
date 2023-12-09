import 'package:flutter/material.dart';
import 'package:lending_management/LogIn_Page/text_field.dart';

class addTextField extends StatelessWidget {
  const addTextField({super.key, required this.controller, required this.hint, required this.tit, required this.cap});
  final TextEditingController controller;
  final String hint;
  final TextInputType tit;
  final String cap;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: Text(cap),
        ),
        Flexible(child: TextField_LogIn(textEditingController: controller, hintText: hint, textInputType: tit),),
      ],
    );
  }
}