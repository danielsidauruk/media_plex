part of 'book_search_bloc.dart';

abstract class BookSearchState extends Equatable {
  const BookSearchState();

  @override
  List<Object> get props => [];
}

class BookSearchEmpty extends BookSearchState {}

class BookSearchLoading extends BookSearchState {}

class BookSearchLoaded extends BookSearchState {
  const BookSearchLoaded({required this.result});
  final Search result;

  @override
  List<Object> get props => [result];
}

class BookSearchError extends BookSearchState {
  const BookSearchError ({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}