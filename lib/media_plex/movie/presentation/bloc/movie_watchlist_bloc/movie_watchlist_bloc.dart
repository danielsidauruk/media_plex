import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_plex/media_plex/movie/domain/entities/movie.dart';
import 'package:media_plex/media_plex/movie/domain/entities/movie_detail.dart';
import 'package:media_plex/media_plex/movie/domain/usecases/get_watchlist_movies.dart';
import 'package:media_plex/media_plex/movie/domain/usecases/get_watchlist_status.dart';
import 'package:media_plex/media_plex/movie/domain/usecases/remove_watchlist.dart';
import 'package:media_plex/media_plex/movie/domain/usecases/save_watchlist.dart';

part 'movie_watchlist_event.dart';
part 'movie_watchlist_state.dart';

class MovieWatchlistBloc
    extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  final GetWatchlistMovies _getMovieWatchlist;
  final GetWatchListStatus _getWatchListMovieStatus;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;

  MovieWatchlistBloc(this._getMovieWatchlist, this._getWatchListMovieStatus,
      this._saveWatchlist, this._removeWatchlist)
      : super(MovieWatchlistEmpty()) {
    on<FetchMovieWatchlist>(
      (event, emit) async {
        emit(MovieWatchlistLoading());
        final watchlistResult = await _getMovieWatchlist.execute();

        watchlistResult.fold(
            (failure) => emit(MovieWatchlistError(failure.message)),
            (data) => emit(MovieWatchlistHasData(data)));
      },
    );

    on<LoadWatchlistStatus>(((event, emit) async {
      final id = event.id;
      final result = await _getWatchListMovieStatus.execute(id);

      emit(WatchlistHasData(result));
    }));

    on<AddMovieWatchlist>((event, emit) async {
      final movie = event.movie;

      final result = await _saveWatchlist.execute(movie);

      result.fold(
        (failure) => emit(WatchlistFailure(failure.message)),
        (successMessage) => emit(const WatchlistSuccess('Added to Watchlist')),
      );

      add(LoadWatchlistStatus(movie.id));
    });

    on<DeleteMovieWatchlist>((event, emit) async {
      final movie = event.movie;

      final result = await _removeWatchlist.execute(movie);
      result.fold(
        (failure) => emit(WatchlistFailure(failure.message)),
        (successMessage) =>
            emit(const WatchlistSuccess('Removed from Watchlist')),
      );
      add(LoadWatchlistStatus(movie.id));
    });
  }
}
