part of 'book_search_bloc.dart';

abstract class SearchTheBookEvent extends Equatable {
  const SearchTheBookEvent();

  @override
  List<Object?> get props => [];
}

class FetchSearchTheBook extends SearchTheBookEvent {
  const FetchSearchTheBook(this.query);
  final String query;

  @override
  List<Object?> get props => [query];
}

EventTransformer<T> debounce<T> (Duration duration) {
  return (event, mapper) => event.debounceTime(duration).flatMap(mapper);
}
