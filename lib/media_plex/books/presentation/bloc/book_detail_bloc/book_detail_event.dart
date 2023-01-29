part of 'book_detail_bloc.dart';

abstract class BookDetailEvent extends Equatable {
  const BookDetailEvent();

  @override
  List<Object?> get props => [];
}

class FetchBookDetail extends BookDetailEvent {
  const FetchBookDetail(this.key);
  final String key;

  @override
  List<Object?> get props => [key];
}