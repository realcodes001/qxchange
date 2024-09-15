import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'colors.dart' as color;

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({Key? key}) : super(key: key);

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  final List<String> _gender = ['Male', 'Female'];
  String? _selectedGender;

  final List<String> _religion = ['Christian', 'Islam', 'Others'];
  String? _selectedReligion;

  final List<String> _statez = [
    'Abia',
    'Adamawa',
    'Akwa Ibom',
    'Anambra',
    'Bauchi',
    'Bayelsa',
    'Benue',
    'Borno',
    'Cross River',
    'Delta',
    'Ebonyi',
    'Edo',
    'Ekiti',
    'Enugu',
    'FCT - Abuja',
    'Gombe',
    'Imo',
    'Jigawa',
    'Kaduna',
    'Kano',
    'Katsina',
    'Kebbi',
    'Kogi',
    'Kwara',
    'Lagos',
    'Nasarawa',
    'Niger',
    'Ogun',
    'Ondo',
    'Osun',
    'Oyo',
    'Plateau',
    'Rivers',
    'Sokoto',
    'Taraba',
    'Yobe',
    'Zamfara'
  ];
  String? _selectedStatez;
  String? username;
  String? profileImageUrl;

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedGender = prefs.getString('gender') ?? '';
      _selectedReligion = prefs.getString('religion') ?? '';
      _selectedStatez = prefs.getString('state') ?? '';
      _phoneController.text = prefs.getString('phone') ?? '';
      usernameController.text = prefs.getString('username') ?? '';
      username = prefs.getString('username');
      profileImageUrl = prefs.getString('profileImageUrl');
    });
  }

  Future<void> _saveData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('gender', _selectedGender ?? '');
    await prefs.setString('religion', _selectedReligion ?? '');
    await prefs.setString('state', _selectedStatez ?? '');
    await prefs.setString('phone', _phoneController.text);
    await prefs.setString('username', usernameController.text);
    if (profileImageUrl != null) {
      await prefs.setString('profileImageUrl', profileImageUrl!);
    }

    await _saveDataToFirestore();
  }

  Future<void> _saveDataToFirestore() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final uid = user.uid;
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'username': usernameController.text,
          'gender': _selectedGender,
          'religion': _selectedReligion,
          'state': _selectedStatez,
          'phone': _phoneController.text,
          'profileImageUrl': profileImageUrl,
        }, SetOptions(merge: true));
        print("Data saved to Firestore successfully.");
      } else {
        print("No user is currently signed in.");
      }
    } catch (e) {
      print("Error saving data to Firestore: $e");
    }
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final uid = user.uid;
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('profile_pictures')
            .child('$uid.jpg');

        // Show the dialog
        _showUploadingDialog();

        final uploadTask = storageRef.putFile(File(pickedFile.path));

        final snapshot = await uploadTask;
        final downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          profileImageUrl = downloadUrl;
        });

        // Dismiss the dialog
        Navigator.of(context).pop();

        await _saveDataToFirestore();
      }
    }
  }

  void _showUploadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                const SizedBox(width: 16),
                Text(
                  "Uploading...",
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool _isVisible = true;
  bool _isLoading = false; // Track loading state

  void _showLoading() {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        _isLoading = false;
      });
      _showMethod();
    });
  }

  void _showMethod() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding:
                            const EdgeInsets.only(left: 25, top: 50, right: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: 30,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: color.AppColor.lightgray),
                                child: const Center(
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Profile",
                              style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 1),
                            Text(
                              "Your profile tells us more about you and how to serve you better",
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w300),
                            ),
                            const SizedBox(height: 30),
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 246, 246, 246),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: _pickImage,
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.grey),
                                      child: CircleAvatar(
                                        radius: 50,
                                        backgroundImage: profileImageUrl != null
                                            ? NetworkImage(profileImageUrl!)
                                            : const NetworkImage(
                                                'https://img.freepik.com/free-psd/3d-render-avatar-character_23-2150611762.jpg?t=st=1719425581~exp=1719429181~hmac=deccf9e079fa8129155e405e9810a7f84c25e3d89d03e837eb597cdbe425a463&w=1060'),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          username ?? 'No username entered',
                                          style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          'Profile',
                                          style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.grey),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 12, top: 0, right: 12),
                              decoration: BoxDecoration(
                                  color: color.AppColor.lightgray,
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextFormField(
                                controller: usernameController,
                                style: GoogleFonts.poppins(fontSize: 14),
                                decoration: const InputDecoration(
                                  hintText: 'Enter your fullname',
                                  labelText: 'Fullname',
                                  labelStyle: TextStyle(
                                      fontSize: 14, color: Colors.grey),
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
                            const SizedBox(height: 30),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: color.AppColor.lightgray),
                              child: InputDecorator(
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  border: InputBorder.none,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        hint: Text(
                                          "Select your gender",
                                          style: GoogleFonts.poppins(
                                              color: Colors.grey),
                                        ),
                                        value: _selectedGender,
                                        icon: const Icon(Icons.arrow_drop_down),
                                        iconSize: 24,
                                        elevation: 16,
                                        style: GoogleFonts.poppins(
                                            color: Colors.black),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            _selectedGender = newValue;
                                          });
                                        },
                                        items: _gender
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: color.AppColor.lightgray),
                              child: InputDecorator(
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  border: InputBorder.none,
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    hint: Text(
                                      "Select a religion",
                                      style: GoogleFonts.poppins(
                                          color: Colors.grey),
                                    ),
                                    value: _selectedReligion,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    iconSize: 24,
                                    elevation: 16,
                                    style: const TextStyle(color: Colors.black),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedReligion = newValue;
                                      });
                                    },
                                    items: _religion
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: GoogleFonts.poppins(
                                              color: Colors.black),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: color.AppColor.lightgray),
                              child: InputDecorator(
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  border: InputBorder.none,
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    hint: Text(
                                      "Select your state",
                                      style: GoogleFonts.poppins(
                                          color: Colors.grey),
                                    ),
                                    value: _selectedStatez,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    iconSize: 24,
                                    elevation: 16,
                                    style: const TextStyle(color: Colors.black),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedStatez = newValue;
                                      });
                                    },
                                    items: _statez
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: GoogleFonts.poppins(
                                              color: Colors.black),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 12, top: 0, right: 12),
                              decoration: BoxDecoration(
                                  color: color.AppColor.lightgray,
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextFormField(
                                controller: _phoneController,
                                keyboardType: TextInputType.number,
                                style: GoogleFonts.poppins(fontSize: 14),
                                decoration: InputDecoration(
                                  hintText: 'E.g 080',
                                  labelText: 'Phone Number',
                                  labelStyle: GoogleFonts.poppins(
                                      fontSize: 14, color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) =>
                                    value != null && value.length < 10
                                        ? 'Enter a valid phone number'
                                        : null,
                              ),
                            ),
                            const SizedBox(height: 60),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        await _saveData();
                                        _showLoading();
                                      },
                                      style: ElevatedButton.styleFrom(
                                          primary: const Color(0xFF00B807),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      child: Text(
                                        "Submit",
                                        style: GoogleFonts.poppins(
                                            color: Colors.white),
                                      )),
                                ),
                              ],
                            ),
                            const SizedBox(height: 130),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                if (_isLoading)
                  Container(
                    color: Colors.black54,
                    child: Center(
                      child: SpinKitFadingCircle(
                        color: Color.fromARGB(255, 27, 255, 91),
                        size: 50.0,
                      ),
                    ),
                  ),
              ],
            );
          }),
    );
  }
}
