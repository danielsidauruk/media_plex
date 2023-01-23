import 'package:dartz/dartz.dart';
import 'package:media_plex/media_plex/books/domain/entities/book_popular.dart';
import 'package:media_plex/media_plex/books/domain/entities/book_detail.dart';
import 'package:media_plex/media_plex/books/domain/entities/search.dart';

import '../../../../core/utils/failure.dart';

abstract class LibraryBookRepository {
  Future<Either<Failure, BookDetail>> getBookDetail(String key);
  // Future<Either<Failure, Author>> getAuthor(String author);
  Future<Either<Failure, Search>> searchBooks(String query);
  Future<Either<Failure, Popular>> getPopularBooks(String dataSortQuery);
}
