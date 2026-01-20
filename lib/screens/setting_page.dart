import 'package:flutter/material.dart';
import '../services/lg_service.dart';

class SettingPage extends StatefulWidget {
  final LGService lgService;
  const SettingPage({super.key, required this.lgService});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  final _usernameController = TextEditingController();
  final _ipController = TextEditingController();
  final _portController = TextEditingController(text: "22");
  final _passwordController = TextEditingController();
  final _rigNumberController = TextEditingController(text: "3");

  
  bool get connected => widget.lgService.isConnected;

  Color get connectedColor => connected ? const Color.fromARGB(255, 91, 248, 96) : Colors.red;
  Text get connectedText => connected ? Text("Connected") : Text("Disconnected");

  void connect() async {
    final host = _ipController.text.trim();
    final port = int.parse(_portController.text.trim());
    final user = _usernameController.text.trim();
    final pass = _passwordController.text.trim();

    final success = await widget.lgService.connect(
      host: host,
      port: port,
      username: user,
      password: pass,
    );

    if (success) {
      final test = await widget.lgService.exec("hostname");
      print("Connected to: $test");

      setState(() {
        connected;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Connected to LG successfully")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Connection failed")),
      );
    }

  }

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
                    connectedText.data!,
                    style: TextStyle(
                      color: connectedColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
          
              //Username
              TextField(
                controller: _usernameController,
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
                controller: _ipController,
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
                controller: _portController,
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
                controller: _passwordController,
                obscureText: true,
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
                controller: _rigNumberController,
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
                  connect();
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

              //Disconnect button

              ElevatedButton(
                onPressed: () {
                  widget.lgService.disconnect();
                  setState(() {});
                  
                },
                
                style: ElevatedButton.styleFrom(
                  backgroundColor:  const Color.fromARGB(255, 205, 35, 23),
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 60),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                  
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min, // Essential to prevent the Row from taking full width
                  children: [
                    Text("Disconnect", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),),
                    SizedBox(width: 14),
                    Icon(Icons.signal_wifi_off, size: 30, color: Colors.white,), // The icon
                    
                     
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