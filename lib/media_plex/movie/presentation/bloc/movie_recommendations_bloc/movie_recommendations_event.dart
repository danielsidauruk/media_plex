part of 'movie_recommendations_bloc.dart';

abstract class MovieRecommendationEvent extends Equatable {
  const MovieRecommendationEvent();

  @override
  List<Object> get props => [];
}

class FetchMovieRecommendation extends MovieRecommendationEvent {
  final int id;

  const FetchMovieRecommendation(this.id);

  @override
  List<Object> get props => [id];
}
