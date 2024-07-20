import 'package:currenc/screens/auth.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:currenc/screens/onboarding_screen.dart';
import 'package:currenc/screens/splash_screen.dart';
import 'package:currenc/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData().copyWith(
  textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
    titleSmall: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
    ),
    titleMedium: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
    ),
    titleLarge: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
    ),
  ),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> _checkOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onboardingComplete') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _checkOnboardingStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            title: "CurrenC",
            debugShowCheckedModeBanner: false,
            theme: ThemeData(fontFamily: "Poppins"),
            home: const SplashScreen(),
          );
        } else if (snapshot.data == true) {
          return MaterialApp(
            title: "CurrenC",
            debugShowCheckedModeBanner: false,
            theme: ThemeData(fontFamily: "Poppins"),
            home: const AuthCheck(),
          );
        } else {
          return MaterialApp(
            title: "CurrenC",
            debugShowCheckedModeBanner: false,
            theme: ThemeData(fontFamily: "Poppins"),
            home: const OnboardingScreen(),
          );
        }
      },
    );
  }
}

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        }

        if (snapshot.hasData) {
          return const MainScreen();
        }
        return const AuthScreen();
      },
    );
  }
}
