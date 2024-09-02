import 'package:currenc/data/currencies_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Converter extends StatefulWidget {
  const Converter({super.key});

  @override
  State<Converter> createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {
  var _selectedPrimaryCategory = currencyList[0].currencyName;
  var _selectedSecondaryCategory = currencyList[2].currencyName;
  TextEditingController primaryCurrencyInput = TextEditingController();
  TextEditingController secondaryCurrencyInput = TextEditingController();

  void _getConvertedData() async {
    if (primaryCurrencyInput.toString().isEmpty) {
      print("Inputs are empty. Aborting request.");
      return;
    }

    final url = Uri.https(
      'api.freecurrencyapi.com',
      '/v1/latest',
      {
        'apikey': 'fca_live_SS8tCnl8MoR1jb7gXQIKYSYhiGublk1dnFrfJkbv',
        'currencies': _selectedSecondaryCategory, //secondary (usd to LKR)
        'base_currency': _selectedPrimaryCategory, //primary (USD to lkr)
      },
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        print("-----------------------------------------------------");
        print("Response data: ${response.body}");
        secondaryCurrencyInput.text = response.body.toString();
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      print("An error occurred: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Form(
          child: Card(
            color: const Color.fromARGB(255, 224, 187, 82),
            elevation: 10,
            shadowColor: const Color.fromARGB(255, 145, 107, 3),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                children: [
                  const Text(
                    'Convert Your Currencies Today',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 16, 6, 107)),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: Text(
                          //  overflow: TextOverflow.ellipsis,
                          "Primary Currency",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(width: 20),
                      DropdownButton(
                        value: _selectedPrimaryCategory,
                        items: [
                          for (final category in currencyList)
                            DropdownMenuItem(
                                value: category.currencyName,
                                child: Row(
                                  children: [
                                    Image.network(
                                      category.imageUrl,
                                      fit: BoxFit.cover,
                                      width: 25,
                                      height: 20,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(category.currencyName)
                                  ],
                                ))
                        ],
                        onChanged: (val) {
                          if (val == null) {
                            return;
                          }
                          setState(() {
                            _selectedPrimaryCategory = val;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Expanded(
                        child: Text(
                          "Amount",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          style: const TextStyle(
                            fontSize: 16.0, // Text font size
                            fontWeight: FontWeight.w500, // Text font weight
                            color: Colors.black, // Text color
                          ),
                          controller: primaryCurrencyInput,
                          keyboardType: TextInputType.number,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Stack(alignment: Alignment.center, children: [
                    const Divider(
                      thickness: 2,
                      color: Color.fromARGB(255, 35, 1, 63),
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: _getConvertedData,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor:
                              const Color.fromARGB(255, 246, 255, 206),
                          shadowColor: Colors.blueAccent, // Shadow color
                          elevation: 5, // Elevation of the button
                          padding: const EdgeInsets.all(
                              10), // Equal padding to make it round
                          shape: const CircleBorder(), // Round shape
                          textStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        child: Image.asset(
                          'assets/exchange.png',
                          fit: BoxFit.cover,
                          width: 55,
                          height: 55,
                        ),
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: Text(
                          "Seondory Currency",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(width: 20),
                      DropdownButton(
                        value: _selectedSecondaryCategory,
                        items: [
                          for (final category in currencyList)
                            DropdownMenuItem(
                                value: category.currencyName,
                                child: Row(
                                  children: [
                                    Image.network(
                                      category.imageUrl,
                                      fit: BoxFit.cover,
                                      width: 25,
                                      height: 20,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(category.currencyName)
                                  ],
                                ))
                        ],
                        onChanged: (val) {
                          if (val == null) {
                            return;
                          }
                          setState(() {
                            _selectedSecondaryCategory = val;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Expanded(
                        child: Text(
                          "Amount",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Expanded(
                          child: TextField(
                        style: const TextStyle(
                          fontSize: 16.0, // Text font size
                          fontWeight: FontWeight.w500, // Text font weight
                          color: Colors.black, // Text color
                        ),
                        controller: secondaryCurrencyInput,
                        keyboardType: TextInputType.number,
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Card(
          color: Color.fromARGB(255, 224, 187, 82),
          elevation: 10,
          shadowColor: Color.fromARGB(255, 145, 107, 3),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Rate : ',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '100\$',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
