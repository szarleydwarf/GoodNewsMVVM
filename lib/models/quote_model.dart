import '../misc/constants.dart';

class Quote {
  final int id;
  final String author;
  final String quote;
  final String comment;

  const Quote(
    this.id,
    this.author,
    this.quote,
    this.comment,
  );

  Quote.empty() : this(0, emptyString, emptyString, emptyString);

  Quote.fromDb(Map<String, dynamic> map)
      : id = map[dbID],
        author = map[dbAuthor],
        quote = map[dbQuote],
        comment = map[dbComment];

  factory Quote.fromJSON(Map<String, dynamic> json) {
    return Quote(0, json[jsonAuthor], json[jsonQuote], emptyString);
  }

  Map<String, dynamic> toMap() {
    return {
      dbAuthor: author,
      dbQuote: quote,
      dbComment: comment,
    };
  }
}
