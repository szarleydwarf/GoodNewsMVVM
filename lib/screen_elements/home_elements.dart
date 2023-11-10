import 'package:flutter/material.dart';
import 'package:good_news_app/networking/network_manager.dart';
import '../misc/constants.dart';

class HomeScreenElements {
  BuildContext context;
  bool userExist;
  Color iconColor = Colors.black;

  HomeScreenElements(this.context, this.userExist) {
    iconColor = userExist ? Colors.amber.shade900 : Colors.amber;
  }

  Widget getAuthorRow(String name, TextStyle? textStyle) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        name,
        style: textStyle,
      ),
      IconButton(
        icon: const Icon(Icons.replay_outlined),
        color: iconColor,
        iconSize: iconButtonSize,
        onPressed: () => {print("Fetching from API")},
      ),
    ]);
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
    return Column();
  }
}
