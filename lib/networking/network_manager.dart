import 'dart:convert';

import '../misc/constants.dart';

import 'package:http/http.dart' as http;

class NetworkManager {
  Future<Quote> fetchQuote() async {
    final response = await http.get(Uri.parse(quotesAPI));
    if (response.statusCode == 200) {
      String fixed = response.body.replaceAll(r"\'", "'");
    print("fixed $fixed");
      return Quote.fromJSON(jsonDecode(fixed) as Map<String, dynamic>);
    } else {
      throw Exception("FETCHING FAILED WITH STATUS CODE $response.statusCode");
    }
  }
}

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
