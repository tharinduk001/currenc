import 'package:currenc/models/onboarding_model.dart';

class OnboardingData {
  // ignore: non_constant_identifier_names
  static final List<Onboarding> onboardingDataList = [
    Onboarding(
        title: 'What is CurrenC?',
        imagePath: 'assets/onboarding_screen/question.gif',
        description:
            'This is a free mobile application that users allow to convert their currencies to USD or Any other available currencies with NO ADS!'),
    Onboarding(
        title: 'How it Works',
        imagePath: 'assets/onboarding_screen/exchange.gif',
        description:
            'This application works with api calls to convert your currencies. So fast and high efficiency is always here.'),
            Onboarding(title: 'This App is For You', imagePath: 'assets/onboarding_screen/easy.gif', description: 'All the features and Uis are implemented in a very easy manner to work with users. So no worries just explore!')
  ];
}
