import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_plex/media_plex/tv_series/domain/entities/tv_series.dart';
import 'package:media_plex/media_plex/tv_series/domain/usecases/get_tv_series_recommendations.dart';

part 'tv_series_recommendation_event.dart';
part 'tv_series_recommendation_state.dart';

class TVSeriesRecommendationBloc
    extends Bloc<TVSeriesRecommendationEvent, TVSeriesRecommendationState> {
  final GetTVSeriesRecommendations _getTVSeriesRecommendations;

  TVSeriesRecommendationBloc(this._getTVSeriesRecommendations)
      : super(TVSeriesRecommendationEmpty()) {
    on<FetchTVSeriesRecommendation>((event, emit) async {
      final id = event.id;

      emit(TVSeriesRecommendationLoading());

      final recommendationResult =
          await _getTVSeriesRecommendations.execute(id);

      recommendationResult.fold(
          (failure) => emit(TVSeriesRecommendationError(failure.message)),
          (data) => emit(TVSeriesRecommendationHasData(data)));
    });
  }
}
