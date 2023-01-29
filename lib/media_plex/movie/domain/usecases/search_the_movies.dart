import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:media_plex/core/utils/failure.dart';
import 'package:media_plex/media_plex/movie/domain/entities/movie.dart';
import 'package:media_plex/media_plex/movie/domain/repositories/movie_repository.dart';
import 'package:media_plex/shared/domain/use_cases/use_case.dart';

class SearchTheMovies extends UseCase<List<Movie>, Params>{
  final MovieRepository repository;
  SearchTheMovies(this.repository);

  @override
  Future<Either<Failure, List<Movie>>> call(Params params) {
    return repository.searchTheMovie(params.query);
  }
}

class Params extends Equatable {
  final String query;
  const Params({required this.query});

  @override
  List<Object?> get props => [query];
}
