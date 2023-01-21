part of 'tv_series_recommendation_bloc.dart';

abstract class TVSeriesRecommendationEvent extends Equatable {
  const TVSeriesRecommendationEvent();

  @override
  List<Object> get props => [];
}

class FetchTVSeriesRecommendation extends TVSeriesRecommendationEvent {
  final int id;

  const FetchTVSeriesRecommendation(this.id);

  @override
  List<Object> get props => [id];
}
