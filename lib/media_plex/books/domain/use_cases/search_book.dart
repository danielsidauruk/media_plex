import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:media_plex/core/utils/failure.dart';
import 'package:media_plex/media_plex/books/domain/entities/search.dart';
import 'package:media_plex/media_plex/books/domain/repositories/books_repository.dart';
import 'package:media_plex/shared/domain/use_cases/use_case.dart';

class SearchBook extends UseCase<Search, Params> {
  BookRepository repository;

  SearchBook({required this.repository});

  @override
  Future<Either<Failure, Search>> call(Params params) async {
    return await repository.searchBooks(params.query);
  }
}

class Params extends Equatable {
  const Params({required this.query});
  final String query;

  @override
  List<Object?> get props => [query];
}
