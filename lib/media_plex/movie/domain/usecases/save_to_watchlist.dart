import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:media_plex/core/utils/failure.dart';
import 'package:media_plex/media_plex/movie/domain/entities/movie_detail.dart';
import 'package:media_plex/media_plex/movie/domain/repositories/movie_repository.dart';
import 'package:media_plex/shared/domain/use_cases/use_case.dart';

class SaveToWatchlist extends UseCase<String, SaveParams>{
  final MovieRepository repository;
  SaveToWatchlist(this.repository);

  @override
  Future<Either<Failure, String>> call(SaveParams params) {
    return repository.saveToWatchlist(params.movieDetail);
  }
}

class SaveParams extends Equatable {
  final MovieDetail movieDetail;
  const SaveParams({required this.movieDetail});

  @override
  List<Object?> get props => [movieDetail];
}
