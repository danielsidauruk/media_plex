import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:media_plex/core/utils/constants.dart';
import 'package:rxdart/rxdart.dart';
import 'package:media_plex/media_plex/books/domain/entities/search_the_book.dart';
import 'package:media_plex/media_plex/books/domain/use_cases/search_book.dart';

part 'book_search_event.dart';
part 'book_search_state.dart';

class SearchTheBookBloc extends Bloc<SearchTheBookEvent, SearchTheBookState> {
  final SearchBook searchBook;

  SearchTheBookBloc(this.searchBook) : super(SearchTheBookEmpty()) {
    on<FetchSearchTheBook>((event, emit) async {
      final query = event.query;

      emit(SearchTheBookLoading());
      final failureOrBook = await searchBook(Params(query: query));

      failureOrBook.fold(
          (failure) => emit(const SearchTheBookError(message: serverFailureMessage)),
          (bookResult) => emit(SearchTheBookLoaded(result: bookResult)));
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
