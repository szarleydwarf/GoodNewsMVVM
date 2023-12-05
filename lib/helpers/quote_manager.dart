import 'package:good_news_app/models/quote_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import '../misc/constants.dart';

class QuoteManager {
  late Future<Database> database;

  static final QuoteManager _instance = QuoteManager._internal();

  QuoteManager._internal() {
    initDataBase();
  }

  static QuoteManager get instance => _instance;

  initDataBase() async {
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

  Future<void> insert(Quote quote) async {
    final db = await database;
    bool isExist = await checkIfExist(quote) == Quote.empty();
    if (!isExist) {
      await db.insert(
        databaseName,
        quote.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Quote>> getQuotes() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(databaseName);

    return List.generate(maps.length, (i) {
      return Quote(
        maps[i][dbID] as int,
        maps[i][dbAuthor] as String,
        maps[i][dbQuote] as String,
      );
    });
  }

  Future<void> updatequote(Quote quote) async {
    final db = await database;

    await db.update(
      databaseName,
      quote.toMap(),
      where: dbIDSearch,
      whereArgs: [quote.id],
    );
  }

  Future<void> deleteQuote(int id) async {
    final db = await database;

    await db.delete(
      databaseName,
      where: dbIDSearch,
      whereArgs: [id],
    );
  }

  Future<Quote> checkIfExist(Quote quote) async {
    final db = await database;

    List<Map<String, dynamic>> maps = await db.query(
      databaseName,
      where: dbQuoteSearch,
      whereArgs: [quote.quote],
    );
    if (maps.isNotEmpty) {
      return Quote.fromDb(maps.first);
    }

    return Quote.empty();
  }
}
