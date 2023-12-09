import 'package:flutter/material.dart';
import 'package:lending_management/LogIn_Page/text_field.dart';
import 'package:lending_management/Menu_Page/menupage.dart';

class LoanPage extends StatefulWidget {
  const LoanPage({super.key});

  @override
  State<LoanPage> createState() => _LoanPageState();
}

class _LoanPageState extends State<LoanPage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPressed = false;
  bool _isHovered = false;

  void dispose() {
    super.dispose();
    _userController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,

              //Login Forms
              children: [
                //add flexible to create spacing
                Flexible(
                  flex: 2,
                  child: Container(),
                ),
                const Text(
                  'LOGIN',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  //Sa SizedBox ang e butang mga fields
                  height: 35,
                ),
                //UserName Field
                TextField_LogIn(
                    textEditingController: _userController,
                    hintText: 'Enter Username',
                    textInputType: TextInputType.text),

                const SizedBox(
                  //SPACING
                  //Sa SizedBox ang e butang mga fields
                  height: 20,
                ),
                //Password Field
                TextField_LogIn(
                  textEditingController: _passwordController,
                  hintText: 'Enter Password',
                  textInputType: TextInputType.text,
                  isPass: true,
                ),

                const SizedBox(
                  //SPACING
                  //Sa SizedBox ang e butang mga fields
                  height: 20,
                ),

                //Login Button
                MouseRegion(
                  onEnter: (_) {
                    setState(() => _isHovered = true);
                  },
                  onExit: (_) {
                    setState(() => _isHovered = false);
                  },
                  cursor: _isHovered
                      ? SystemMouseCursors.click
                      : SystemMouseCursors.basic,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed('/menuPage');
                    },
                    onTapDown: (_) => setState(() => _isPressed = true),
                    onTapUp: (_) => setState(() => _isPressed = false),
                    child: AnimatedContainer(
                      //Button
                      decoration: BoxDecoration(
                        color: _isPressed
                            ? Colors.lightBlueAccent.withOpacity(0.98)
                            : Colors.blueAccent,
                      ),
                      width: _isHovered ? 200 : 140,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      duration: const Duration(milliseconds: 200),
                      child: const Text(
                        'LogIn',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )));
  }
}
