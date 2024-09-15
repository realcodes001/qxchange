import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:qxchange/signup.dart';
import 'package:qxchange/dashboard.dart';
import 'package:qxchange/forgotpassword.dart';
import 'screens/screen1.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/screen2.dart';
import 'screens/screen3.dart';
import 'colors.dart' as color;

class Onboard extends StatefulWidget {
  const Onboard({Key? key}) : super(key: key);

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  void dispose() {
    super.dispose();
  }

  PageController pageController = PageController();
  String buttonText = "skip";
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    navigatorKey:
    navigatorKey;

    return Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Dashboard();
              }
              return Stack(
                children: [
                  PageView(
                    controller: pageController,
                    onPageChanged: (index) {
                      currentPageIndex = index;
                      if (index == 2) {
                        buttonText = 'Done';
                      } else {
                        buttonText = 'Skip';
                      }
                      setState(() {});
                    },
                    children: [Screen1(), Screen2(), Screen3()],
                  ),
                  Container(
                      alignment: Alignment(0, 0.8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Register(),
                                  ),
                                );
                              },
                              child: Text(
                                '$buttonText',
                                style: GoogleFonts.poppins(),
                              )),
                          SmoothPageIndicator(
                              controller: pageController,
                              count: 3,
                              effect: WormEffect(
                                  dotWidth: 8,
                                  dotHeight: 8,
                                  dotColor: Color.fromARGB(255, 221, 221, 221),
                                  activeDotColor: const Color(0xFF00B807))),
                          currentPageIndex == 2
                              ? const SizedBox(
                                  width: 10,
                                )
                              : GestureDetector(
                                  onTap: () {
                                    pageController.nextPage(
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.easeIn);
                                  },
                                  child: Text(
                                    'Next',
                                    style: GoogleFonts.poppins(),
                                  ))
                        ],
                      ))
                ],
              );
            }));
  }
}
