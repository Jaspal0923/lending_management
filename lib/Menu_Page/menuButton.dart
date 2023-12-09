import 'package:flutter/material.dart';

class MenuButton extends StatefulWidget {
  const MenuButton({
    super.key,
    required this.text,
    required this.nextPage,

  });

  //constructor 
  final String text;
  final String nextPage;

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  //States
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
        color: _isPressed
                            ? Colors.lightBlueAccent.withOpacity(0.99)
                            : Colors.blueAccent,
        borderRadius: BorderRadius.circular(30),
      ),
      width: 150,
      height: 80,
      child: GestureDetector(
        onTap: (){
          //WHERE TO GO
          Navigator.of(context).pushReplacementNamed(widget.nextPage);
        },
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        child: Center(
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}