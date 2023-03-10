import 'dart:async';
import 'package:media_plex/core/utils/constants.dart';
import 'package:media_plex/media_plex/tv_series/data/models/tv_series_table.dart';
import 'package:sqflite/sqflite.dart';

class TVSeriesDatabaseHelper {
  static TVSeriesDatabaseHelper? _databaseHelper;
  TVSeriesDatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory TVSeriesDatabaseHelper() =>
      _databaseHelper ?? TVSeriesDatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/media_plex_tv_series.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $tblWatchlist (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
  }

  Future<int> insertWatchlist(TVSeriesTable tvSeries) async {
    final db = await database;
    return await db!.insert(tblWatchlist, tvSeries.toJson());
  }

  Future<int> removeWatchlist(TVSeriesTable tvSeries) async {
    final db = await database;
    return await db!.delete(
      tblWatchlist,
      where: 'id = ?',
      whereArgs: [tvSeries.id],
    );
  }

  Future<Map<String, dynamic>?> getTVSeriesById(int id) async {
    final db = await database;
    final results = await db!.query(
      tblWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistTVSeries() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(tblWatchlist);

    return results;
  }
}
