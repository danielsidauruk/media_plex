import 'package:dartz/dartz.dart';
import 'package:media_plex/core/utils/failure.dart';
import 'package:media_plex/media_plex/books/data/models/book_table.dart';
import 'package:media_plex/media_plex/books/domain/entities/book_popular.dart';
import 'package:media_plex/media_plex/books/domain/entities/book_detail.dart';
import 'package:media_plex/media_plex/books/domain/entities/book_search.dart';
import 'package:media_plex/media_plex/books/domain/entities/book_subject.dart';

abstract class BookRepository {
  Future<Either<Failure, BookDetail>> getBookDetail(String key);
  // Future<Either<Failure, Author>> getAuthor(String author);
  Future<Either<Failure, Search>> searchBooks(String query);
  Future<Either<Failure, Popular>> getPopularBooks(String dataSortQuery);
  Future<Either<Failure, String>> saveBookmark(BookDetail book);
  Future<Either<Failure, String>> removeBookmark(BookDetail book);
  Future<Either<Failure, List<BookTable>>> getBookmarkedBook();
  Future<Either<Failure, BookSubject>> getSubjectBooks(String subjectName);
  Future<bool> isBookmarked(String key);
}
