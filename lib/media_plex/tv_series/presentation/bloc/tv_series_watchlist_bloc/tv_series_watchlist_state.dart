part of 'tv_series_watchlist_bloc.dart';

abstract class TVSeriesWatchlistState extends Equatable {
  const TVSeriesWatchlistState();

  @override
  List<Object> get props => [];
}

class TVSeriesWatchlistEmpty extends TVSeriesWatchlistState {}

class TVSeriesWatchlistLoading extends TVSeriesWatchlistState {}

class TVSeriesWatchlistError extends TVSeriesWatchlistState {
  final String message;

  const TVSeriesWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class TVSeriesWatchlistHasData extends TVSeriesWatchlistState {
  final List<TVSeries> result;

  const TVSeriesWatchlistHasData(this.result);

  @override
  List<Object> get props => [result];
}

class WatchlistFailure extends TVSeriesWatchlistState {
  final String message;

  const WatchlistFailure(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistSuccess extends TVSeriesWatchlistState {
  final String message;

  const WatchlistSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistHasData extends TVSeriesWatchlistState {
  final bool isAdded;

  const WatchlistHasData(this.isAdded);

  @override
  List<Object> get props => [isAdded];
}
