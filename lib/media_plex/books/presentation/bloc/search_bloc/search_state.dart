part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchEmpty extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  const SearchLoaded({required this.result});
  final Search result;

  @override
  List<Object> get props => [result];
}

class SearchError extends SearchState {
  const SearchError ({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}