part of 'tv_series_on_air_bloc.dart';

abstract class TVSeriesOnAirEvent extends Equatable {
  const TVSeriesOnAirEvent();

  @override
  List<Object> get props => [];
}

class FetchTVSeriesOnAir extends TVSeriesOnAirEvent {}
