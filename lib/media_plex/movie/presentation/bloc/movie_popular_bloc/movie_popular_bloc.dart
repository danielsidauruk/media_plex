import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:media_plex/media_plex/movie/domain/entities/movie.dart';
import 'package:media_plex/media_plex/movie/domain/usecases/get_popular_movies.dart';

part 'movie_popular_event.dart';
part 'movie_popular_state.dart';

class MoviePopularBloc extends Bloc<MoviePopularEvent, MoviePopularState> {
  final GetPopularMovies _getPopGetPopularMovies;

  MoviePopularBloc(this._getPopGetPopularMovies) : super(MoviePopularEmpty()) {
    on<FetchMoviePopular>(
      (event, emit) async {
        emit(MoviePopularLoading());

        final popularResult = await _getPopGetPopularMovies.execute();

        popularResult.fold(
          (failure) => emit(MoviePopularError(failure.message)),
          (data) => emit(MoviePopularHasData(data)));
      },
    );
  }
}
