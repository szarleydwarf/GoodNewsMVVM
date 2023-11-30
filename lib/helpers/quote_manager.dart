import 'package:good_news_app/models/quote_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../misc/constants.dart';

class QuoteManager {
  late Future<Database> database;

  QuoteManager() {
    initDataBase();
  }

  initDataBase() async {
    database = openDatabase(
      join(
        await getDatabasesPath(),
      ),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE quotes(id INTEGER PRIMARY KEY AUTOINCREMENT, autor TEXT, quote TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insert(Quote quote) async {
    final db = await database;

    await db.insert(
      databaseName,
      quote.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
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
}
