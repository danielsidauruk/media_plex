part of 'movie_popular_bloc.dart';

abstract class PopularMoviesEvent extends Equatable {
  const PopularMoviesEvent();

  @override
  List<Object> get props => [];
}

class FetchPopularMovies extends PopularMoviesEvent {}
