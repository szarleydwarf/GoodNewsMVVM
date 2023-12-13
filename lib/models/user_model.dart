import 'package:good_news_app/misc/constants.dart';

import '../models/quote_model.dart';

class User {
  String id = emptyString;
  String name;
  bool isExisting;
  List<Quote> quotes = [];

  User(this.id, this.name, this.isExisting);

  User.empty() : this(emptyString, emptyString, false);
}
