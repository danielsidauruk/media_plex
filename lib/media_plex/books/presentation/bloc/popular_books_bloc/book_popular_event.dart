part of 'book_popular_bloc.dart';

abstract class PopularBooksEvent extends Equatable {
  const PopularBooksEvent();

  @override
  List<Object?> get props => [];
}

class FetchPopularBooks extends PopularBooksEvent {
  const FetchPopularBooks(this.dataSortQuery);
  final String dataSortQuery;

  @override
  List<Object?> get props => [dataSortQuery];
}
