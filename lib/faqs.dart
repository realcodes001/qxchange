import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart' as color;

class Faqs extends StatefulWidget {
  const Faqs({Key? key}) : super(key: key);

  @override
  State<Faqs> createState() => _FaqsState();
}

class _FaqsState extends State<Faqs> {
  List<Item> _data = generateItems();

  @override
  void initState() {
    super.initState();
    // Start a timer to navigate to the next screen after 5 seconds
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20, top: 50, right: 20),
              alignment: Alignment.center,
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
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'FAQS ',
                        style: GoogleFonts.poppins(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Frequently asked questions ',
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Color.fromARGB(255, 159, 159, 159),
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildPanel(),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPanel() {
    return Column(
      children: _data.map<Widget>((Item item) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ExpansionPanelList(
            elevation: 1,
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                item.isExpanded = !isExpanded;
              });
            },
            children: [
              ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text(
                      item.headerValue,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: const Color.fromARGB(255, 25, 25, 25),
                      ),
                    ),
                  );
                },
                body: ListTile(
                  title: Text(
                    item.expandedValue,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                      color: const Color.fromARGB(255, 159, 159, 159),
                    ),
                  ),
                ),
                isExpanded: item.isExpanded,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems() {
  return [
    Item(
      headerValue: 'What is QuickXchange?',
      expandedValue:
          'QuickXchange is a crypto-to-fiat payment service that enables users to easily and seamlessly convert crypto to fiat(Naira), and directly send to wallet or bank account.',
    ),
    Item(
      headerValue: 'How does QuickXchange work?',
      expandedValue:
          'The QuickXchange app works using a blockchain infrastructure, and a local P2P settlement system. Users are required to download the app and send assets to the provided wallet address, which is then converted to Naira and sent to their bank account.',
    ),

    Item(
      headerValue: 'Does QuickXchange support all crypto-currencies?',
      expandedValue:
          'No, Not at this time. We only support a few assets for now which includes, BTC, ETH, USDT and USDC. However we are making plans to increase our supported cryptocurrencies',
    ),
    Item(
      headerValue: 'Who can use QuickXchange?',
      expandedValue:
          'Anyone can make use of our service. Crypto users, Diaspora community, Remote workers and freelancers',
    ),

    Item(
      headerValue: 'How can i start using the QuickXchange app?',
      expandedValue:
          '1.Download and install the app from any of the stores 2.Open the app after downloading 3. Register your required bank or leave it empty to receive funds in your wallet 4.Now you are all set 5.Navigate to the asset you want to convert from the home screen and copy the provided address  6.Send asset and receive funds immediately after confirmation. ',
    ),

    Item(
      headerValue: 'Can i change my withdrawal bank details anytime?',
      expandedValue: 'Yes, you can choose to change it anytime you wish.',
    ),

    Item(
      headerValue: 'At what market rate will my payment be processed?',
      expandedValue:
          'The rate which will be used for conversion will be the rate at the time of the blockchain confirmation.',
    ),

    Item(
      headerValue: 'How much can i withdraw at a time?',
      expandedValue:
          'There is no minimum or maximum amount that can be cashed out using the QuickXchange app. The service is constantly adapting to users needs.',
    ),

    Item(
      headerValue: 'How will i know that my transaction has been completed',
      expandedValue:
          'You will receive push notification, notifying you that the transaction has been completed. You can also check your transaction history on the Transactions section of the app.',
    ),

    Item(
      headerValue:
          'How long does it take for the funds to appear in my wallet or bank account?',
      expandedValue:
          'Within minutes. Bitcoin transactions are typically processed within an average of 10 minutes from the time of the first blockchain confirmation. Once the crypto is received in the QuickXchange app, the funds are processed immediately and sent to your preferred destination.',
    ),
    // Add more items here as needed
  ];
}
