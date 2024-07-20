import 'package:currenc/constants/colors.dart';
import 'package:currenc/main.dart';
import 'package:currenc/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:currenc/data/onboarding_data.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:currenc/screens/onboarding/front_page.dart';
import 'package:currenc/screens/onboarding/shared_onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool showDetailsPage = false;

  Future<void> _completeOnboarding(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingComplete', true);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const AuthCheck()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                PageView(
                  controller: _controller,
                  onPageChanged: (index) {
                    setState(() {
                      showDetailsPage = index == 3;
                    });
                  },
                  children: [
                    const FrontPage(),
                    SharedOnboardingScreen(
                      title: OnboardingData.onboardingDataList[0].title,
                      description:
                          OnboardingData.onboardingDataList[0].description,
                      imagePath: OnboardingData.onboardingDataList[0].imagePath,
                    ),
                    SharedOnboardingScreen(
                      title: OnboardingData.onboardingDataList[1].title,
                      description:
                          OnboardingData.onboardingDataList[1].description,
                      imagePath: OnboardingData.onboardingDataList[1].imagePath,
                    ),
                    SharedOnboardingScreen(
                      title: OnboardingData.onboardingDataList[2].title,
                      description:
                          OnboardingData.onboardingDataList[2].description,
                      imagePath: OnboardingData.onboardingDataList[2].imagePath,
                    ),
                  ],
                ),
                Container(
                  alignment: const Alignment(0, 0.75),
                  child: SmoothPageIndicator(
                    controller: _controller,
                    count: 4,
                    effect: const WormEffect(
                        activeDotColor: kMainColor, dotColor: kLightGrey),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: GestureDetector(
                      onTap: () {
                        if (!showDetailsPage) {
                          _controller.animateToPage(
                            _controller.page!.toInt() + 1,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          _completeOnboarding(context);
                        }
                      },
                      child: CustomButton(
                        buttonName: showDetailsPage ? 'Get Started' : 'Next',
                        buttonColor: kMainColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
