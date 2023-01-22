import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:media_plex/media_plex/books/domain/entities/book_popular.dart';
import 'package:media_plex/media_plex/books/domain/use_cases/get_popular_book.dart';
import 'package:media_plex/media_plex/books/presentation/bloc/book_detail_bloc/book_detail_bloc.dart';

part 'popular_event.dart';
part 'popular_state.dart';

class PopularBloc extends Bloc<PopularEvent, PopularState> {
  final GetPopularBook getPopularBook;

  PopularBloc(this.getPopularBook) : super(PopularEmpty()) {
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
