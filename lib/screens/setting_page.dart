import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
          
              //connected status
              Container(
                height: 50,
                width: 180,
                margin: EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 35, 35, 35),
                  borderRadius: BorderRadius.circular(50)
                ),
                child: Center(
                  child: Text(
                    "Disconnected",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
          
              //Username
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter Username",
                  hintStyle: TextStyle(color: Colors.white70, fontWeight: FontWeight.w400),
                  filled: true,
                  fillColor: Color.fromARGB(255, 35, 35, 35),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  
                ),
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              ),
          
              //ip address
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "IP Address",
                  hintStyle: TextStyle(color: Colors.white70, fontWeight: FontWeight.w400),
                  filled: true,
                  fillColor: Color.fromARGB(255, 35, 35, 35),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              ),
          
              //Port number
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Port Number(22)",
                  hintStyle: TextStyle(color: Colors.white70, fontWeight: FontWeight.w400),
                  filled: true,
                  fillColor: Color.fromARGB(255, 35, 35, 35),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              ),
          
              //password
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter Password",
                  hintStyle: TextStyle(color: Colors.white70, fontWeight: FontWeight.w400),
                  filled: true,
                  fillColor: Color.fromARGB(255, 35, 35, 35),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              ),
          
              //number of rigs
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Number of Rigs",
                  hintStyle: TextStyle(color: Colors.white70, fontWeight: FontWeight.w400),
                  filled: true,
                  fillColor: Color.fromARGB(255, 35, 35, 35),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              ),
          
              //connect button
              ElevatedButton(
                onPressed: () {
                  // add function
                },
                
                style: ElevatedButton.styleFrom(
                  backgroundColor:  const Color.fromARGB(255, 9, 152, 14),
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 70),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                  
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min, // Essential to prevent the Row from taking full width
                  children: [
                    Text("Connect", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),),
                    SizedBox(width: 14),
                    Icon(Icons.connected_tv, size: 30, color: Colors.white,), // The icon
                     
                  ],
                ),
                             
              ),
            ],
          ),
        ),
      ),
    );
  }
}