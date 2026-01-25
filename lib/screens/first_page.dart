import 'package:demo_app/screens/home_page.dart';
import 'package:demo_app/screens/setting_page.dart';
import 'package:flutter/material.dart';
import '../controllers/ssh_controller.dart';
import '../controllers/settings_controller.dart';
import '../services/lg_service.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  
  int selectedIndex = 0;
  final SettingsController controller = SettingsController();
  final SshController sshController = SshController();


  late final List<Widget Function()> _pageBuilders;

  @override
  void initState() {
    super.initState();

    _pageBuilders = [
      () => HomePage(sshController: sshController),
      () => SettingPage(controller: controller, sshController: sshController),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 35, 35, 35),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "LG Controller for GSoC 2026",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: _pageBuilders[selectedIndex](),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        unselectedIconTheme: IconThemeData(opacity: 0.6),
        selectedIconTheme: IconThemeData(opacity: 1, size: 30),
        currentIndex: selectedIndex,
        backgroundColor: Color.fromARGB(255, 35, 35, 35),
        onTap: (i) => setState(() => selectedIndex = i),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white,),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: Colors.white,),
            label: "Settings",
            
          ),
        ],
      )
    );
  }
}