import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../misc/constants.dart';
import '../models/quote_model.dart';

class NetworkManager {
  Future<Quote> fetchQuote() async {
    final response = await http.get(Uri.parse(quotesAPI));
    if (response.statusCode == 200) {
      String fixed = response.body.replaceAll(r"\'", "'");
      return Quote.fromJSON(jsonDecode(fixed) as Map<String, dynamic>);
    } else {
      throw Exception("FETCHING FAILED WITH STATUS CODE $response.statusCode");
    }
  }

  Future<Widget> fetchImage() async {
    final respone = await http.get(Uri.parse(imageAPI));
    if (respone.statusCode == 200) {
      var data = json.decode(respone.body);
      var hits = data["hits"] as List;
      var index = Random().nextInt(hits.length);
      var imageUri = hits[index]["webformatURL"];
      return Image.network(imageUri);
    } else {
      return const CircularProgressIndicator();
    }
  }
}
