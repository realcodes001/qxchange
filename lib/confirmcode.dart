import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'dashboard.dart';
import 'entercode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'colors.dart' as color;

class ConfirmPasscode extends StatefulWidget {
  final String enteredPasscode; // Receive the entered passcode

  const ConfirmPasscode({Key? key, required this.enteredPasscode})
      : super(key: key);

  @override
  _ConfirmPasscodeState createState() => _ConfirmPasscodeState();
}

class _ConfirmPasscodeState extends State<ConfirmPasscode> {
  String confirmPasscode = '';
  int currentIndex = -1;

  Future<void> _savePasscode(String passcode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved_passcode', passcode);
  }

  void addToConfirmPasscode(String digit) {
    if (confirmPasscode.length < 4) {
      setState(() {
        confirmPasscode += digit;
        currentIndex = confirmPasscode.length - 1;
      });

      // Hide the digit after a short delay
      Timer(const Duration(milliseconds: 500), () {
        setState(() {
          currentIndex = -1;
        });
      });
    }

    // Check if the passcodes match if 4 digits are entered
    if (confirmPasscode.length == 4) {
      if (confirmPasscode == widget.enteredPasscode) {
        // Passcodes match, save to shared preferences
        _savePasscode(confirmPasscode);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Color.fromARGB(255, 243, 255, 243),
              content: Text(
                'New passcode set',
                style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF00B807)),
              )),
        );

        // Navigate to the next page or do something else
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => EntryPage(),
          ),
        );
      } else {
        // Passcodes do not match
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Color.fromARGB(255, 255, 238, 238),
              content: Text(
                'Passcodes do not match. Try again.',
                style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                    color: Color.fromARGB(255, 255, 27, 27)),
              )),
        );

        // Reset the confirm passcode
        setState(() {
          confirmPasscode = '';
        });
      }
    }
  }

  void deleteDigit() {
    setState(() {
      if (confirmPasscode.isNotEmpty) {
        confirmPasscode =
            confirmPasscode.substring(0, confirmPasscode.length - 1);
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
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 30,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: color.AppColor.lightgray,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Confirm Passcode',
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
                          bool isActive = index == confirmPasscode.length;
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
                              index < confirmPasscode.length
                                  ? (index == currentIndex
                                      ? confirmPasscode[index]
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
                                  digit: '1', onPressed: addToConfirmPasscode),
                              const SizedBox(width: 20),
                              KeypadButton(
                                  digit: '2', onPressed: addToConfirmPasscode),
                              const SizedBox(width: 20),
                              KeypadButton(
                                  digit: '3', onPressed: addToConfirmPasscode),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              KeypadButton(
                                  digit: '4', onPressed: addToConfirmPasscode),
                              const SizedBox(width: 20),
                              KeypadButton(
                                  digit: '5', onPressed: addToConfirmPasscode),
                              const SizedBox(width: 20),
                              KeypadButton(
                                  digit: '6', onPressed: addToConfirmPasscode),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              KeypadButton(
                                  digit: '7', onPressed: addToConfirmPasscode),
                              const SizedBox(width: 20),
                              KeypadButton(
                                  digit: '8', onPressed: addToConfirmPasscode),
                              const SizedBox(width: 20),
                              KeypadButton(
                                  digit: '9', onPressed: addToConfirmPasscode),
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
                                  digit: '0', onPressed: addToConfirmPasscode),
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
