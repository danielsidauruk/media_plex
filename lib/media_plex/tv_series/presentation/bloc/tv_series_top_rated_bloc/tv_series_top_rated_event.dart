part of 'tv_series_top_rated_bloc.dart';

abstract class TVSeriesTopRatedEvent extends Equatable {
  const TVSeriesTopRatedEvent();

  @override
  List<Object> get props => [];
}

class FetchTVSeriesTopRated extends TVSeriesTopRatedEvent {}
