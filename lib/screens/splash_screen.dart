import 'package:flutter/material.dart';
import 'package:good_news_app/screens/home_screen.dart';

import '../misc/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  
  @override
  void initState() {
    super.initState();
         Future.delayed(const Duration(seconds: 3)).then((val) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(title: "$homePageTitle")),
      );
    });
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade400,
      body: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: Image.asset("assets/appstore.png"),
            ),
          ]
        )
      )
    );
  }
}
