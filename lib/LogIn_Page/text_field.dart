import 'package:flutter/material.dart';

class TextField_LogIn extends StatelessWidget {
  const TextField_LogIn(
      {super.key,
      required this.textEditingController,
      this.isPass = false,
      required this.hintText,
      required this.textInputType});

  //values that needs to be inputed in this class/constructor
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
          hintText: hintText,
          border: inputBorder,
          focusedBorder: inputBorder,
          enabledBorder: inputBorder,
          filled: true,
          contentPadding: const EdgeInsets.all(10)),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}
