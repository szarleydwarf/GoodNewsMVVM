import 'package:good_news_app/models/quote_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import '../misc/constants.dart';

class QuoteManager {
  late Future<Database> database;

  static final QuoteManager _instance = QuoteManager._internal();
  late List<Quote> _qoutes = [];

  QuoteManager._internal() {
    _initDataBase();
  }

  static QuoteManager get instance => _instance;

  List<Quote> getQuotesList() {
    return _qoutes;
  }

  // add
  void add(Quote quote) {
    if (!isExisting(quote)) {
      _qoutes.add(quote);
    }
  }

  // update
  void update(Quote quote) {}
  //remove
  void remove(Quote quote) {}

  bool isExisting(Quote quote) {
    if (_qoutes.map((e) => e.quote).contains(quote.quote)) {
      return true;
    }
    return false;
  }

  // SQFLITE database
  Future<void> _initDataBase() async {
    final dbDirectory = await getApplicationSupportDirectory();
    final dbFilePath = dbDirectory.path;

    String path = join(dbFilePath, databasePath);
    print(dbFilePath);
    database = openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE quotes($dbID INTEGER PRIMARY KEY, $dbAuthor TEXT, $dbQuote TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> _insert(Quote quote) async {
    final db = await database;
    bool isExist = await checkIfExist(quote);
    if (!isExist) {
      await db.insert(
        databaseName,
        quote.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  // Future<List<Quote>>
  Future<void> _getQuotes() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(databaseName);

    _qoutes = List.generate(maps.length, (i) {
      return Quote(
        maps[i][dbID] as int,
        maps[i][dbAuthor] as String,
        maps[i][dbQuote] as String,
      );
    });
  }

  Future<void> _updatequote(Quote quote) async {
    final db = await database;

    await db.update(
      databaseName,
      quote.toMap(),
      where: dbIDSearch,
      whereArgs: [quote.id],
    );
  }

  Future<void> _deleteQuote(int id) async {
    final db = await database;

    await db.delete(
      databaseName,
      where: dbIDSearch,
      whereArgs: [id],
    );
  }

  Future<bool> checkIfExist(Quote quote) async {
    final db = await database;

    List<Map<String, dynamic>> maps = await db.query(
      databaseName,
      where: dbQuoteSearch,
      whereArgs: [quote.quote],
    );
    if (maps.isNotEmpty) {
      return true;
    }

    return false;
  }
}
