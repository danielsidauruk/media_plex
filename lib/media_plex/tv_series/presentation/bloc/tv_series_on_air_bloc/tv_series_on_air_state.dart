part of 'tv_series_on_air_bloc.dart';

abstract class TVSeriesOnAirState extends Equatable {
  const TVSeriesOnAirState();

  @override
  List<Object> get props => [];
}

class TVSeriesOnAirEmpty extends TVSeriesOnAirState {}

class TVSeriesOnAirLoading extends TVSeriesOnAirState {}

class TVSeriesOnAirError extends TVSeriesOnAirState {
  final String message;

  const TVSeriesOnAirError(this.message);

  @override
  List<Object> get props => [message];
}

class TVSeriesOnAirHasData extends TVSeriesOnAirState {
  final List<TVSeries> result;

  const TVSeriesOnAirHasData(this.result);

  @override
  List<Object> get props => [result];
}
