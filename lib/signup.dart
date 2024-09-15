import 'package:email_validator/email_validator.dart';
import 'package:qxchange/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qxchange/signup.dart';
import 'package:qxchange/moreinfo.dart';
import 'package:iconsax/iconsax.dart';
import 'package:qxchange/dashboard.dart';
import 'package:qxchange/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'colors.dart' as color;

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //_showUsernameDialog();
  }

  Future<void> _saveUsername() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', usernameController.text);
  }

  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  Route _createFadeRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const Login(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  void _handleTextTap(BuildContext context) {
    print('Text is tapped!');
    Navigator.push(
      context,
      _createFadeRoute(),
    );
  }

  @override
  Widget build(BuildContext context) {
    navigatorKey:
    navigatorKey;
    return Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                return MoreInfo();
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding:
                          const EdgeInsets.only(left: 25, top: 80, right: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Create Account",
                            style: GoogleFonts.poppins(
                                fontSize: 22, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 0,
                          ),
                          Text(
                            "Enter your email address and password to create an account",
                            style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: Colors.grey,
                                fontWeight: FontWeight.w300),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 4, top: 0, right: 12),
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 240, 240, 240),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: TextFormField(
                                    controller: usernameController,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                    ),
                                    decoration: const InputDecoration(
                                      hintText: 'Enter your Name',
                                      labelText: 'Name',
                                      prefixIcon: Icon(
                                        Icons.person_outlined,
                                        size: 18,
                                      ),
                                      labelStyle: TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                      border: InputBorder.none,
                                    ),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) =>
                                        value != null && value.length < 6
                                            ? 'Required'
                                            : null,
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 4, top: 0, right: 12),
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 240, 240, 240),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: TextFormField(
                                    controller: emailController,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                    ),
                                    decoration: const InputDecoration(
                                      hintText: 'Enter your email address',
                                      labelText: 'Email',
                                      prefixIcon: Icon(
                                        Icons.mail_outline,
                                        size: 18,
                                      ),
                                      labelStyle: TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                      border: InputBorder.none,
                                    ),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (email) => email != null &&
                                            !EmailValidator.validate(email)
                                        ? 'Enter a valid email'
                                        : null,
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 4, top: 0, right: 12),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 240, 240, 240),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextFormField(
                                    controller: passwordController,
                                    obscureText: true,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                    ),
                                    decoration: const InputDecoration(
                                      hintText: '*******',
                                      prefixIcon: Icon(
                                        Icons.lock_outline,
                                        size: 18,
                                      ),
                                      labelText: 'Password',
                                      labelStyle: TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                      border: InputBorder.none,
                                    ),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) =>
                                        value != null && value.length < 6
                                            ? 'Required'
                                            : null,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                child: ElevatedButton(
                                    onPressed: signUp,
                                    style: ElevatedButton.styleFrom(
                                        primary: Color(0xFF00B807),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    child: Text(
                                      "Sign up",
                                      style: GoogleFonts.poppins(
                                          fontSize: 12, color: Colors.white),
                                    )),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                  child: InkWell(
                                onTap: () => _handleTextTap(context),
                                child: Text(
                                  "Already have an account?",
                                  style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400),
                                ),
                              )),
                              Center(
                                  child: InkWell(
                                onTap: () => _handleTextTap(context),
                                child: Text(
                                  " click here to sign in ",
                                  style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      color: Color(0xFF00B807),
                                      fontWeight: FontWeight.w400),
                                ),
                              )),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }));
  }

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', usernameController.text);

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      Navigator.pop(context);

      final currentState = navigatorKey.currentState;
      if (currentState != null) {
        currentState.popUntil((route) => route.isFirst);
      }
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }
  }
}
