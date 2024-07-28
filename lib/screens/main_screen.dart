import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currenc/screens/currency_converter_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:currenc/screens/currency_rates_screen.dart';
import 'package:currenc/screens/user_details_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

String userName = "CurrenC";
String userImage =
    "https://static.vecteezy.com/system/resources/previews/019/896/008/original/male-user-avatar-icon-in-flat-design-style-person-signs-illustration-png.png";

class _MainScreenState extends State<MainScreen> {
  bool isLoading = true;

  void getUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      setState(() {
        userName = userData.data()!['username'];
        userImage = userData.data()!['image_url'];
        isLoading = false;
      });
    } catch (error) {
      isLoading = false;
    }
  }

  int _currentIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      getUserData();
    });
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 247, 211, 146),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: GNav(
              gap: 10,
              backgroundColor: Colors.transparent,
              color: const Color.fromARGB(255, 47, 16, 185),
              activeColor: Colors.white,
              tabBackgroundColor: const Color.fromARGB(255, 221, 39, 78),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              onTabChange: _onPageChanged,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.currency_exchange,
                  text: 'Rates',
                ),
                GButton(icon: Icons.settings, text: 'Settings'),
              ]),
        ),
      ),
      body:
          getPage(_currentIndex), // Show loading indicator while fetching data
    );
  }

  Widget getPage(int index) {
    setState(() {
      getUserData();
    });
    if (index == 0) {
      getUserData();
      return CurrencyConverterScreen(
        userName: userName,
        pickedImageFile: userImage,
      );
    } else if (index == 1) {
      return const CurrencyRatesScreen();
    } else if (index == 2) {
      return const UserDetailsScreen();
    }
    return Container();
  }
}
