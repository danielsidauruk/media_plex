part of 'search_the_movie_bloc.dart';

abstract class SearchTheMovieEvent extends Equatable {
  const SearchTheMovieEvent();

  @override
  List<Object> get props => [];
}

class OnQueryChanged extends SearchTheMovieEvent {
  final String query;

  const OnQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
