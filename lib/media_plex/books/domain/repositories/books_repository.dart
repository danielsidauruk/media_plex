import 'package:dartz/dartz.dart';
import 'package:media_plex/core/utils/failure.dart';
import 'package:media_plex/media_plex/books/data/models/book_table.dart';
import 'package:media_plex/media_plex/books/domain/entities/popular_books.dart';
import 'package:media_plex/media_plex/books/domain/entities/book_detail.dart';
import 'package:media_plex/media_plex/books/domain/entities/search_the_book.dart';
import 'package:media_plex/media_plex/books/domain/entities/books_by_subject.dart';

abstract class BookRepository {
  Future<Either<Failure, BookDetail>> getBookDetail(String key);
  Future<Either<Failure, SearchTheBook>> searchTheBook(String query);
  Future<Either<Failure, PopularBooks>> getPopularBooks(String dataSortQuery);
  Future<Either<Failure, String>> saveToBookmark(BookDetail book);
  Future<Either<Failure, String>> removeFromBookmark(BookDetail book);
  Future<Either<Failure, List<BookTableModel>>> getBookmark();
  Future<Either<Failure, BooksBySubject>> getBookBySubject(String subjectName);
  Future<bool> isBookmarked(String key);
}
