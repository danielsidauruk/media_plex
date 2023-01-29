import 'package:dartz/dartz.dart';
import 'package:media_plex/core/utils/failure.dart';
import 'package:media_plex/media_plex/books/data/models/book_table.dart';
import 'package:media_plex/media_plex/books/domain/repositories/books_repository.dart';

class GetBookMark {
  GetBookMark(this.repository);
  final BookRepository repository;

  Future<Either<Failure, List<BookTableModel>>> execute() {
    return repository.getBookmark();
  }
}