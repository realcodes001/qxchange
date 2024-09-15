import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qxchange/onboarding.dart';
import 'package:qxchange/onboard.dart';
import 'dart:async';
import 'entercode.dart';
import 'package:qxchange/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'entercode.dart'; // Replace with your actual password page import

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    super.initState();
    _checkPasscodeEnabled();

    // Start a timer to navigate to the next screen after 5 seconds
    Timer(Duration(seconds: 10), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Onboard()),
      );
    });
  }

  Future<void> _checkPasscodeEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    bool isPasscodeEnabled = prefs.getBool('isPasscodeEnabled') ?? false;

    if (isPasscodeEnabled) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => EntryPage()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ScaffoldMessengerKey:
    Utils.messengerKey;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 1,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: 30,
                      height: 30,
                      child: Image.asset('lib/images/logo.png')),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'QuickXchange',
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
