part of 'tv_series_watchlist_bloc.dart';

abstract class TVSeriesWatchlistEvent extends Equatable {
  const TVSeriesWatchlistEvent();

  @override
  List<Object> get props => [];
}

class FetchWatchlistTVSeries extends TVSeriesWatchlistEvent {}

class AddWatchlistTVSeries extends TVSeriesWatchlistEvent {
  final TVSeriesDetail tvSeriesDetail;

  const AddWatchlistTVSeries(this.tvSeriesDetail);

  @override
  List<Object> get props => [tvSeriesDetail];
}

class DeleteWatchlistTVSeries extends TVSeriesWatchlistEvent {
  final TVSeriesDetail tvSeriesDetail;

  const DeleteWatchlistTVSeries(this.tvSeriesDetail);

  @override
  List<Object> get props => [tvSeriesDetail];
}

class LoadWatchlistTVSeriesStatus extends TVSeriesWatchlistEvent {
  final int id;

  const LoadWatchlistTVSeriesStatus(this.id);

  @override
  List<Object> get props => [id];
}
