import 'package:flutter/material.dart';
import './screens/splash_screen.dart';
import './misc/constants.dart';
import 'misc/palet.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: appTitle,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: blue400),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
			);
  }
}
