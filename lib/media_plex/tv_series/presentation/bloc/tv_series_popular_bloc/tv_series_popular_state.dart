part of 'tv_series_popular_bloc.dart';

abstract class TVSeriesPopularState extends Equatable {
  const TVSeriesPopularState();

  @override
  List<Object> get props => [];
}

class TVSeriesPopularEmpty extends TVSeriesPopularState {}

class TVSeriesPopularLoading extends TVSeriesPopularState {}

class TVSeriesPopularError extends TVSeriesPopularState {
  final String message;

  const TVSeriesPopularError(this.message);

  @override
  List<Object> get props => [message];
}

class TVSeriesPopularHasData extends TVSeriesPopularState {
  final List<TVSeries> result;

  const TVSeriesPopularHasData(this.result);

  @override
  List<Object> get props => [result];
}
