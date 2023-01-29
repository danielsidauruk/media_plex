part of 'search_the_movie_bloc.dart';

abstract class SearchTheMovieState extends Equatable {
  const SearchTheMovieState();

  @override
  List<Object> get props => [];
}

class SearchTheMovieEmpty extends SearchTheMovieState {}

class SearchTheMovieLoading extends SearchTheMovieState {}

class SearchTheMovieError extends SearchTheMovieState {
  final String message;
  const SearchTheMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchTheMovieHasData extends SearchTheMovieState {
  final List<Movie> result;
  const SearchTheMovieHasData(this.result);

  @override
  List<Object> get props => [result];
}
