import 'package:flutter/material.dart';
import 'package:good_news_app/models/quote_model.dart';

import '../misc/constants.dart';

class QuoteDetails extends StatefulWidget {
  const QuoteDetails({super.key, required this.quote});

  final Quote quote;

  @override
  State<StatefulWidget> createState() => _QuoteDetails();
}

class _QuoteDetails extends State<QuoteDetails> {
  var textEditorController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(detailScreen,
            style: TextStyle(fontSize: 24, color: Colors.amber.shade100)),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Center(
            child: Text(
              widget.quote.author,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
          ),
          Divider(
            color: Colors.amber.shade400,
            thickness: 1,
          ),
          Expanded(
            child: Center(
            child: Text(
              widget.quote.quote,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
          )),
          Expanded(
              child: Center(
            child: Column(
              children: [
                Divider(
                  color: Colors.amber.shade400,
                  thickness: 1,
                ),
                Text(
                  commentInfo,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Divider(
                  color: Colors.amber.shade400,
                  thickness: 1,
                ),
                TextField(
                  controller: textEditorController,
                  decoration: const InputDecoration(hintText: enterCommentPrompt),
                  autofocus: true,
                  maxLength: 160,
                  minLines: 3,
                  maxLines: 5,
                ),
                IconButton(
                  onPressed: () {
                    print(textEditorController.text);
                  }
                , icon: Icon(Icons.save_alt_outlined,
                color: Colors.amber.shade900,))
              ],
            ),
          ))
        ]),
      ),
    );
  }
}
