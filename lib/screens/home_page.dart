import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  


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
                  Text("Fly to Home", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),),
                  SizedBox(width: 20),
                  Icon(Icons.flight, size: 30, color: Colors.white,), // The icon
                   
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
                  Icon(Icons.clear, size: 30, color: Colors.white,), // The icon
                   
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
                  Icon(Icons.cleaning_services, size: 30, color: Colors.white,), // The icon
                   
                ],
              ),
                           
            )
          ],
        ),
      ),
      

    );
  }
}