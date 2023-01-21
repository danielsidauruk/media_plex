part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistEvent extends Equatable {
  const MovieWatchlistEvent();

  @override
  List<Object> get props => [];
}

class FetchMovieWatchlist extends MovieWatchlistEvent {}

class AddMovieWatchlist extends MovieWatchlistEvent {
  final MovieDetail movie;

  const AddMovieWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}

class DeleteMovieWatchlist extends MovieWatchlistEvent {
  final MovieDetail movie;

  const DeleteMovieWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}

class LoadWatchlistStatus extends MovieWatchlistEvent {
  final int id;

  const LoadWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}
