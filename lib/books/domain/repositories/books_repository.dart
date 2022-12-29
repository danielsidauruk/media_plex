import 'package:media_plex/core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:media_plex/books/domain/entities/books_details.dart';
import 'package:media_plex/books/domain/entities/search.dart';

abstract class LibraryBookRepository {
  Future<Either<Failure, BookDetail>> getBookDetail(String key);
  // Future<Either<Failure, Author>> getAuthor(String author);
  Future<Either<Failure, Search>> searchBooks(String query);
}
