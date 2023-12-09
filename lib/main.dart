import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lending_management/LogIn_Page/loanPage.dart';
import 'package:lending_management/Menu_Page/menupage.dart';
import 'package:lending_management/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/menuPage': (context) => const MenuPage(),
      },
      home: const LoanPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
