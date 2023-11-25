import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/string_extensions.dart';
import '../networking/network_manager.dart';

import '../misc/constants.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<Quote> futureQuote;
  late Future<Widget> futureImage;
  bool userExist = false;
  Color iconColor = Colors.black;
  // late Quote quote;
  late String userName = "";
  late String userBarText;

  @override
  void initState() {
    super.initState();
    futureQuote = NetworkManager().fetchQuote();
    futureImage = NetworkManager().fetchImage();
    iconColor = userExist ? Colors.amber.shade900 : Colors.amber.shade200;
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(appTitle,
            style: TextStyle(fontSize: 24, color: Colors.amber.shade100)),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.amber.shade100,
            ),
            onPressed: () {
              // do something
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SettingsScreen(
                          title: settingsPageTitle,
                          userName: getUserName(),
                        )),
              );
            },
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(wholeScreenPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              getImageElement(),
              const Divider(
                color: Colors.amber,
              ),
              getFutureDataFrom(futureQuote),
              const Spacer(
                flex: 1,
              ),
              const Divider(
                color: Colors.amber,
              ),
              getUserBar(Theme.of(context).textTheme.headlineMedium)
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onRefreshTapped() async {
    setState(() {
      futureQuote = NetworkManager().fetchQuote();
      futureImage = NetworkManager().fetchImage();
    });
  }

  Widget getImageElement() {
    NetworkManager().fetchImage;
    return Column(
      children: [
        FutureBuilder(
            future: futureImage,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasData && snapshot.data != null) {
                return getRoundedImage(snapshot.data as Image);
              } else if (snapshot.hasError) {
                // TODO: Implement so crash/error login system (???)
                print(snapshot.error);
                return getRoundedImage(null);
              }
              return getRoundedImage(null);
            }),
      ],
    );
  }

  Widget getFutureDataFrom(Future<Quote> futureQuote) {
    return FutureBuilder<Quote>(
        future: futureQuote,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData && snapshot.data != null) {
            return getQuoteWidget(snapshot.data);
          } else if (snapshot.hasError) {
            // TODO: Implement so crash/error login system (???)
            print(snapshot.error);
            return getQuoteWidget(null);
          }
          return const CircularProgressIndicator();
        });
  }

  Widget getQuoteWidget(Quote? data) {
    var authorName = data?.author == "" ? "Unknown" : data?.author;
    return Column(
      children: [
        getAuthorRow(authorName ?? authorNamePlaceholder,
            Theme.of(context).textTheme.headlineMedium),
        const Divider(
          color: Colors.amber,
        ),
        getQuoteElement(data?.quote ?? quotePlaceholder,
            Theme.of(context).textTheme.headlineSmall),
      ],
    );
  }

  Widget getAuthorRow(String name, TextStyle? textStyle) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      getBookmarkButton(),
      Flexible(
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.spaceBetween,
          spacing: 30,
          direction: Axis.horizontal,
          children: [
            Text(
              name,
              style: textStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      getRefreshButton(),
    ]);
  }

  Widget getQuoteElement(String text, TextStyle? textStyle) {
    return Text(
      text,
      style: textStyle,
      textAlign: TextAlign.center,
      softWrap: true,
      overflow: TextOverflow.visible,
    );
  }

  Widget getBookmarkButton() {
    return IconButton(
      onPressed: userExist
          ? () {
              print("Bookmarking  quote.");
            }
          : () => {showAlert()},
      icon: const Icon(Icons.bookmark_add_outlined),
      color: iconColor,
      iconSize: iconButtonSize,
    );
  }

  Widget getUserBar(TextStyle? textStyle) {
    _setUserBar();
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        userBarText,
        style: textStyle,
      ),
      IconButton(
        onPressed: userExist
            ? () {
                print("SHOWING LIST");
              }
            : () => {showAlert()},
        icon: const Icon(Icons.list_alt_outlined),
        color: iconColor,
        iconSize: iconButtonSize,
      )
    ]);
  }

  Widget getRefreshButton() {
    return IconButton(
      icon: const Icon(Icons.replay_outlined),
      color: Colors.amber.shade900,
      iconSize: iconButtonSize,
      onPressed: _onRefreshTapped,
    );
  }

  Widget getRoundedImage(Image? image) {
    var defaultImage = Image.network(
      imagePathPlaceholder,
      width: MediaQueryData.fromView(View.of(context)).size.width - 100,
    );
    return ClipRRect(
      borderRadius: BorderRadius.circular(cornerRadius),
      child: image ?? defaultImage,
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
                Text(infoAlertDescription_1),
                Text(infoAlertDescription_2),
                Text(infoAlertDescription_3)
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text(cancelButton),
            ),
            TextButton(
              child: const Text(okButton),
              onPressed: () {
                Navigator.of(context).pop();
                _showNamePrompt();
              },
            ),
          ],
        );
      },
    );
  }

  void _showNamePrompt() async {
    var textEditorController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(enterNamePrompt1),
          content: TextField(
            controller: textEditorController,
            decoration: const InputDecoration(hintText: enterNamePrompt2),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(cancelButton),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text(saveButton),
              onPressed: () {
                var name = textEditorController.text;
                if (name != "") {
                  setState(() {
                    userName = name.capitalize();
                    userExist = true;
                    iconColor = Colors.amber.shade900;
                  });
                  saveUser();
                  Navigator.pop(context);
                } else {
                  Navigator.pop(context);
                  showAlert();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _setUserBar() async {
    userBarText = "Hello ${getUserName()}";
  }

  void saveUser() async {
    final SharedPreferences prefs = await _prefs;

    prefs.setString(nameKey, userName);
    prefs.setBool(userExistKey, userExist);
  }

  void getUser() async {
    final SharedPreferences prefs = await _prefs;
    final String name = (prefs.getString(nameKey) ?? friend);
    final bool userExistInPrefs = (prefs.getBool(userExistKey) ?? false);

    setState(() {
      userName = name;
      userExist = userExistInPrefs;
      iconColor = userExist ? Colors.amber.shade900 : Colors.amber.shade200;
    });
  }

  String getUserName() {
    return (userExist && userName != "") ? userName : friend;
  }
}
