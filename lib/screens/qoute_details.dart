import 'package:flutter/material.dart';
import 'package:good_news_app/helpers/quote_manager.dart';
import 'package:good_news_app/models/quote_model.dart';

import '../misc/constants.dart';
import '../misc/palet.dart';
import '../screen_elements/app_bar_buttons.dart';
import '../screen_elements/lines.dart';

class QuoteDetails extends StatefulWidget {
  const QuoteDetails({super.key, required this.quote});

  final Quote quote;

  @override
  State<StatefulWidget> createState() => _QuoteDetails();
}

class _QuoteDetails extends State<QuoteDetails> {
  var textEditorController = TextEditingController();
  var commentNotEmpty = false;
  var comment = "";

  @override
  void initState() {
    commentNotEmpty = widget.quote.comment.isNotEmpty;
    comment = widget.quote.comment;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title:
            Text(detailScreen, style: TextStyle(fontSize: 24, color: amber200)),
        automaticallyImplyLeading: true,
        actions: <Widget>[
          showInfoIcon(context, ScreenName.details),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          displayAuthor(),
          drawLine(),
          // Expanded(
            // child: 
            Container(
              constraints: const BoxConstraints(minHeight: 10, maxHeight: double.infinity),
              child: SizedBox(
                height: 160,
                child: displayQuote(),
                ),
            ),
          // ),
          Expanded(
              child: Center(
            child: Column(
              children: [
                drawLine(),
                commentNotEmpty
                    ? displayCommentSection()
                    : Text(
                        noComments,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                drawLine(),
                Text(
                  commentInfo,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                drawLine(),
                textFieldWidget(),
              ],
            ),
          ))
        ]),
      ),
      floatingActionButton: displaySaveButton(),
    );
  }

  Widget displayAuthor() {
    return Center(
      child: Text(
        widget.quote.author,
        style: Theme.of(context).textTheme.headlineMedium,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget displayQuote() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 11.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: amberOpaq,
            blurRadius: 21.0,
            offset: const Offset(0.0, 0.0),
          )
        ],
      ),
      child: Center(
        child: Text(
          widget.quote.quote,
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void editComment() {
    setState(() {
      textEditorController.text = widget.quote.comment;
    });
  }

  Widget textFieldWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 11.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: amberLightOpaq,
            blurRadius: 10.0,
            offset: const Offset(0.0, 0.0),
          )
        ],
      ),
      child: Column(children: [
        TextField(
          controller: textEditorController,
          decoration: const InputDecoration(hintText: enterCommentPrompt),
          autofocus: true,
          maxLength: 160,
          minLines: 1,
          maxLines: 3,
        ),
        // displaySaveButton(),
      ]),
    );
  }

  Widget displayCommentSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.end,
            alignment: WrapAlignment.spaceBetween,
            spacing: 10,
            direction: Axis.horizontal,
            children: [
              Text(
                comment,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
        Column(
          children: [
            IconButton(
                onPressed: editComment,
                icon: Icon(
                  Icons.edit_outlined,
                  color: amber900,
                )),
            IconButton(
                onPressed: editComment,
                icon: Icon(
                  Icons.delete_outline_outlined,
                  color: amber900,
                )),
          ],
        ),
      ],
    );
  }

  Widget displaySaveButton() {
    return FloatingActionButton(
        onPressed: () {
          if (textEditorController.text.isNotEmpty) {
            final tq = widget.quote;
            var qouteToSave =
                Quote(tq.id, tq.author, tq.quote, textEditorController.text);

            QuoteManager.instance.updatequote(qouteToSave);
            setState(() {
              comment = qouteToSave.comment;
              commentNotEmpty = true;
            });
            textEditorController.text = "";
          }
        },
        child: Icon(
          Icons.save_alt_outlined,
          color: amber900,
        ));
  }
}
