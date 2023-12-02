import 'package:flutter/material.dart';
import 'package:good_news_app/helpers/quote_manager.dart';

import '../misc/constants.dart';
import '../models/quote_model.dart';

class QuoteTile extends StatelessWidget {
  const QuoteTile({
    required this.quote,
    super.key,
  });

  final Quote quote;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 11.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 255, 215, 55).withOpacity(0.7),
            blurRadius: 20.0,
            offset: const Offset(3.0, 2.0),
          )
        ],
      ),
      child: Card(
        color: Colors.white,
        child: ListTile(
          title: Text(
            quote.author,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
          trailing: IconButton(
            onPressed: () {
              print("DELETING QUOTE");
              QuoteManager().deleteQuote(quote.id);
            },
            icon: const Icon(Icons.bookmark_remove_outlined),
            color: Colors.amber.shade900,
          ),
          subtitle: Text(quote.quote),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.amber.shade900, width: 1),
            borderRadius: BorderRadius.circular(11),
          ),
          tileColor: Colors.amber.shade50,
          contentPadding: const EdgeInsets.symmetric(horizontal: 11.0),
        ),
      ),
    );
  }
}

/*
Container(
      margin: const EdgeInsets.fromLTRB(11, 4, 11, 2),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: const BorderRadius.all(Radius.circular(11)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Row(
            children: [
                Text(
                  quote.author,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
          
                IconButton(
                onPressed: () {
                  print("DELETING QUOTE");
                },
                icon: const Icon(Icons.bookmark_remove_outlined),
                color: Colors.amber.shade900,
              ),
            ],
          ),
          const SizedBox(
            height: 3,
          ),
          Text(quote.quote)
        ]),
      ),
    );
    */