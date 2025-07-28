import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'note_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Get.offAll(NoteScreen()); // adjust route
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.network(
          height: 600,
          width: 600,
          "https://media0.giphy.com/media/v1.Y2lkPWVjZjA1ZTQ3bnZtMTZjNmlocDNlNG9odm1zY2tzZmlscXdzdGEwMWw3c3h0bTEwNyZlcD12MV9naWZzX3NlYXJjaCZjdD1n/PjCXGdk2BcUVGJp8p5/200.webp",
        ),
      ),
    );
  }
}
