import 'package:flutter/material.dart';
import 'package:qxchange/history.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:qxchange/notifications.dart';
import 'package:badges/badges.dart';
import 'bitcoin.dart';
import 'usdt.dart';
import 'usdc.dart';
import 'eth.dart';
import 'package:iconsax/iconsax.dart';
import 'package:iconsax/iconsax.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final PageController _pageController2 = PageController();
  int _currentPage2 = 0;

  void _showCustomDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(100),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            height: 240,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 225, 255, 226),
                        borderRadius: BorderRadius.circular(50)),
                    child: Center(
                        child: Text(
                      'i',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF00B807),
                      ),
                    ))),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Oops",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Your wallet balance is empty. Funds are added to your account after performing a transaction",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFF00B807),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Text(
                          "Got it",
                          style: GoogleFonts.poppins(fontSize: 10),
                        ),
                        onPressed: () {
                          // Handle subscription logic here
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool _isVisible = true;

  void _toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  String? profileImageUrl;
  String? username;

  Future<void> loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username');
      profileImageUrl = prefs.getString('profileImageUrl');
    });
  }

  @override
  void initState() {
    super.initState();
    // Start a timer to navigate to the next screen after 5 seconds
    Future.delayed(Duration(seconds: 5), () {
      // Navigate to the next screen here
      // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => NextScreen()));
    });

    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });

    _pageController2.addListener(() {
      setState(() {
        _currentPage2 = _pageController2.page!.round();
      });
    });

    loadUsername();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 25, top: 50, right: 25),
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.grey),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: profileImageUrl != null
                              ? NetworkImage(profileImageUrl!)
                              : const NetworkImage(
                                  'https://img.freepik.com/free-psd/3d-render-avatar-character_23-2150611762.jpg?t=st=1719425581~exp=1719429181~hmac=deccf9e079fa8129155e405e9810a7f84c25e3d89d03e837eb597cdbe425a463&w=1060'),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              username ?? 'No username entered',
                              style: GoogleFonts.poppins(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'Welcome to QuickXchange !',
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Notifications(),
                            ),
                          );
                        },
                        child: Center(
                          child: Badge(
                            animationType: BadgeAnimationType.scale,
                            badgeColor: Color(0xFF00B807),
                            toAnimate: true,
                            animationDuration:
                                const Duration(microseconds: 250),
                            badgeContent: Text('',
                                style: GoogleFonts.poppins(
                                    color: Colors.white, fontSize: 10)),
                            child: const Icon(
                              Icons.notifications_outlined,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height:
                        100, // Adjust height to fit the containers and indicator
                    child: Column(
                      children: [
                        Expanded(
                          child: PageView(
                            controller: _pageController,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: const BoxDecoration(
                                  //color: Color.fromARGB(255, 250, 114, 114),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 30,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Wallet Balance',
                                                style: GoogleFonts.poppins(
                                                    color: Color.fromARGB(
                                                        255, 165, 165, 165),
                                                    fontSize: 10),
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                  _isVisible
                                                      ? Icons
                                                          .visibility_outlined
                                                      : Icons
                                                          .visibility_off_outlined,
                                                  color: Color.fromARGB(
                                                      255, 189, 189, 189),
                                                  size: 14,
                                                ),
                                                onPressed: _toggleVisibility,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          //color: Colors.amber,
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 20,
                                                height: 20,
                                                padding: EdgeInsets.all(0),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: Image.asset(
                                                    'lib/images/naira2.png'),
                                              ),
                                              Text(
                                                _isVisible ? '0.00' : '*****',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 28,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              _showCustomDialog();
                                            },
                                            child: Container(
                                              height: 30,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Color(0xFF00B807)),
                                                  color: Color(0xFFE8FFE8),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .arrow_circle_down_outlined,
                                                    size: 18,
                                                    color: Color(0xFF00B807),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            'Withdraw',
                                            style: GoogleFonts.poppins(
                                                fontSize: 10,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0)),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Assets',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Bitcoin(),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(18),
                            width: 100,
                            height: 160,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 243, 243, 243),
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  padding: EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.transparent),
                                  child: Image.asset('lib/images/btc.png'),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Bitcoin',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color:
                                              Color.fromARGB(255, 25, 25, 25)),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Convert your bitcoin assets into naira instantly',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10,
                                          color: Color.fromARGB(
                                              255, 167, 167, 167)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        width: 20,
                      ),
                      //second detector
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Ethereum(),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(18),
                            width: 100,
                            height: 160,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 243, 243, 243),
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 25,
                                  height: 25,
                                  padding: EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.white),
                                  child: Image.asset(
                                    'lib/images/eth.png',
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Ethereum',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color:
                                              Color.fromARGB(255, 25, 25, 25)),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Convert your assets into naira instantly',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10,
                                          color: Color.fromARGB(
                                              255, 167, 167, 167)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  Row(
                    children: [
                      //Bitcoin
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Usdt(),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(18),
                            width: 100,
                            height: 160,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 243, 243, 243),
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  padding: EdgeInsets.all(0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.transparent),
                                  child: Image.asset('lib/images/usdt2.png'),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'USDT',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color:
                                              Color.fromARGB(255, 25, 25, 25)),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Convert your tether assets into naira instantly',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10,
                                          color: Color.fromARGB(
                                              255, 167, 167, 167)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        width: 20,
                      ),
                      //Ethereum
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Usdc(),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(18),
                            width: 100,
                            height: 160,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 243, 243, 243),
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.transparent),
                                  child: Image.asset('lib/images/usdt.png'),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'USDC',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color:
                                              Color.fromARGB(255, 25, 25, 25)),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Convert your usdc assets into naira instantly',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10,
                                          color: Color.fromARGB(
                                              255, 167, 167, 167)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  //sized

                  /* SizedBox(
                    height:
                        100, // Adjust height to fit the containers and indicator
                    child: Column(
                      children: [
                        Expanded(
                          child: PageView(
                            controller: _pageController2,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: const BoxDecoration(
                                  //color: Color.fromARGB(255, 250, 114, 114),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 30,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.red.shade100,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Icon(Iconsax.arrow_down_1,
                                                  color: Colors.red, size: 20),
                                              Text(
                                                '0.0%',
                                                style: GoogleFonts.poppins(
                                                    color: Colors.red,
                                                    fontSize: 12),
                                              )
                                            ],
                                          ),
                                        ),
                                        Text(
                                          '0.0001 BTC',
                                          style: GoogleFonts.poppins(
                                              color: Color(0xFF343333),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          '\$ 0.00',
                                          style: GoogleFonts.poppins(
                                              color: Color.fromARGB(
                                                  255, 171, 170, 170),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300),
                                        )
                                      ],
                                    ),
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 254, 231, 230),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: const Icon(
                                        Iconsax.home,
                                        size: 30,
                                        color:
                                            Color.fromARGB(255, 252, 163, 17),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: const BoxDecoration(
                                  // color: Color.fromARGB(255, 109, 236, 113),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 30,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.green.shade100,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Icon(Iconsax.arrow_up_1,
                                                  color: Colors.green,
                                                  size: 20),
                                              Text(
                                                '0.0%',
                                                style: GoogleFonts.poppins(
                                                    color: Colors.green,
                                                    fontSize: 12),
                                              )
                                            ],
                                          ),
                                        ),
                                        Text(
                                          '0.0001 USDT',
                                          style: GoogleFonts.poppins(
                                              color: Color(0xFF343333),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          '\$ 0.00',
                                          style: GoogleFonts.poppins(
                                              color: Color.fromARGB(
                                                  255, 171, 170, 170),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300),
                                        )
                                      ],
                                    ),
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 226, 252, 226),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: const Icon(
                                        Iconsax.dollar_circle,
                                        size: 30,
                                        color: Color.fromARGB(255, 20, 221, 26),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: const BoxDecoration(
                                  //color: Color.fromARGB(255, 122, 212, 250),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 30,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.blue.shade100,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Icon(Iconsax.arrow_down_1,
                                                  color: Colors.blue, size: 20),
                                              Text(
                                                '0.0%',
                                                style: GoogleFonts.poppins(
                                                    color: Colors.blue,
                                                    fontSize: 12),
                                              )
                                            ],
                                          ),
                                        ),
                                        Text(
                                          '0.0001 USDC',
                                          style: GoogleFonts.poppins(
                                              color: Color(0xFF343333),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          '\$ 0.00',
                                          style: GoogleFonts.poppins(
                                              color: Color.fromARGB(
                                                  255, 171, 170, 170),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300),
                                        )
                                      ],
                                    ),
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 211, 242, 255),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: const Icon(
                                        Iconsax.dollar_square,
                                        size: 30,
                                        color:
                                            Color.fromARGB(255, 97, 206, 241),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        SmoothPageIndicator(
                          controller: _pageController2,
                          count: 3,
                          effect: ExpandingDotsEffect(
                            activeDotColor: Color(0xFF00B807),
                            dotColor: Colors.grey.shade300,
                            dotHeight: 6,
                            dotWidth: 6,
                            spacing: 4,
                          ),
                        ),
                      ],
                    ),
                  ),
*/
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        'Transactions',
                        style: GoogleFonts.poppins(fontSize: 12),
                      )),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 20,
                          width: 60,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 243, 243, 243),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'View all',
                                style: GoogleFonts.poppins(
                                    color: Colors.grey, fontSize: 10),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  //New stuffs can go here
                  const SizedBox(height: 50),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            width: 40,
                            height: 40,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 225, 255, 226),
                                borderRadius: BorderRadius.circular(50)),
                            child: const Center(
                                child: Text(
                              'i',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF00B807),
                              ),
                            ))),
                        const SizedBox(height: 10),
                        Text(
                          'You are yet to perform a transaction',
                          style: GoogleFonts.poppins(
                              color: Colors.grey, fontSize: 10),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 100,
                  )

                  //New stuffs can go here
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
