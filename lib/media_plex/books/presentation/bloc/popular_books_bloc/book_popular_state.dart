part of 'book_popular_bloc.dart';

abstract class PopularBooksState extends Equatable {
  const PopularBooksState();

  @override
  List<Object?> get props => [];
}

class PopularBooksEmpty extends PopularBooksState {}

class PopularBooksLoading extends PopularBooksState {}

class PopularBooksLoaded extends PopularBooksState {
  const PopularBooksLoaded ({required this.popular});
  final PopularBooks popular;

  @override
  List<Object?> get props => [popular];
}

class PopularBooksError extends PopularBooksState {
  const PopularBooksError ({required this.message});
  final String message;

  @override
  List<Object?> get props => [message];
}