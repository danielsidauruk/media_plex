import 'package:dartz/dartz.dart';
import 'package:media_plex/core/utils/failure.dart';
import 'package:media_plex/media_plex/movie/domain/entities/movie.dart';
import 'package:media_plex/media_plex/movie/domain/repositories/movie_repository.dart';
import 'package:media_plex/shared/domain/use_cases/use_case.dart';

class GetPopularMovies extends UseCase<List<Movie>, NoParams>{
  final MovieRepository repository;
  GetPopularMovies(this.repository);

  @override
  Future<Either<Failure, List<Movie>>> call(NoParams params) {
    return repository.getPopularMovies();
  }
}
