import 'package:flutter/material.dart';
import 'package:good_news_app/networking/pdf_viewer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

import '../misc/constants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen(
      {super.key, required this.title, required this.userName});

  final String title;
  final String userName;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late String userName;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userName = widget.userName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title,
            style: TextStyle(fontSize: 24, color: Colors.amber.shade100)),
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(wholeScreenPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              getUserLabel(),
              const Divider(
                color: Colors.amber,
              ),
              displayPP(),
              showAppInfoScreen(),
              const Spacer(
                flex: 1,
              ),
               Divider(
                color: Colors.red.shade900,
              ),
              Text(dangerzoneLabelText,
                style: TextStyle(
                fontSize: 28, 
                color: Colors.red.shade900,
                fontWeight: FontWeight.w900
                ),
              ),
              getDeleteUSerButton(),
            ],
          ),
        ),
      ),
    );
  }

  void showAlert() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(infoAlertTitle),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(deleteAlertDescription_1),
                Text(deleteAlertDescription_2),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, cancelButton),
              child: const Text(cancelButton),
            ),
            TextButton(
              child: const Text(deleteButton),
              onPressed: () {
                removeUser();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void removeUser() async {
    final SharedPreferences prefs = await _prefs;

    prefs.setString(nameKey, emptyString);
    prefs.setBool(userExistKey, false);
    setState(() {
      userName = friend;
    });
  }

  Widget getUserLabel() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(settingsLabelText,
            style: Theme.of(context).textTheme.headlineMedium),
        Text(userName,
            style: Theme.of(context).textTheme.headlineMedium),
      ],
    );
  }

  Widget displayPP() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        ElevatedButton(
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (_) => const PDFViewerCachedFromUrl(
                      url: ppURL,
                    ),
                  ),
                ),
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
              backgroundColor: Colors.amber.shade300,
              foregroundColor: Colors.black,
            ),
            child: const Text(
              ppPageTitle,
              style: TextStyle(
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            )),
      ],
    );
  }

  Widget getDeleteUSerButton() {
    return ElevatedButton(
      onPressed: () => {showAlert()},
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20),
        backgroundColor: Colors.red.shade900,
        foregroundColor: Colors.white,
      ),
      child: const Text(deleteUserButton),
    );
  }

  Widget showAppInfoScreen() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
      ElevatedButton(
        onPressed: () => {
          showAlert()
        },
        style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(fontSize: 20),
          backgroundColor: Colors.amber.shade300,
          foregroundColor: Colors.black87,
        ),
        child: const Text(infoButton),
      )
    ]);
  }
}
