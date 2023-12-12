import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key, required this.docID});
  final String docID;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('$docID'),
      ),
    );
  }
}