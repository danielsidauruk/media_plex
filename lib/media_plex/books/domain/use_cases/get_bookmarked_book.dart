import 'package:dartz/dartz.dart';
import 'package:media_plex/core/utils/failure.dart';
import 'package:media_plex/media_plex/books/data/models/book_table.dart';
import 'package:media_plex/media_plex/books/domain/repositories/books_repository.dart';

class GetBookMarkedBook {
  GetBookMarkedBook(this.repository);
  final BookRepository repository;

  Future<Either<Failure, List<BookTable>>> execute() {
    return repository.getBookmarkedBook();
  }
}