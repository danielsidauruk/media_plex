part of 'tv_series_recommendation_bloc.dart';

abstract class TVSeriesRecommendationState extends Equatable {
  const TVSeriesRecommendationState();

  @override
  List<Object> get props => [];
}

class TVSeriesRecommendationEmpty extends TVSeriesRecommendationState {}

class TVSeriesRecommendationLoading extends TVSeriesRecommendationState {}

class TVSeriesRecommendationError extends TVSeriesRecommendationState {
  final String message;

  const TVSeriesRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}

class TVSeriesRecommendationHasData extends TVSeriesRecommendationState {
  final List<TVSeries> result;

  const TVSeriesRecommendationHasData(this.result);

  @override
  List<Object> get props => [result];
}
