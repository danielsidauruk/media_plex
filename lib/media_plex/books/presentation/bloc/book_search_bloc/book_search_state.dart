part of 'book_search_bloc.dart';

abstract class SearchTheBookState extends Equatable {
  const SearchTheBookState();

  @override
  List<Object> get props => [];
}

class SearchTheBookEmpty extends SearchTheBookState {}

class SearchTheBookLoading extends SearchTheBookState {}

class SearchTheBookLoaded extends SearchTheBookState {
  const SearchTheBookLoaded({required this.result});
  final SearchTheBook result;

  @override
  List<Object> get props => [result];
}

class SearchTheBookError extends SearchTheBookState {
  const SearchTheBookError ({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}