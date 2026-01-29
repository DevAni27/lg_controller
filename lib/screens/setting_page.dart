// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../controllers/ssh_controller.dart';
import '../controllers/settings_controller.dart';
import '../controllers/home_controller.dart';

class SettingPage extends StatefulWidget {
  final SettingsController controller;
  final SshController sshController;
  final LgController lgController;
  const SettingPage({super.key, required this.controller, required this.sshController, required this.lgController});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  final _usernameController = TextEditingController();
  final _ipController = TextEditingController();
  final _portController = TextEditingController(text: "22");
  final _passwordController = TextEditingController();
  final _rigNumberController = TextEditingController(text: "3");

  
  bool get connected => widget.sshController.isConnected;

  Color get connectedColor => connected ? const Color.fromARGB(255, 91, 248, 96) : Colors.red;
  Text get connectedText => connected ? Text("Connected") : Text("Disconnected");

  void connect() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Connecting...')),
    );

    try{
      await widget.sshController.connect(_ipController.value.text, int.parse(_portController.value.text));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Connected, authenticating...")),
      );
      if(widget.sshController.connection != null){
        try{
          await widget.sshController.authenticate(_usernameController.value.text, _passwordController.value.text);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Authenticated successfully, Rig Connected!!")),
          );
          final res = await widget.sshController.runCommand("hostname");
          print("Connected: $res");

        }
        catch(e){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Authentication failed.")),
          );
        }
      }
    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to connect")),
      );
    }

  }

  Future<void> confirmShutdown(BuildContext context) async {
  final confirm = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Shutdown Liquid Galaxy'),
      content: const Text(
        'This will power off all Liquid Galaxy machines.\n\nAre you sure?',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Shutdown'),
        ),
      ],
    ),
  );

  if (confirm == true) {
    await widget.lgController.shutDownLG(context);
  }
}


  

  @override
  Widget build(BuildContext context) {
    _usernameController.text = widget.controller.lgUsername ?? "";
    _ipController.text = widget.controller.lgIp ?? "";
    _portController.text = widget.controller.lgPort ?? "";
    _passwordController.text = widget.controller.lgPassword ?? "";
    _rigNumberController.text = widget.controller.lgRigsNum ?? "";

    return Scaffold(
      backgroundColor: Color(0xFF121212),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                onChanged: widget.controller.updateLgUsername,
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
                onChanged: widget.controller.updateLgIp,
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
                onChanged: widget.controller.updateLgPort,
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
                onChanged: widget.controller.updateLgPassword,
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
                onChanged: widget.controller.updateLgRigsNum,
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

              Row(spacing: 10, mainAxisAlignment: MainAxisAlignment.center,
                children: [
                //relaunch 
                ElevatedButton(
                onPressed: () async {
                  try{
                    await widget.lgController.relaunchLG(context);
                    
                  }
                  catch(e){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Failed to relaunch LG"))
                    );
                  }
                },

                
                style: ElevatedButton.styleFrom(
                  backgroundColor:  const Color.fromARGB(255, 21, 132, 222),
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 26),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                  
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min, 
                  children: [
                    Text("Relaunch LG", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),),
                    
                    
                     
                  ],
                ),
                             
              ),

                //shutdown
                ElevatedButton(
                onPressed: () => confirmShutdown(context),

                
                style: ElevatedButton.styleFrom(
                  backgroundColor:  const Color.fromARGB(255, 218, 131, 0),
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 26),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                  
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min, 
                  children: [
                    Text("Shutdown LG", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),),
                    
                    
                     
                  ],
                ),
                             
              ),

              ],),

              //Disconnect button

              ElevatedButton(
                onPressed: () {
                  widget.sshController.close();
                  
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