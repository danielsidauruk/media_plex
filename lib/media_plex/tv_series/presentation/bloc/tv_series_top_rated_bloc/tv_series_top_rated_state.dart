part of 'tv_series_top_rated_bloc.dart';

abstract class TVSeriesTopRatedState extends Equatable {
  const TVSeriesTopRatedState();

  @override
  List<Object> get props => [];
}

class TVSeriesTopRatedEmpty extends TVSeriesTopRatedState {}

class TVSeriesTopRatedLoading extends TVSeriesTopRatedState {}

class TVSeriesTopRatedError extends TVSeriesTopRatedState {
  final String message;

  const TVSeriesTopRatedError(this.message);

  @override
  List<Object> get props => [message];
}

class TVSeriesTopRatedHasData extends TVSeriesTopRatedState {
  final List<TVSeries> result;

  const TVSeriesTopRatedHasData(this.result);

  @override
  List<Object> get props => [result];
}
