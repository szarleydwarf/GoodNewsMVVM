import 'package:flutter/material.dart';
import 'package:good_news_app/models/quote_model.dart';
import 'package:good_news_app/screen_elements/quote_tile.dart';

import '../helpers/quote_manager.dart';
import '../misc/constants.dart';

class QuotesScreen extends StatefulWidget {
  const QuotesScreen({super.key});

  @override
  State<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  final QuoteManager quoteManager = QuoteManager.instance;
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
            style: TextStyle(fontSize: 24, color: Colors.amber.shade100)),
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
    setState(() {
      quotes = quoteManager.getQuotesList();
    });
  }

  Future<void> _onDelete(Quote quote) async {
    quoteManager.remove(quote);

    setState(() {
      getQuoteList();
    });
  }
}
