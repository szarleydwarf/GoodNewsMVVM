import 'package:flutter/material.dart';

import '../misc/palet.dart';
import '../models/quote_model.dart';

class QuoteTile extends StatelessWidget {
  const QuoteTile({
    required this.quote,
    super.key,
    required this.deleteQuote,
    required this.itemTapped,
  });

  final Quote quote;
  final void Function(int) deleteQuote;
  final void Function(Quote) itemTapped;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 11.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: amberOpaq,
            blurRadius: 20.0,
            offset: const Offset(3.0, 2.0),
          )
        ],
      ),
      child: Card(
        color: justWhite,
        child: ListTile(
          title: Text(
            quote.author,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
          trailing: IconButton(
            onPressed: () => deleteQuote(quote.id),
            icon: const Icon(Icons.bookmark_remove_outlined),
            color: amber900,
          ),
          subtitle: Text(quote.quote),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: amber900, width: 1),
            borderRadius: BorderRadius.circular(11),
          ),
          tileColor: amber50,
          contentPadding: const EdgeInsets.symmetric(horizontal: 11.0),
          onTap: () => itemTapped(quote),
        ),
      ),
    );
  }
}
