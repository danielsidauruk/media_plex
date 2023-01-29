import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:media_plex/media_plex/movie/domain/entities/movie.dart';
import 'package:media_plex/media_plex/movie/domain/usecases/get_movie_recommendations.dart';

part 'movie_recommendations_event.dart';
part 'movie_recommendations_state.dart';

class MovieRecommendationBloc
    extends Bloc<MovieRecommendationEvent, MovieRecommendationState> {
  final GetMovieRecommendations getMovieRecommendations;

  MovieRecommendationBloc(this.getMovieRecommendations)
      : super(MovieRecommendationEmpty()) {
    on<FetchMovieRecommendation>((event, emit) async {
      final id = event.id;

      emit(MovieRecommendationLoading());

      final recommendationResult = await getMovieRecommendations.call(Params(id: id));

      recommendationResult.fold(
        (failure) => emit(MovieRecommendationError(failure.message)),
        (data) => emit(MovieRecommendationHasData(data)),
      );
    });
  }
}
