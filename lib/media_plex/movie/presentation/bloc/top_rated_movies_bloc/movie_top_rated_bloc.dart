import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:media_plex/media_plex/movie/domain/entities/movie.dart';
import 'package:media_plex/media_plex/movie/domain/usecases/get_top_rated_movies.dart';
import 'package:media_plex/shared/domain/use_cases/use_case.dart';

part 'movie_top_rated_event.dart';
part 'movie_top_rated_state.dart';

class TopRatedMoviesBloc extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMoviesBloc(this.getTopRatedMovies) : super(TopRatedMoviesEmpty()) {
    on<FetchTopRatedMovies>(
      (event, emit) async {
        emit(TopRatedMoviesLoading());

        final topRatedResult = await getTopRatedMovies.call(NoParams());

        topRatedResult.fold(
          (failure) => emit(TopRatedMoviesError(failure.message)),
          (data) => emit(TopRatedMoviesHasData(data)));
        },
    );
  }
}