part of 'book_detail_bloc.dart';

abstract class BookDetailEvent extends Equatable {
  const BookDetailEvent();

  @override
  List<Object?> get props => [];
}

class GetForBookDetail extends BookDetailEvent {
  const GetForBookDetail(this.key);
  final String key;

  @override
  List<Object?> get props => [key];
}