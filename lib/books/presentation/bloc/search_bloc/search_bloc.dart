import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:media_plex/books/domain/entities/search.dart';
import 'package:media_plex/books/domain/use_cases/search_book.dart';
import 'package:media_plex/books/presentation/bloc/book_detail_bloc/book_detail_bloc.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchBook searchBook;

  SearchBloc(this.searchBook) : super(SearchEmpty()) {
    on<SearchForBook>((event, emit) async {
      final query = event.query;

      emit(SearchLoading());
      final failureOrBook = await searchBook(Params(query: query));

      failureOrBook.fold(
          (failure) => emit(const SearchError(message: serverFailureMessage)),
          (bookResult) => emit(SearchLoaded(result: bookResult)));
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
