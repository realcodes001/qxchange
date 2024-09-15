import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'colors.dart' as color;
import 'confirmcode.dart';

class CreatePasscode extends StatefulWidget {
  const CreatePasscode({Key? key}) : super(key: key);

  @override
  _CreatePasscodeState createState() => _CreatePasscodeState();
}

class _CreatePasscodeState extends State<CreatePasscode> {
  String passcode = '';
  int currentIndex = -1;

  void addToPasscode(String digit) {
    if (passcode.length < 4) {
      setState(() {
        passcode += digit;
        currentIndex = passcode.length - 1;
      });

      // Hide the digit after a short delay
      Timer(const Duration(milliseconds: 500), () {
        setState(() {
          currentIndex = -1;
        });
      });
    }

    // Navigate to confirm passcode page if 4 digits are entered
    if (passcode.length == 4) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ConfirmPasscode(enteredPasscode: passcode),
        ),
      );
    }
  }

  void deleteDigit() {
    setState(() {
      if (passcode.isNotEmpty) {
        passcode = passcode.substring(0, passcode.length - 1);
        currentIndex = -1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 20, top: 30, right: 20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Create Passcode',
                                style: GoogleFonts.poppins(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Display the passcode with borders
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(4, (index) {
                          bool isActive = index == passcode.length;
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 6.0),
                            padding: const EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: isActive
                                    ? Color(0xFF00B807)
                                    : Color.fromARGB(255, 212, 212, 212),
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: Text(
                              index < passcode.length
                                  ? (index == currentIndex
                                      ? passcode[index]
                                      : '*')
                                  : '',
                              style: const TextStyle(fontSize: 24),
                            ),
                          );
                        }),
                      ),
                    ),
                    // Custom keypad
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              KeypadButton(
                                  digit: '1', onPressed: addToPasscode),
                              const SizedBox(width: 20),
                              KeypadButton(
                                  digit: '2', onPressed: addToPasscode),
                              const SizedBox(width: 20),
                              KeypadButton(
                                  digit: '3', onPressed: addToPasscode),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              KeypadButton(
                                  digit: '4', onPressed: addToPasscode),
                              const SizedBox(width: 20),
                              KeypadButton(
                                  digit: '5', onPressed: addToPasscode),
                              const SizedBox(width: 20),
                              KeypadButton(
                                  digit: '6', onPressed: addToPasscode),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              KeypadButton(
                                  digit: '7', onPressed: addToPasscode),
                              const SizedBox(width: 20),
                              KeypadButton(
                                  digit: '8', onPressed: addToPasscode),
                              const SizedBox(width: 20),
                              KeypadButton(
                                  digit: '9', onPressed: addToPasscode),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 70,
                              ),
                              const SizedBox(width: 20),
                              KeypadButton(
                                  digit: '0', onPressed: addToPasscode),
                              const SizedBox(width: 20),
                              Container(
                                height: 80,
                                width: 80,
                                child: ElevatedButton(
                                  onPressed: deleteDigit,
                                  child: const Text(
                                    'Del',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Visibility(
                            visible: false,
                            child: Container(
                              height: 70,
                              width: 70,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                                child: Icon(Icons.history),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
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

class KeypadButton extends StatelessWidget {
  final String digit;
  final Function(String) onPressed;

  KeypadButton({required this.digit, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          primary: Color.fromARGB(255, 239, 239, 239),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        onPressed: () => onPressed(digit),
        child: Text(
          digit,
          style: GoogleFonts.poppins(color: Colors.black, fontSize: 20),
        ),
      ),
    );
  }
}
