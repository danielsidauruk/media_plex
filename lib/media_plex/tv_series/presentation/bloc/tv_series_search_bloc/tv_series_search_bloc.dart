import 'package:media_plex/media_plex/tv_series/domain/usecases/search_tv_series.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_plex/media_plex/tv_series/domain/entities/tv_series.dart';

part 'tv_series_search_event.dart';
part 'tv_series_search_state.dart';

class SearchTVSeriesBloc extends Bloc<SearchEvent, SearchState> {
  final SearchTVSeries _searchTVSeries;

  SearchTVSeriesBloc(this._searchTVSeries) : super(SearchEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchLoading());
      final searchResult = await _searchTVSeries.execute(query);

      searchResult.fold((failure) => emit(SearchError(failure.message)),
          (data) => emit(SearchHasData(data)));
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
