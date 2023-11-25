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
         Future.delayed(const Duration(milliseconds: 900)).then((val) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen(title: homePageTitle)),
      );
    });
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade400,
      body: Padding(
          padding: const EdgeInsets.all(wholeScreenPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(cornerRadius),
                child: Image.asset(
                  appSplashIcon,
                  width: MediaQueryData.fromView(View.of(context)).size.width - 200,
                ),
            ),
          ]
        )
      )
    );
  }
}
