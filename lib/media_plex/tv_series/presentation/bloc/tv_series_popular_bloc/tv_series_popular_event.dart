part of 'tv_series_popular_bloc.dart';

abstract class TVSeriesPopularEvent extends Equatable {
  const TVSeriesPopularEvent();

  @override
  List<Object> get props => [];
}

class FetchTVSeriesPopular extends TVSeriesPopularEvent {}
