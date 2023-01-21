import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_plex/media_plex/tv_series/domain/entities/tv_series_detail.dart';
import 'package:media_plex/media_plex/tv_series/domain/usecases/get_tv_series_detail.dart';

part 'tv_series_detail_event.dart';
part 'tv_series_detail_state.dart';

class TVSeriesDetailBloc
    extends Bloc<TVSeriesDetailEvent, TVSeriesDetailState> {
  final GetTVSeriesDetail _getTVSeriesDetail;

  TVSeriesDetailBloc(this._getTVSeriesDetail) : super(TVSeriesDetailEmpty()) {
    on<FetchTVSeriesDetail>(
      (event, emit) async {
        final id = event.id;

        emit(TVSeriesDetailLoading());
        final detailResult = await _getTVSeriesDetail.execute(id);

        detailResult.fold(
          (failure) => emit(TVSeriesDetailError(failure.message)),
          (data) => emit(TVSeriesDetailHasData(data)));
        },
    );
  }
}
