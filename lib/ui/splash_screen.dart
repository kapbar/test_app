import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/auth/auth_service.dart';
import 'package:test_app/ui/login_screen.dart';
import 'package:test_app/ui/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void getIsSave() async {
    final SharedPreferences prefs = await AuthService.prefs;
    final bool? isSave = prefs.getBool('isSave');
    Timer(
      const Duration(seconds: 3),
      () {
        if (isSave == true) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MainScreen()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getIsSave();
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/apiens6.jpg',
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.cover,
    );
  }
}
