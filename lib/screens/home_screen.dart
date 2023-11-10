import 'package:flutter/material.dart';
import 'package:good_news_app/screen_elements/home_elements.dart';
import '../misc/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.title});

  final String title;
  final bool userExist = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title,
        style: TextStyle(fontSize: 24, color: Colors.yellow.shade400)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(wholeScreenPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              HomeScreenElements(context, userExist).authorRow(authorNamePlaceholder,
                  Theme.of(context).textTheme.headlineMedium),
              const Divider(
                color: Colors.amber,
              ),
              const SizedBox(
                height: 10,
              ),
              HomeScreenElements(context, userExist).getImageElement(imagePathPlaceholder),
              HomeScreenElements(context, userExist).getBookmarkRow(),
              HomeScreenElements(context, userExist).getQuoteElement(
                  textPlaceholder, Theme.of(context).textTheme.headlineSmall),
              const Spacer(
                flex: 1,
              ),
              const Divider(
                color: Colors.amber,
              ),
              HomeScreenElements(context, userExist).getUserBar(
                  friend, Theme.of(context).textTheme.headlineMedium)
            ],
          ),
        ),
      ),
    );
  }
}
