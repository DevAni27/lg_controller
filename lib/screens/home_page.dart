// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '../controllers/ssh_controller.dart';

class HomePage extends StatefulWidget {
  final SshController sshController;
  const HomePage({super.key, required this.sshController});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  
  

  void flyhome() async {
    print("path✅");

    try {
      final res = await widget.sshController.runCommand("""
        echo "flytoview=<gx:duration>1.2</gx:duration><gx:flyToMode>smooth</gx:flyToMode><LookAt><longitude>73.8786</longitude><latitude>18.5246</latitude><range>8000</range><tilt>0</tilt><heading>0</heading><gx:altitudeMode>relativeToGround</gx:altitudeMode></LookAt>" > /tmp/query.txt
        
        """);
      print(res);
      
    } catch (e) {
      print("FlyHome error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //lg logo maybe

            //Fly to home button
            ElevatedButton(
              onPressed: () {
                flyhome();
              },
              
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 35, 35, 35),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 84),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min, // Essential to prevent the Row from taking full width
                children: [
                  Text("Fly to Home", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),),
                  SizedBox(width: 20),
                  Icon(Icons.flight, size: 30, color: Colors.white,), // The icon
                   
                ],
              ),
                           
            ),
            SizedBox(height: 30,),

            Divider(
              color: Colors.grey,
              thickness: 1,
              height: 20,
            ),

            SizedBox(height: 30,),

            Text("Liquid Galaxy Services", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),),

            //Show logo
            SizedBox(height: 20,),
            
            ElevatedButton(
              onPressed: () {
                // add function
                
              },
              
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 35, 35, 35),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 84),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min, // Essential to prevent the Row from taking full width
                children: [
                  Text("Show LG Logo", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),),
                  SizedBox(width: 20),
                  Icon(Icons.photo, size: 26, color: Colors.white,), // The icon
                   
                ],
              ),
                           
            ),


            //Send Pyramid KML
            SizedBox(height: 20,),
            
            ElevatedButton(
              onPressed: () {
                // add function
              },
              
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 35, 35, 35),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 84),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min, // Essential to prevent the Row from taking full width
                children: [
                  Text("Send Pyramid", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),),
                  SizedBox(width: 20),
                  Icon(Icons.send, size: 26, color: Colors.white,), // The icon
                   
                ],
              ),
                           
            ),

            SizedBox(height: 20,),
            //Clean logo
            ElevatedButton(
              onPressed: () {
                // add function
              },
              
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 35, 35, 35),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 84),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min, // Essential to prevent the Row from taking full width
                children: [
                  Text("Clean Logo", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),),
                  SizedBox(width: 20),
                  Icon(Icons.delete, size: 26, color: Colors.white,), // The icon
                   
                ],
              ),
                           
            ),

            SizedBox(height: 20,),

            //Clean KML
            ElevatedButton(
              onPressed: () {
                // add function
              },
              
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 35, 35, 35),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 84),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min, // Essential to prevent the Row from taking full width
                children: [
                  Text("Clean KML", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),),
                  SizedBox(width: 20),
                  Icon(Icons.cleaning_services, size: 26, color: Colors.white,), // The icon
                   
                ],
              ),
                           
            )
          ],
        ),
      ),
      

    );
  }
}