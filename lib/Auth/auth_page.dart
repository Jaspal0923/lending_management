import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lending_management/LogIn_Page/loanPage.dart';
import 'package:lending_management/Menu_Page/menupage.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            //login
            if (snapshot.hasData) {
              return const MenuPage();
            }
            //not logged in
            else {
              return const LoanPage();
            }
          },
        ),
      ),
    );
  }
}
