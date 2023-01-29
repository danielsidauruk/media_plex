import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:media_plex/core/utils/failure.dart';
import 'package:media_plex/media_plex/books/domain/entities/search_the_book.dart';
import 'package:media_plex/media_plex/books/domain/repositories/books_repository.dart';
import 'package:media_plex/shared/domain/use_cases/use_case.dart';

class SearchBook extends UseCase<SearchTheBook, Params> {
  BookRepository repository;

  SearchBook({required this.repository});

  @override
  Future<Either<Failure, SearchTheBook>> call(Params params) async {
    return await repository.searchTheBook(params.query);
  }
}

class Params extends Equatable {
  const Params({required this.query});
  final String query;

  @override
  List<Object?> get props => [query];
}
