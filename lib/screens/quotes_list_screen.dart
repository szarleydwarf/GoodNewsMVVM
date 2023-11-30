import 'package:flutter/material.dart';
import 'package:good_news_app/models/quote_model.dart';
import 'package:good_news_app/screen_elements/quote_tile.dart';

import '../misc/constants.dart';

class QuotesScreen extends StatelessWidget {
  const QuotesScreen({super.key, required this.quotes});

  final List<Quote> quotes;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(quotesScreen,
            style: TextStyle(fontSize: 24, color: Colors.amber.shade100)),
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          Expanded(
            child:
            quotes.isNotEmpty ? ListView.builder(
              itemCount: quotes.length,
              itemBuilder: (context, index) {
                return QuoteTile(quote: quotes[index]);
              },
            ) : Center(
              child: Text(
                emptyListMessage,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
            )
          ),
        ],
      ),
    );
  }
}
