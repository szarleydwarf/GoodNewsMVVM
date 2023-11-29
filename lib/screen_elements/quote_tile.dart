import 'package:flutter/material.dart';

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
    return ListTile(
      title: Text(
        quote.author,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: IconButton(
        onPressed: () {
          print("DELETING QUOTE");
        },
        icon: const Icon(Icons.bookmark_remove_outlined),
        color: Colors.amber.shade900,
      ),
      subtitle: Text(quote.quote),
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