import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'colors.dart' as color;
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Institutions extends StatefulWidget {
  const Institutions({Key? key}) : super(key: key);

  @override
  State<Institutions> createState() => _InstitutionsState();
}

class _InstitutionsState extends State<Institutions> {
  final List<String> _banks = [
    'Access Bank',
    'Citibank',
    'Diamond Bank',
    'Ecobank Nigeria',
    'Fidelity Bank Nigeria',
    'First Bank of Nigeria',
    'First City Monument Bank',
    'Guaranty Trust Bank',
    'Heritage Bank Plc',
    'Moniepoint',
    'Opay',
    'Keystone Bank Limited',
    'Kuda MFB',
    'Palmpay',
    'Polaris Bank',
    'Providus Bank Plc',
    'Stanbic IBTC Bank Nigeria Limited',
    'Standard Chartered Bank',
    'Sterling Bank',
    'SunTrust Bank Nigeria Limited',
    'Union Bank of Nigeria',
    'United Bank for Africa',
    'Unity Bank Plc',
    'Wema Bank',
    'Zenith Bank'
  ];

  String? _selectedBank;
  final TextEditingController _accountNumberController =
      TextEditingController();
  String? _accountHolderName;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadSavedDetails();
  }

  Future<void> _loadSavedDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedBank = prefs.getString('selectedBank');
      _accountNumberController.text = prefs.getString('accountNumber') ?? '';
      _accountHolderName = prefs.getString('accountHolderName');
    });
  }

  Future<void> _saveDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedBank', _selectedBank!);
    await prefs.setString('accountNumber', _accountNumberController.text);
    await prefs.setString('accountHolderName', _accountHolderName!);
  }

  void _showLoading() {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        _isLoading = false;
      });
      _fetchAccountHolderName();
    });
  }

  Future<void> _fetchAccountHolderName() async {
    final bank = _selectedBank;
    final accountNumber = _accountNumberController.text;

    if (bank == null || accountNumber.isEmpty) {
      // Show some error
      return;
    }

    setState(() {
      bool _isVisible = true;
      bool _isLoading = false; // Track loading state
    });

    // Paystack API endpoint
    final url = Uri.parse('https://api.paystack.co/bank/resolve');
    final bankCode = _getBankCode(bank);

    try {
      final response = await http.get(
        url.replace(queryParameters: {
          'account_number': accountNumber,
          'bank_code': bankCode
        }),
        headers: {
          'Authorization':
              'Bearer sk_live_ec2248ec521e535271bee70e7b71a5468b131cbb',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _accountHolderName = data['data']['account_name'];
        });
        await _saveDetails(); // Save details after fetching
      } else {
        // Handle error response
        print('Failed to fetch account holder name');
      }
    } catch (e) {
      // Handle network errors
      print('Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _getBankCode(String bankName) {
    // You can get the bank codes from Paystack's API documentation
    // Here are some examples, you might need to get the correct codes
    const bankCodes = {
      'Access Bank': '044',
      'Citibank': '023',
      'Diamond Bank': '063',
      'Ecobank Nigeria': '050',
      'Fidelity Bank Nigeria': '070',
      'First Bank of Nigeria': '011',
      'First City Monument Bank': '214',
      'Guaranty Trust Bank': '058',
      'Heritage Bank Plc': '030',
      'Moniepoint': '50515',
      'Opay': '100',
      'Keystone Bank Limited': '082',
      'Kuda MFB': '50211',
      'Palmpay': '50383',
      'Polaris Bank': '076',
      'Providus Bank Plc': '101',
      'Stanbic IBTC Bank Nigeria Limited': '221',
      'Standard Chartered Bank': '068',
      'Sterling Bank': '232',
      'SunTrust Bank Nigeria Limited': '100',
      'Union Bank of Nigeria': '032',
      'United Bank for Africa': '033',
      'Unity Bank Plc': '215',
      'Wema Bank': '035',
      'Zenith Bank': '057'
    };

    return bankCodes[bankName] ?? '';
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
                            'Add Bank',
                            style: GoogleFonts.poppins(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          Text(
                            'Add a payout account where you would like to receive your funds',
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        //color: Colors.amber,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 12, top: 0, right: 12),
                              decoration: BoxDecoration(
                                  color: color.AppColor.lightgray,
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
                                controller: _accountNumberController,
                                keyboardType: TextInputType.number,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                ),
                                decoration: const InputDecoration(
                                  hintText: 'Enter your account number',
                                  labelText: 'Account Number',
                                  labelStyle: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: color.AppColor.lightgray),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0),
                                child: Row(
                                  children: [
                                    Expanded(
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
                                              "Select bank",
                                              style: GoogleFonts.poppins(
                                                  color: Colors
                                                      .grey), // Custom hint text color
                                            ),
                                            value: _selectedBank,
                                            icon: const Icon(
                                                Icons.arrow_drop_down),
                                            iconSize: 24,
                                            elevation: 16,
                                            style: GoogleFonts.poppins(
                                                color: Colors
                                                    .black), // Dropdown list values color
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                _selectedBank = newValue;
                                              });
                                            },
                                            items: _banks
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                  style: const TextStyle(
                                                      color: Colors
                                                          .black), // Dropdown list values color
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            //if (_isLoading) const CircularProgressIndicator(),
                            if (_accountHolderName != null)
                              Text('Account Holder: $_accountHolderName'),
                            const SizedBox(
                              height: 80,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              child: ElevatedButton(
                                  onPressed: _showLoading,
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFF00B807),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    "Add",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white),
                                  )),
                            ),
                            const SizedBox(height: 20),
                            /* if (_selectedBank != null &&
                                _accountNumberController.text.isNotEmpty &&
                                _accountHolderName != null)
                              Container(  
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: Colors.green[100],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Saved Bank Details:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    const SizedBox(height: 8),
                                    Text('Bank: $_selectedBank'),
                                    Text(
                                        'Account Number: ${_accountNumberController.text}'),
                                    Text('Account Holder: $_accountHolderName'),
                                  ],
                                ),
                              ), */
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      )
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
