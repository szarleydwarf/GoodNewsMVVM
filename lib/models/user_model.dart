import '../models/quote_model.dart';

class User {
  String id = "";
  String name;
  bool isExisting;
  List<Quote> quotes = [];

  User(this.id, this.name, this.isExisting);

  User.empty() : this("", "", false);

  void printMyself() {
    print("I am $name + $id + $isExisting");
  }
}
