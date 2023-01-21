import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_plex/media_plex/tv_series/domain/entities/tv_series.dart';
import 'package:media_plex/media_plex/tv_series/domain/usecases/get_popular_tv_series.dart';

part 'tv_series_popular_event.dart';
part 'tv_series_popular_state.dart';

class TVSeriesPopularBloc
    extends Bloc<TVSeriesPopularEvent, TVSeriesPopularState> {
  final GetPopularTVSeries _getPopGetPopularTVSeries;

  TVSeriesPopularBloc(this._getPopGetPopularTVSeries)
      : super(TVSeriesPopularEmpty()) {
    on<FetchTVSeriesPopular>(
      (event, emit) async {
        emit(TVSeriesPopularLoading());

        final popularResult = await _getPopGetPopularTVSeries.execute();

        popularResult.fold(
            (failure) => emit(TVSeriesPopularError(failure.message)),
            (data) => emit(TVSeriesPopularHasData(data)));
      },
    );
  }
}
