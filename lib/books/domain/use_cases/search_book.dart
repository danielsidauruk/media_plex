import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:media_plex/core/failure.dart';
import 'package:media_plex/core/use_case.dart';
import 'package:media_plex/books/domain/entities/search.dart';
import 'package:media_plex/books/domain/repositories/books_repository.dart';

class SearchBook extends UseCase<Search, Params> {
  LibraryBookRepository repository;

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
