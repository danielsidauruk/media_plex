import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:media_plex/core/utils/constants.dart';
import 'package:media_plex/media_plex/books/domain/entities/book_popular.dart';
import 'package:media_plex/media_plex/books/domain/use_cases/get_popular_book.dart';

part 'book_popular_event.dart';
part 'book_popular_state.dart';

class BookPopularBloc extends Bloc<PopularEvent, PopularState> {
  final GetPopularBook getPopularBook;

  BookPopularBloc(this.getPopularBook) : super(PopularEmpty()) {
    on<GetForPopular>((event, emit) async {
      final dataSortQuery = event.dataSortQuery;

      emit(PopularLoading());
      final failureOrPopular = await getPopularBook(Params(dataSortQuery: dataSortQuery));

      failureOrPopular.fold(
            (failure) => emit(const PopularError(message: serverFailureMessage)),
            (popular) => emit(PopularLoaded(popular: popular)));
    });
  }

}
