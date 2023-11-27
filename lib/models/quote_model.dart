class Quote {
  final String author;
  final String quote;

  const Quote({
    required this.author,
    required this.quote,
  });

  factory Quote.fromJSON(Map<String, dynamic> json) {
    return Quote(author: json['quoteAuthor'], quote: json['quoteText']);
  }
}