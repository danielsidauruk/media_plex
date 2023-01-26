import 'package:dartz/dartz.dart';
import 'package:media_plex/core/utils/failure.dart';
import 'package:media_plex/media_plex/books/domain/entities/book_detail.dart';
import 'package:media_plex/media_plex/books/domain/repositories/books_repository.dart';

class SaveBookmark {
  SaveBookmark(this.repository);
  final BookRepository repository;

  Future<Either<Failure, String>> execute(BookDetail book) {
    return repository.saveBookmark(book);
  }
}