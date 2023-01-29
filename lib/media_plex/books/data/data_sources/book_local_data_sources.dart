import 'package:media_plex/core/utils/exception.dart';
import 'package:media_plex/media_plex/books/data/data_sources/database/book_database_helper.dart';
import 'package:media_plex/media_plex/books/data/models/book_table.dart';

abstract class BookLocalDataSource {
  Future<String> insertBookmark(BookTableModel book);
  Future<String> removeBookmark(BookTableModel book);
  Future<BookTableModel?> getBookByKey(String key);
  Future<List<BookTableModel>> getBookmark();
}

class BookLocalDataSourceImpl implements BookLocalDataSource {
  BookLocalDataSourceImpl({required this.databaseHelper});
  final BookDatabaseHelper databaseHelper;

  @override
  Future<String> insertBookmark(BookTableModel book) async {
    try {
      await databaseHelper.insertBookmark(book);
      return 'Bookmarked';
    } catch(e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeBookmark(BookTableModel book) async {
    try {
      await databaseHelper.removeBookmark(book);
      return 'unBookmarked';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<BookTableModel?> getBookByKey(String key) async {
    final result = await databaseHelper.getBookByKey(key);
    if (result != null) {
      return BookTableModel.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<BookTableModel>> getBookmark() async {
    final result = await databaseHelper.getBookmarkedBook();
    return result.map((data) => BookTableModel.fromMap(data)).toList();
  }
}