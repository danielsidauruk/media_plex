import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:media_plex/core/utils/constants.dart';
import 'package:media_plex/media_plex/books/domain/entities/book_detail.dart';
import 'package:media_plex/media_plex/books/domain/use_cases/get_book_details.dart';

part 'book_detail_event.dart';
part 'book_detail_state.dart';


class BookDetailBloc extends Bloc<BookDetailEvent, BookDetailState> {
  final GetBookDetails getBookDetails;

  BookDetailBloc(this.getBookDetails) : super(BookDetailEmpty()) {
    on<GetForBookDetail>((event, emit) async {
      final bookKey = event.key;

      emit(BookDetailLoading());
      final failureOrBookDetail = await getBookDetails(Params(key: bookKey));

      failureOrBookDetail.fold(
          (failure) => emit(const BookDetailError(message: serverFailureMessage)),
          (bookDetail) => emit(BookDetailLoaded(bookDetail: bookDetail)));
    });
  }
}
