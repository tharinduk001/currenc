import 'package:currenc/constants/colors.dart';
import 'package:currenc/constants/constants.dart';
import 'package:flutter/material.dart';

class SharedOnboardingScreen extends StatelessWidget {
  const SharedOnboardingScreen(
      {super.key,
      required this.title,
      required this.imagePath,
      required this.description});
  final String title;
  final String imagePath;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(kDefaultpadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 300,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 20),
          Text(title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
          const SizedBox(height: 20),
          Text(description,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16, color: kGrey, fontWeight: FontWeight.w500))
        ],
      ),
    );
  }
}
