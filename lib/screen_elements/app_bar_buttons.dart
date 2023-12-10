import 'package:flutter/material.dart';
import 'package:good_news_app/helpers/user_manager.dart';

import '../misc/constants.dart';
import '../misc/palet.dart';
import '../screens/info_screen.dart';
import '../screens/settings_screen.dart';

Widget showSettingsIcon(BuildContext context, UserManager userManager) {
    return IconButton(
      icon: Icon(
        Icons.settings,
        color: amber50,
      ),
      onPressed: () {
        // do something
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SettingsScreen(
                    title: settingsPageTitle,
                    userManager: userManager,
                  )),
        );
      },
    );
  }

  Widget showInfoIcon(BuildContext context, ScreenName screenName) {
    return IconButton(
      icon: Icon(
        Icons.info_outline_rounded,
        color: amber50,
      ),
      onPressed: () {
        // do something
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => InfoScreen(screenName: screenName,)),
        );
      },
    );
  }