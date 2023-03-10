import 'dart:async';
import 'package:media_plex/core/utils/constants.dart';
import 'package:media_plex/media_plex/books/data/models/book_table.dart';
import 'package:sqflite/sqflite.dart';

class BookDatabaseHelper {
  static BookDatabaseHelper? _databaseHelper;

  BookDatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory BookDatabaseHelper() =>
      _databaseHelper ?? BookDatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/media_plex_books.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tblBookmark (
        key TEXT PRIMARY KEY,
        title TEXT
      );
    ''');
  }

  Future<int> insertBookmark(BookTableModel bookTable) async {
    final db = await database;
    return await db!.insert(tblBookmark, bookTable.toJson());
  }

  Future<int> removeBookmark(BookTableModel bookTable) async {
    final db = await database;
    return await db!.delete(
      tblBookmark,
      where: 'key = ?',
      whereArgs: [bookTable.key],
    );
  }

  Future<Map<String, dynamic>?> getBookByKey(String key) async {
    final db = await database;
    final results = await db!.query(
      tblBookmark,
      where: 'key = ?',
      whereArgs: [key],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getBookmarkedBook() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(tblBookmark);

    return results;
  }
}




















