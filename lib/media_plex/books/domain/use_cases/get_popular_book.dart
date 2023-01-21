import 'package:dartz/dartz.dart';
import 'package:media_plex/core/use_case.dart';
import 'package:media_plex/core/utils/failure.dart';
import 'package:media_plex/media_plex/books/domain/entities/book_popular.dart';
import 'package:media_plex/media_plex/books/domain/repositories/books_repository.dart';

class GetPopularBook extends UseCase<Popular, NoParams> {
  LibraryBookRepository repository;

  GetPopularBook({required this.repository});

  @override
  Future<Either<Failure, Popular>> call(NoParams params) async {
    return await repository.getPopularBooks();
  }
}