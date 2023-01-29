import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_plex/media_plex/movie/domain/entities/movie_detail.dart';
import 'package:media_plex/media_plex/movie/domain/usecases/get_movie_detail.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;

  MovieDetailBloc(this.getMovieDetail) : super(MovieDetailEmpty()) {
    on<FetchMovieDetail>((event, emit) async {
      final id = event.id;

      emit(MovieDetailLoading());
      final detailResult = await getMovieDetail.call(Params(id: id));

      detailResult.fold(
              (failure) => emit(MovieDetailError(failure.message)),
              (data) => emit(MovieDetailHasData(data)));
      },
    );
  }
}