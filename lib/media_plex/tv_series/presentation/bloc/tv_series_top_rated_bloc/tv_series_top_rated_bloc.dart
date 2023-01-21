import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_plex/media_plex/tv_series/domain/entities/tv_series.dart';
import 'package:media_plex/media_plex/tv_series/domain/usecases/get_top_rated_tv_series.dart';

part 'tv_series_top_rated_event.dart';
part 'tv_series_top_rated_state.dart';

class TVSeriesTopRatedBloc
    extends Bloc<TVSeriesTopRatedEvent, TVSeriesTopRatedState> {
  final GetTopRatedTVSeries _getTopRatedTVSeries;

  TVSeriesTopRatedBloc(this._getTopRatedTVSeries)
      : super(TVSeriesTopRatedEmpty()) {
    on<FetchTVSeriesTopRated>(
      (event, emit) async {
        emit(TVSeriesTopRatedLoading());

        final topRatedResult = await _getTopRatedTVSeries.execute();

        topRatedResult.fold(
            (failure) => emit(TVSeriesTopRatedError(failure.message)),
            (data) => emit(TVSeriesTopRatedHasData(data)));
      },
    );
  }
}
