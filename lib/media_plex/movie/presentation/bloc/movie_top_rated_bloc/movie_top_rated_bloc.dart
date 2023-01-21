import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:media_plex/media_plex/movie/domain/entities/movie.dart';
import 'package:media_plex/media_plex/movie/domain/usecases/get_top_rated_movies.dart';

part 'movie_top_rated_event.dart';
part 'movie_top_rated_state.dart';

class MovieTopRatedBloc extends Bloc<MovieTopRatedEvent, MovieTopRatedState> {
  final GetTopRatedMovies _getTopRatedMovies;

  MovieTopRatedBloc(this._getTopRatedMovies) : super(MovieTopRatedEmpty()) {
    on<FetchMovieTopRated>(
      (event, emit) async {
        emit(MovieTopRatedLoading());

        final topRatedResult = await _getTopRatedMovies.execute();

        topRatedResult.fold(
          (failure) => emit(MovieTopRatedError(failure.message)),
          (data) => emit(MovieTopRatedHasData(data)));
        },
    );
  }
}