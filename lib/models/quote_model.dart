class Quote {
  final int id;
  final String author;
  final String quote;

  const Quote(this.id, this.author, this.quote,);

  Quote.empty() : this(0, "", "");

  factory Quote.fromJSON(Map<String, dynamic> json) {
    return Quote( 0, json['quoteAuthor'], json['quoteText']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'autor': author,
      'quote': quote,
    };
  }
}