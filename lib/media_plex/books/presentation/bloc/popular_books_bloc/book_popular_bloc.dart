import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:media_plex/core/utils/constants.dart';
import 'package:media_plex/media_plex/books/domain/entities/popular_books.dart';
import 'package:media_plex/media_plex/books/domain/use_cases/get_book_popular.dart';

part 'book_popular_event.dart';
part 'book_popular_state.dart';

class PopularBooksBloc extends Bloc<PopularBooksEvent, PopularBooksState> {
  final GetPopularBooks getPopularBook;

  PopularBooksBloc(this.getPopularBook) : super(PopularBooksEmpty()) {
    on<FetchPopularBooks>((event, emit) async {
      final dataSortQuery = event.dataSortQuery;

      emit(PopularBooksLoading());
      final failureOrPopular = await getPopularBook(Params(dataSortQuery: dataSortQuery));

      failureOrPopular.fold(
            (failure) => emit(const PopularBooksError(message: serverFailureMessage)),
            (popular) => emit(PopularBooksLoaded(popular: popular)));
    });
  }

}
