import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_plex/media_plex/books/data/models/book_table.dart';
import 'package:media_plex/media_plex/books/domain/entities/book_detail.dart';
import 'package:media_plex/media_plex/books/domain/use_cases/get_bookmark_status.dart';
import 'package:media_plex/media_plex/books/domain/use_cases/get_bookmarked_book.dart';
import 'package:media_plex/media_plex/books/domain/use_cases/remove_bookmark.dart';
import 'package:media_plex/media_plex/books/domain/use_cases/save_bookmark.dart';

part 'bookmark_event.dart';
part 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {

  final GetBookMarkedBook getBookMarkedBook;
  final GetBookmarkStatus getBookmarkStatus;
  final SaveBookmark saveBookmark;
  final RemoveBookmark removeBookmark;

  BookmarkBloc(this.getBookMarkedBook,
      this.getBookmarkStatus,
      this.saveBookmark,
      this.removeBookmark,) : super(BookmarkEmpty()) {
    on<FetchBookmark>((event, emit) async {
      emit(BookmarkLoading());

      final bookmarkResult = await getBookMarkedBook.execute();
      bookmarkResult.fold(
            (failure) => emit(BookmarkError(failure.message)),
            (book) => emit(BookmarkHasData(book)),
      );
    },
    );

    on<LoadBookmarkStatus>((event, emit) async {
      final key = event.key;
      final result = await getBookmarkStatus.execute(key);

      emit(BookmarkStatusHasData(result));
    });

    on<AddBookmark>((event, emit) async {
      final book = event.book;
      final result = await saveBookmark.execute(book);

      result.fold(
            (failure) => emit(BookmarkFailure(failure.message)),
            (successMessage) => emit(const BookmarkSuccess('Bookmarked')),
      );

      add(LoadBookmarkStatus(book.key));
    });

    on<DeleteBookmark>((event, emit) async {
      final book = event.book;
      final result = await removeBookmark.execute(book);

      result.fold(
            (failure) => emit(BookmarkFailure(failure.message)),
            (successMessage) =>
            emit(const BookmarkSuccess('Removed from Bookmark')),
      );

      add(LoadBookmarkStatus(book.key));
    });
  }
}