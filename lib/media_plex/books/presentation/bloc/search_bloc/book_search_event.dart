part of 'book_search_bloc.dart';

abstract class BookSearchEvent extends Equatable {
  const BookSearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchForBook extends BookSearchEvent {
  const SearchForBook(this.query);
  final String query;

  @override
  List<Object?> get props => [query];
}

EventTransformer<T> debounce<T> (Duration duration) {
  return (event, mapper) => event.debounceTime(duration).flatMap(mapper);
}
