part of 'book_detail_bloc.dart';

abstract class BookDetailState extends Equatable {
  const BookDetailState();

  @override
  List<Object?> get props => [];
}

class BookDetailEmpty extends BookDetailState {}

class BookDetailLoading extends BookDetailState {}

class BookDetailLoaded extends BookDetailState {
  const BookDetailLoaded({required this.bookDetail});
  final BookDetail bookDetail;

  @override
  List<Object?> get props => [bookDetail];
}

class BookDetailError extends BookDetailState {
  const BookDetailError ({required this.message});
  final String message;

  @override
  List<Object?> get props => [message];
}