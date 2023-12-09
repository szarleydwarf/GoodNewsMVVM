import 'package:flutter/material.dart';

import '../misc/constants.dart';
import '../misc/palet.dart';

class InfoScreen extends StatelessWidget {
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
              children: <Widget>[]),
        ),
      ),
    );
  }
}
