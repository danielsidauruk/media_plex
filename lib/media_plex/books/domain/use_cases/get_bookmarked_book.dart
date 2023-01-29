import 'package:dartz/dartz.dart';
import 'package:media_plex/core/utils/failure.dart';
import 'package:media_plex/media_plex/books/data/models/book_table.dart';
import 'package:media_plex/media_plex/books/domain/repositories/books_repository.dart';
import 'package:media_plex/shared/domain/use_cases/use_case.dart';

class GetBookMark extends UseCase<List<BookTableModel>, NoParams>{
  GetBookMark(this.repository);
  final BookRepository repository;

  @override
  Future<Either<Failure, List<BookTableModel>>> call(NoParams params) {
    return repository.getBookmark();
  }
}