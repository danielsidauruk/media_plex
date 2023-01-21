import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_plex/media_plex/tv_series/domain/entities/tv_series.dart';
import 'package:media_plex/media_plex/tv_series/domain/entities/tv_series_detail.dart';
import 'package:media_plex/media_plex/tv_series/domain/usecases/get_watchlist_tv_series.dart';
import 'package:media_plex/media_plex/tv_series/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:media_plex/media_plex/tv_series/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:media_plex/media_plex/tv_series/domain/usecases/save_watchlist_tv_series.dart';

part 'tv_series_watchlist_event.dart';
part 'tv_series_watchlist_state.dart';

class TVSeriesWatchlistBloc
    extends Bloc<TVSeriesWatchlistEvent, TVSeriesWatchlistState> {
  final GetWatchlistTVSeries _getWatchlistTVSeries;
  final GetWatchlistTVSeriesStatus _getWatchListTVSeriesStatus;
  final SaveWatchlistTVSeries _saveWatchlistTVSeries;
  final RemoveWatchlistTVSeries _removeWatchlistTVSeries;

  TVSeriesWatchlistBloc(
      this._getWatchlistTVSeries,
      this._getWatchListTVSeriesStatus,
      this._saveWatchlistTVSeries,
      this._removeWatchlistTVSeries)
      : super(TVSeriesWatchlistEmpty()) {
    on<FetchWatchlistTVSeries>(
      (event, emit) async {
        emit(TVSeriesWatchlistLoading());
        final watchlistResult = await _getWatchlistTVSeries.execute();

        watchlistResult.fold(
          (failure) => emit(TVSeriesWatchlistError(failure.message)),
          (data) => emit(TVSeriesWatchlistHasData(data)));
        },
    );
    on<LoadWatchlistTVSeriesStatus>(((event, emit) async {
      final id = event.id;
      final result = await _getWatchListTVSeriesStatus.execute(id);

      emit(WatchlistHasData(result));
    }));
    on<AddWatchlistTVSeries>((event, emit) async {
      final tvSeries = event.tvSeriesDetail;

      final result = await _saveWatchlistTVSeries.execute(tvSeries);

      result.fold(
        (failure) => emit(WatchlistFailure(failure.message)),
        (successMessage) => emit(const WatchlistSuccess('Added to Watchlist')));
      add(LoadWatchlistTVSeriesStatus(tvSeries.id));
    });

    on<DeleteWatchlistTVSeries>((event, emit) async {
      final tvSeries = event.tvSeriesDetail;

      final result = await _removeWatchlistTVSeries.execute(tvSeries);
      result.fold((failure) => emit(WatchlistFailure(failure.message)),
       (successMessage) => emit(const WatchlistSuccess('Removed from Watchlist')));
      add(LoadWatchlistTVSeriesStatus(tvSeries.id));
    });
  }
}
