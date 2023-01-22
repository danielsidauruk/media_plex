import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:media_plex/core/use_case.dart';
import 'package:media_plex/core/utils/failure.dart';
import 'package:media_plex/media_plex/books/domain/entities/book_popular.dart';
import 'package:media_plex/media_plex/books/domain/repositories/books_repository.dart';

class GetPopularBook extends UseCase<Popular, Params> {
  LibraryBookRepository repository;

  GetPopularBook({required this.repository});

  @override
  Future<Either<Failure, Popular>> call(Params params) async {
    return await repository.getPopularBooks(params.dataSortQuery);
  }
}

class Params extends Equatable {
  const Params({required this.dataSortQuery});
  final String dataSortQuery;

  @override
  List<Object?> get props => [dataSortQuery];
}