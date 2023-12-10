import 'package:flutter/material.dart';

class addTextField extends StatelessWidget {
  const addTextField(
      {super.key,
      required this.controller,
      required this.hint,
      required this.tit,
      required this.cap});
  final TextEditingController controller;
  final String hint;
  final TextInputType tit;
  final String cap;
  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextFormField(
      decoration: InputDecoration(
          label: Text(cap),
          hintText: hint,
          border: inputBorder,
          focusedBorder: inputBorder,
          enabledBorder: inputBorder,
          filled: true,
          contentPadding: const EdgeInsets.all(10)),
      controller: controller,
      keyboardType: tit,
      validator: (String? text) {
        if (text == null || text.isEmpty) {
          return 'This Field Should Not Be Empty';
        }
        return null;
      },
    );
  }
}
