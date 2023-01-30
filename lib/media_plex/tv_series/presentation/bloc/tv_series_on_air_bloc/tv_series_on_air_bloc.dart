import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_plex/media_plex/tv_series/domain/entities/tv_series.dart';
import 'package:media_plex/media_plex/tv_series/domain/usecases/get_on_air_tv_series.dart';
import 'package:media_plex/shared/domain/use_cases/use_case.dart';

part 'tv_series_on_air_event.dart';
part 'tv_series_on_air_state.dart';

class TVSeriesOnAirBloc extends Bloc<TVSeriesOnAirEvent, TVSeriesOnAirState> {
  final GetOnAirTVSeries _getOnAirTVSeries;

  TVSeriesOnAirBloc(this._getOnAirTVSeries) : super(TVSeriesOnAirEmpty()) {
    on<FetchTVSeriesOnAir>(
      (event, emit) async {
        emit(TVSeriesOnAirLoading());

        final onAirResult = await _getOnAirTVSeries.call(NoParams());

        onAirResult.fold((failure) => emit(TVSeriesOnAirError(failure.message)),
            (data) => emit(TVSeriesOnAirHasData(data)));
      },
    );
  }
}
