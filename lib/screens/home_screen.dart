import 'package:flutter/material.dart';
import 'package:good_news_app/networking/network_manager.dart';

import '../misc/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Quote> futureQuote;
  final bool userExist = false;
  Color iconColor = Colors.black;

  @override
  void initState() {
    super.initState();
    futureQuote = NetworkManager().fetchQuote();
    iconColor = userExist ? Colors.amber.shade900 : Colors.amber;
  }

  @override
  Widget build(BuildContext context) {
    return getFutureDataFrom(futureQuote);
  }

  Widget getAuthorRow(String name, TextStyle? textStyle) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      getBookmarkRow(),
      Text(
        name,
        style: textStyle,
      ),
      IconButton(
        icon: const Icon(Icons.replay_outlined),
        color: iconColor,
        iconSize: iconButtonSize,
        onPressed: _onSubmit,
      ),
    ]);
  }

  Future<void> _onSubmit() async {
    Future<Quote> resp;
    setState(() {
      futureQuote = NetworkManager().fetchQuote();
      print("Fetching from API $futureQuote");
      getFutureDataFrom(futureQuote);
    });
  }

  Widget getUserBar(String name, TextStyle? textStyle) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        "Hello $name",
        style: textStyle,
      ),
      IconButton(
        onPressed: userExist
            ? () {
                print("SHOWING LIST");
              }
            : null,
        icon: const Icon(Icons.list_alt_outlined),
        color: iconColor,
        iconSize: iconButtonSize,
      )
    ]);
  }

  Widget getBookmarkRow() {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      IconButton(
        onPressed: userExist
            ? () {
                print("Bookmarking  quote.");
              }
            : null,
        icon: const Icon(Icons.bookmark_add_outlined),
        color: iconColor,
        iconSize: iconButtonSize,
      ),
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

  Widget getImageElement(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(cornerRadius),
      child: Image.network(
        imagePath,
        width: MediaQueryData.fromView(View.of(context)).size.width - 100,
      ),
    );
  }

  Widget getFutureDataFrom(Future<Quote> futureQuote) {
    return FutureBuilder<Quote>(
        future: futureQuote,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData) {
            return buildHomeScreen(snapshot.data);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        });
  }

  Widget buildHomeScreen(Quote? data) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(appTitle,
            style: TextStyle(fontSize: 24, color: Colors.yellow.shade400)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(wholeScreenPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              getImageElement(imagePathPlaceholder),
              const Divider(
                color: Colors.amber,
              ),
              getQuoteWidget(data),
              const Spacer(
                flex: 1,
              ),
              const Divider(
                color: Colors.amber,
              ),
              getUserBar(friend, Theme.of(context).textTheme.headlineMedium)
            ],
          ),
        ),
      ),
    );
  }

  Widget getQuoteWidget(Quote? data) {
    return Column(
      children: [
        getAuthorRow(data?.author ?? authorNamePlaceholder,
            Theme.of(context).textTheme.headlineMedium),
        // const SizedBox(
        //   height: 10,
        // ),
        // getBookmarkRow(),
        getQuoteElement(data?.quote ?? textPlaceholder,
            Theme.of(context).textTheme.headlineSmall),
      ],
    );
  }
}
