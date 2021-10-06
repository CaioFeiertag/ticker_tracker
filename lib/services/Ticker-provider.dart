import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:ticker_tracker/models/tickerDB.dart';

class TickerProvider {
  static final TickerProvider _instance = new TickerProvider.internal();
  static final String tableName = "Ticker";
  factory TickerProvider() => _instance;

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }

    _db = await initDb();
    return _db!;
  }

  TickerProvider.internal();

  initDb() async {
    return openDatabase('ticker.db', version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE Ticker(code TEXT PRIMARY KEY, name TEXT NOT NULL)");

    print("Table is created");
  }

  //insertion
  Future<int> addTicker(TickerDB ticker) async {
    var dbClient = await db;
    int res = await dbClient.insert("Ticker", ticker.toMap());
    return res;
  }

  //deletion
  Future<int> deleteTicker(TickerDB ticker) async {
    var dbClient = await db;
    final code = ticker.code;

    int res = await dbClient.delete(TickerProvider.tableName,
        where: 'code = "$code"');

    return res;
  }

  Future<Iterable<TickerDB>> listTickers() async {
    var dbClient = await db;

    List<Map<String, dynamic>> res =
        await dbClient.query(TickerProvider.tableName);

    return res.map((data) => TickerDB(code: data["code"], name: data["name"]));
  }
}
