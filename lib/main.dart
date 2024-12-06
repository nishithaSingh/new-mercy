import 'dart:async';


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'auth/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Merciful Hands',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(), // Set SplashScreen as the initial screen
    );
  }
}


class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Start a timer to navigate to the SignInPage after 5 seconds
    Future.delayed(const Duration(seconds: 7), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'All Glory to God',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red, // Set the text color to red
              ),
            ),
            SizedBox(height: 20),
            Image.asset(
              'assets/hands.jpg', // Replace with your image asset path
              height: 250, // Adjust the height as needed
            ),
          
           
            SizedBox(height: 20),
            Text(
  'Matthew 10:8',
  style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.red, // Set the text color to red
    letterSpacing: 2.0,
  ),
),
SizedBox(height: 20),
Text(
  '“Heal the sick, cleanse the lepers, raise the dead, cast out devils: freely ye have received, freely give.”',
  style: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.white, // Set the text color to white
    fontStyle: FontStyle.italic,
  ),
  textAlign: TextAlign.center,
),

          ],
        ),
      ),
    );
  }
}
