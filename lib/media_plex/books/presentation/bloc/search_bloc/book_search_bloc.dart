import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:media_plex/core/utils/constants.dart';
import 'package:rxdart/rxdart.dart';
import 'package:media_plex/media_plex/books/domain/entities/search.dart';
import 'package:media_plex/media_plex/books/domain/use_cases/search_book.dart';

part 'book_search_event.dart';
part 'book_search_state.dart';

class BookSearchBloc extends Bloc<BookSearchEvent, BookSearchState> {
  final SearchBook searchBook;

  BookSearchBloc(this.searchBook) : super(BookSearchEmpty()) {
    on<SearchForBook>((event, emit) async {
      final query = event.query;

      emit(BookSearchLoading());
      final failureOrBook = await searchBook(Params(query: query));

      failureOrBook.fold(
          (failure) => emit(const BookSearchError(message: serverFailureMessage)),
          (bookResult) => emit(BookSearchLoaded(result: bookResult)));
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
