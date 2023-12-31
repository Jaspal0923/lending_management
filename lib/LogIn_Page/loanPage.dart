import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lending_management/LogIn_Page/text_field.dart';

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

  void signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _userController.text,
        password: _passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      // Handle the error, e.g., show an error message
      switch (e.code) {
      case 'invalid-email':
        showErrDialog(context, e.code);
        break;
      case 'wrong-password':
        showErrDialog(context, e.code);
        break;
      case 'user-not-found':
        showErrDialog(context, e.code);
        break;
      case 'user-disabled':
        showErrDialog(context, e.code);
        break;
    } 
    }
  }

  showErrDialog(BuildContext context, String err) {
    FocusScope.of(context).requestFocus(new FocusNode());
    return showDialog(
      context: context,
      builder: (context)=>AlertDialog(
        title: const Text("Error"),
        content: Text(err),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Ok"),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(20),
            child: Form(
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
                    height: 35,
                  ),
                  //UserName Field
                  TextField_LogIn(
                      textEditingController: _userController,
                      hintText: 'Enter Username',
                      textInputType: TextInputType.emailAddress),
              
                  const SizedBox(
                    //SPACING
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
                        signIn();
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
                        duration: const Duration(milliseconds: 100),
                        child: const Text(
                          'LogIn', //
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )));
  }
}
