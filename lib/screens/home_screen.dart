import 'package:flutter/material.dart';
import 'package:good_news_app/helpers/quote_manager.dart';
import 'package:good_news_app/helpers/user_manager.dart';
import 'package:good_news_app/screens/quotes_list_screen.dart';

import '../helpers/string_extensions.dart';
import '../misc/palet.dart';
import '../models/quote_model.dart';
import '../models/user_model.dart';
import '../networking/network_manager.dart';

import '../misc/constants.dart';
import '../screen_elements/app_bar_buttons.dart';
import '../screen_elements/lines.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserManager userManager = UserManager();

  late Future<Quote> futureQuote;
  late Future<Widget> futureImage;

  late User user = User.empty();
  late String userName = emptyString;
  late String userBarText;
  late Quote quote = Quote.empty();

  bool userExist = false;
  late Color iconColor;

  @override
  void initState() {
    super.initState();
    futureQuote = NetworkManager().fetchQuote();
    futureImage = NetworkManager().fetchImage();
    iconColor = userExist ? amber900 : amber200;
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    getUser();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(appTitle, style: TextStyle(fontSize: 24, color: amber50)),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          showInfoIcon(context, ScreenName.home),
          showSettingsIcon(context, userManager),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(wholeScreenPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              getImageElement(),
              drawLine(),
              getFutureDataFrom(futureQuote),
              const Spacer(
                flex: 1,
              ),
              drawLine(),
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
            quote = snapshot.data as Quote;
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
    var authorName = data?.author == emptyString ? unknownAuthor : data?.author;
    return Column(
      children: [
        getAuthorRow(authorName ?? authorNamePlaceholder,
            Theme.of(context).textTheme.headlineMedium),
        drawLine(),
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
              QuoteManager.instance.insert(quote);
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
                goToQuotesScreen();
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
      color: amber900,
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
              onPressed: () => Navigator.pop(context, cancelButton),
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
                if (name != emptyString) {
                  setState(() {
                    userName = name.capitalize();
                    userExist = true;
                    iconColor = amber900;
                  });
                  userManager.saveUser(userName, userExist);

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
    userBarText = helloLabelText + getUserName();
  }

  void getUser() async {
    user = await userManager.getUser();
    setState(() {
      userName = (user.name != emptyString) ? user.name : friend;
      userExist = user.isExisting;
      iconColor = userExist ? amber900 : amber200;
    });
  }

  String getUserName() {
    return (userExist && userName != emptyString) ? userName : friend;
  }

  void goToQuotesScreen() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const QuotesScreen()),
    );
  }
}
