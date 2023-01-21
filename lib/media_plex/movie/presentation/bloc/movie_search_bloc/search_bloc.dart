import 'package:media_plex/media_plex/movie/domain/usecases/search_movies.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:media_plex/media_plex/movie/domain/entities/movie.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchMoviesBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies _searchMovies;

  SearchMoviesBloc(this._searchMovies) : super(SearchEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchLoading());
      final searchResult = await _searchMovies.execute(query);

      searchResult.fold(
            (failure) => emit(SearchError(failure.message)),
            (data) => emit(SearchHasData(data)),);
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
