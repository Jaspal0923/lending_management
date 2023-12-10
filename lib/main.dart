import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lending_management/Add_Page/addPage.dart';
import 'package:lending_management/Auth/auth_page.dart';
import 'package:lending_management/LogIn_Page/loanPage.dart';
import 'package:lending_management/Menu_Page/menupage.dart';
import 'package:lending_management/Scan_Page/scanpage.dart';
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
        '/loginPage': (context) => const LoanPage(),
        '/addPage': (context) => const AddPage(),
        '/scanPage': (context) => const ScanPage(),
      },
      home: const AuthPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
