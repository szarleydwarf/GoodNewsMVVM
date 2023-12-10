import 'package:flutter/material.dart';
import 'package:good_news_app/screen_elements/lines.dart';

import '../misc/constants.dart';
import '../misc/palet.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key, required this.screenName});
  final ScreenName screenName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(appTitle, style: TextStyle(fontSize: 24, color: amber50)),
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(wholeScreenPadding),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(cornerRadius),
                    child: Image.asset(
                      getImageName(),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                drawLine(),
              ]),
        ),
      ),
    );
  }

  String getImageName() {
    switch (screenName) {
      case ScreenName.home:
        return "$assets${ScreenName.home.name}$png";
      case ScreenName.settings:
        return "$assets${ScreenName.settings.name}$png";
      case ScreenName.list:
        return "$assets${ScreenName.list.name}$png";
      case ScreenName.details:
        return "$assets${ScreenName.details.name}$png";
      default:
        return "$assets${ScreenName.home.name}$png";
    }
  }
}
