import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
              const Text("Some More Text"),
              const Spacer(
                flex: 1,
              ),
              const Text(quotePlaceholder),
              const Divider(
                color: Colors.amber,
              ),
              ElevatedButton(
                onPressed: () => {showAlert()},
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                  backgroundColor: Colors.red.shade900,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Delete User"),
              )
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
              onPressed: () => Navigator.pop(context, 'Cancel'),
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

    prefs.setString(nameKey, "");
    prefs.setBool(userExistKey, false);
    setState(() {
      userName = friend;
    });
  }

  Widget getUserLabel() {
    return Text("Here are your settings $userName",
        style: Theme.of(context).textTheme.headlineMedium);
  }
}
