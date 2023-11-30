import '../misc/constants.dart';

class Quote {
  final int id;
  final String author;
  final String quote;

  const Quote(
    this.id,
    this.author,
    this.quote,
  );

  Quote.empty() : this(0, emptyString, emptyString);

  Quote.fromDb(Map<String, dynamic> map)
      : id = map[dbID],
        author = map[dbAuthor],
        quote = map[dbQuote];

  factory Quote.fromJSON(Map<String, dynamic> json) {
    return Quote(0, json[jsonAuthor], json[jsonQuote]);
  }

  Map<String, dynamic> toMap() {
    return {
      dbID: id,
      dbAuthor: author,
      dbQuote: quote,
    };
  }
}
