import 'package:media_plex/media_plex/books/data/data_sources/database/book_database_helper.dart';
import 'package:media_plex/core/utils/exception.dart';
import 'package:media_plex/media_plex/books/data/models/book_table.dart';

abstract class BookLocalDataSource {
  Future<String> insertBookmark(BookTable book);
  Future<String> removeBookmark(BookTable book);
  Future<BookTable?> getBookByKey(String key);
  Future<List<BookTable>> getBookmarkedBook();
}

class BookLocalDataSourceImpl implements BookLocalDataSource {
  BookLocalDataSourceImpl({required this.databaseHelper});
  final BookDatabaseHelper databaseHelper;

  @override
  Future<String> insertBookmark(BookTable book) async {
    try {
      await databaseHelper.insertBookmark(book);
      return 'Bookmarked';
    } catch(e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeBookmark(BookTable book) async {
    try {
      await databaseHelper.removeBookmark(book);
      return 'unBookmarked';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<BookTable?> getBookByKey(String key) async {
    final result = await databaseHelper.getBookByKey(key);
    if (result != null) {
      return BookTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<BookTable>> getBookmarkedBook() async {
    final result = await databaseHelper.getBookmarkedBook();
    return result.map((data) => BookTable.fromMap(data)).toList();
  }
}