part of 'bookmark_bloc.dart';

abstract class BookmarkEvent extends Equatable {
  const BookmarkEvent();

  @override
  List<Object?> get props => [];
}

class FetchBookmark extends BookmarkEvent {}

class AddBookmark extends BookmarkEvent {
  const AddBookmark(this.book);
  final BookDetail book;

  @override
  List<Object> get props => [book];
}

class DeleteBookmark extends BookmarkEvent {
  const DeleteBookmark(this.book);
  final BookDetail book;

  @override
  List<Object> get props => [book];
}

class LoadBookmarkStatus extends BookmarkEvent {
  const LoadBookmarkStatus(this.key);
  final String key;

  @override
  List<Object> get props => [key];
}