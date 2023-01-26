import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:media_plex/core/utils/failure.dart';
import 'package:media_plex/media_plex/books/domain/entities/book_detail.dart';
import 'package:media_plex/media_plex/books/domain/repositories/books_repository.dart';
import 'package:media_plex/shared/domain/use_cases/use_case.dart';

class GetBookDetails extends UseCase<BookDetail, Params> {
  LibraryBookRepository repository;

  GetBookDetails({required this.repository});

  @override
  Future<Either<Failure, BookDetail>> call(Params params) async {
    return await repository.getBookDetail(params.key);
  }
}

class Params extends Equatable {
  const Params({required this.key});
  final String key;

  @override
  List<Object?> get props => [key];
}
