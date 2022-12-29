part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchForBook extends SearchEvent {
  const SearchForBook(this.query);
  final String query;

  @override
  List<Object?> get props => [query];
}

EventTransformer<T> debounce<T> (Duration duration) {
  return (event, mapper) => event.debounceTime(duration).flatMap(mapper);
}
