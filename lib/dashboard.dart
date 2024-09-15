import 'package:flutter/material.dart';
import 'package:qxchange/home.dart';
import 'package:qxchange/profile.dart';
import 'package:qxchange/history.dart';
import 'package:iconsax/iconsax.dart';

import 'colors.dart' as color;

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final String message = '';
  int myIndex = 0;
  List<Widget> widgetList = const [Home(), History(), Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => {
          setState(() {
            myIndex = index;
          })
        },
        currentIndex: myIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              size: 18,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.note_outlined,
              size: 20,
            ),
            label: 'History',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
                size: 18,
              ),
              label: 'Account'),
        ],
        selectedItemColor: Colors.black, // Set selected item color
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true, // Set unselected item color
      ),
      body: IndexedStack(
        children: widgetList,
        index: myIndex,
      ),
    );
  }
}
