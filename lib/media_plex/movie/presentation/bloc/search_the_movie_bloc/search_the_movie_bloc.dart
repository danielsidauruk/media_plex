import 'package:media_plex/media_plex/movie/domain/usecases/search_the_movies.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:media_plex/media_plex/movie/domain/entities/movie.dart';

part 'search_the_movie_event.dart';
part 'search_the_movie_state.dart';

class SearchTheMovieBloc extends Bloc<SearchTheMovieEvent, SearchTheMovieState> {
  final SearchTheMovies searchMovies;

  SearchTheMovieBloc(this.searchMovies) : super(SearchTheMovieEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchTheMovieLoading());
      final searchResult = await searchMovies.call(Params(query: query));

      searchResult.fold(
            (failure) => emit(SearchTheMovieError(failure.message)),
            (data) => emit(SearchTheMovieHasData(data)),);
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
