import 'package:flutter/material.dart';
import 'package:good_news_app/misc/palet.dart';
import 'package:good_news_app/models/quote_model.dart';
import 'package:good_news_app/screen_elements/quote_tile.dart';
import 'package:good_news_app/screens/qoute_details.dart';

import '../helpers/quote_manager.dart';
import '../misc/constants.dart';

class QuotesScreen extends StatefulWidget {
  const QuotesScreen({super.key});

  @override
  State<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  List quotes = [];

  @override
  void initState() {
    getQuoteList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(quotesScreen,
            style: TextStyle(fontSize: 24, color: amber50)),
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: (quotes.isNotEmpty)
                  ? ListView.builder(
                      itemCount: quotes.length,
                      itemBuilder: (context, index) {
                        return QuoteTile(
                          quote: quotes[index],
                          deleteQuote: _onDelete,
                          itemTapped: _onTap,
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        emptyListMessage,
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                    )),
        ],
      ),
    );
  }

  void getQuoteList() async {
    final list = await QuoteManager.instance.getQuotes();
    setState(() {
      quotes = list;
    });
  }

  Future<void> _onDelete(int id) async {
    await QuoteManager.instance.deleteQuote(id);

    setState(() {
      getQuoteList();
    });
  }

  void _onTap(Quote quote) {
    print("TAPPED: ${quote.comment}");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuoteDetails( 
          quote: quote 
        )),
    );
  }
}
