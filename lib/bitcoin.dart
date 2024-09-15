import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; // Import the spinkit package
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:iconsax/iconsax.dart';
import 'snackbarz.dart';
import 'package:flutter/services.dart';
import 'colors.dart' as color;

class Bitcoin extends StatefulWidget {
  const Bitcoin({Key? key}) : super(key: key);

  @override
  State<Bitcoin> createState() => _BitcoinState();
}

class _BitcoinState extends State<Bitcoin> {
  final TextEditingController _btcController = TextEditingController();
  final TextEditingController _ngnController = TextEditingController();
  double _exchangeRateBTCtoNGN = 0.0;
  double _exchangeRateBTCtoUSD = 0.0;
  String _selectedCurrency = 'BTC'; // Track the selected currency
  double _usdEquivalent = 0.0; // Store the USD equivalent of the entered BTC

  final String textToCopy = 'xxxxxxxxxxxxxxxxxxxxxxxxxx';
  //final String textToCopy = 'bc1qr3cd3lml75fxy64s7hdr0xagmrjnma5zpkdqmg';

  bool _isVisible = true;
  bool _isLoading = false; // Track loading state

  void _showCustomDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Start a timer to automatically dismiss the dialog after 10 seconds
        Future.delayed(const Duration(seconds: 10), () {
          Navigator.of(context).pop(); // Dismiss the dialog
          // Show a toast or snackbar indicating asset not received
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Asset not received'),
              duration: Duration(seconds: 2), // Adjust duration as needed
            ),
          );
        });
        return Dialog(
          insetPadding: const EdgeInsets.all(130),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            height: 130,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                SizedBox(height: 10),
                Text(
                  "Confirming...",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 10), // Adjust the height as needed
                CircularProgressIndicator(), // Add the circular progress indicator
                SizedBox(height: 20), // Adjust the height as needed
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchExchangeRates();
    _btcController.addListener(_convertCurrencyToNGN);
  }

  @override
  void dispose() {
    _btcController.removeListener(_convertCurrencyToNGN);
    _btcController.dispose();
    _ngnController.dispose();
    super.dispose();
  }

  Future<void> _fetchExchangeRates() async {
    // Fetch exchange rates from a public API
    try {
      final responseNGN = await http.get(
          Uri.parse('https://api.coindesk.com/v1/bpi/currentprice/NGN.json'));
      final responseUSD = await http.get(
          Uri.parse('https://api.coindesk.com/v1/bpi/currentprice/USD.json'));

      if (responseNGN.statusCode == 200 && responseUSD.statusCode == 200) {
        final dataNGN = json.decode(responseNGN.body);
        final dataUSD = json.decode(responseUSD.body);

        if (mounted) {
          setState(() {
            _exchangeRateBTCtoNGN = dataNGN['bpi']['NGN']['rate_float'];
            _exchangeRateBTCtoUSD = dataUSD['bpi']['USD']['rate_float'];
            _updateExchangeRate();
          });
        }
      } else {
        // Handle error
        throw Exception('Failed to load exchange rate');
      }
    } catch (error) {
      // Handle error
      if (mounted) {
        setState(() {
          // Set default values or handle error
          _exchangeRateBTCtoNGN = 0.0;
          _exchangeRateBTCtoUSD = 0.0;
        });
      }
    }
  }

  void _updateExchangeRate() {
    if (_selectedCurrency == 'BTC') {
      _exchangeRateBTCtoNGN;
    } else if (_selectedCurrency == 'USD') {
      _exchangeRateBTCtoUSD;
    }
  }

  void _convertCurrencyToNGN() {
    final amount = double.tryParse(_btcController.text) ?? 0.0;
    final ngnAmount = amount * _exchangeRateBTCtoNGN;
    final usdAmount = amount * _exchangeRateBTCtoUSD;

    if (mounted) {
      setState(() {
        _ngnController.text = ngnAmount.toStringAsFixed(2).replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
        _usdEquivalent = usdAmount;
      });
    }
  }

  void _showLoading() {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        _isLoading = false;
      });
      _showModal();
    });
  }

  void _showModal() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: 550,
          decoration: const BoxDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 207, 207, 207),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Container(
                  height: 180,
                  width: 180,
                  child: Image.asset('lib/images/barz.png'),
                ),
              ),
              const SizedBox(height: 10),
              Text("Address",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  )),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 238, 238, 238),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                      ),
                      child: Image.asset('lib/images/btc.png'),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'xxxxxxxxxxxxxxxxxxxxxxxxxx',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Color.fromARGB(255, 25, 25, 25),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(
                          ClipboardData(text: textToCopy),
                        );
                        TopSnackBar.show(
                          context,
                          'xxxxxxxxxxxxxxxxxxxxxxxxxx',
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Icon(
                          Icons.copy_outlined,
                          color: Color.fromARGB(255, 163, 163, 163),
                          size: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _showCustomDialog();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF00B807),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Confirm",
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
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
                            color: color.AppColor.lightgray,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Convert',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Enter the amount you would like to convert to naira',
                        style: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 242, 242),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(
                              'Kindly note that the minimum amount you can send is \$5. Sending any amount less than \$5 will result in a loss of fund.',
                              style: GoogleFonts.poppins(
                                fontSize: 8,
                                color: Color.fromARGB(255, 255, 118, 118),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.8,
                        //color: Colors.amber,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Text(
                              'Send',
                              style: GoogleFonts.poppins(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              padding: const EdgeInsets.only(
                                left: 12,
                                top: 0,
                                right: 12,
                              ),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 240, 240, 240),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: _btcController,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Enter amount',
                                      suffixText: _selectedCurrency,
                                      suffixIcon: Container(
                                        padding: EdgeInsets.all(9),
                                        child: Image.asset(
                                          //_selectedCurrency == 'BTC'
                                          'lib/images/roundbtc.png',
                                          //  : 'lib/images/usd.png',
                                          height: 20,
                                          width: 20,
                                        ),
                                      ),
                                      labelStyle: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            if (_selectedCurrency == 'BTC')
                              Text(
                                'USD Equivalent: \$${_usdEquivalent.toStringAsFixed(2)}',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            const SizedBox(height: 30),
                            Text(
                              'Receive',
                              style: GoogleFonts.poppins(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              padding: const EdgeInsets.only(
                                left: 12,
                                top: 0,
                                right: 12,
                              ),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 240, 240, 240),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextFormField(
                                controller: _ngnController,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                ),
                                readOnly: true, // Make the field read-only
                                decoration: InputDecoration(
                                  hintText: 'Amount to receive ',
                                  suffixText: 'NGN',
                                  suffixIcon: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Image.asset(
                                      'lib/images/roundnaira.png',
                                      height: 24,
                                      width: 24,
                                    ),
                                  ),
                                  labelStyle: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            const SizedBox(height: 100),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  _showLoading();
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: const Color(0xFF00B807),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  "Continue",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 150),
                    ],
                  ),
                ),
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
      ),
    );
  }
}
