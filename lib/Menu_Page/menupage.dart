import "package:flutter/material.dart";
import "package:lending_management/Menu_Page/menuButton.dart";

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 124, 209, 141),
        title: const Text('Hello'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Logout'),
              onTap: (){
                Navigator.of(context).pushReplacementNamed('/loginPage');
              },
            )
          ],
        )
      ),
      body: const Center(
        child: FittedBox(
          fit: BoxFit.contain,
          child: Column(
            children: [
              //Buttons
              MenuButton(text: 'Scan', nextPage: '',),
              SizedBox(
                  //SPACING
                  height: 20,
              ),
              MenuButton(text: 'Add', nextPage: '/addPage'),
            ],
          ),
        ),
      ),
    );
  }
}
