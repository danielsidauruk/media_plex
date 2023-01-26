part of 'bookmark_bloc.dart';

abstract class BookmarkState extends Equatable {
  const BookmarkState();

  @override
  List<Object?> get props => [];
}

class BookmarkEmpty extends BookmarkState {}

class BookmarkLoading extends BookmarkState {}

class BookmarkError extends BookmarkState {
  const BookmarkError(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}

class BookmarkHasData extends BookmarkState {
  final List<BookTable> result;
  const BookmarkHasData(this.result);

  @override
  List<Object> get props => [result];
}

class BookmarkFailure extends BookmarkState {
  const BookmarkFailure(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}

class BookmarkSuccess extends BookmarkState {
  const BookmarkSuccess(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}

class BookMarkStatusHasData extends BookmarkState {
  const BookMarkStatusHasData(this.isAdded);
  final bool isAdded;

  @override
  List<Object> get props => [isAdded];
}

