import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_plex/core/utils/constants.dart';
import 'package:media_plex/media_plex/books/domain/entities/books_by_subject.dart';
import 'package:media_plex/media_plex/books/domain/use_cases/get_book_by_subject.dart';

part 'book_subject_event.dart';
part 'book_subject_state.dart';

class BookBySubjectBloc extends Bloc<BookBySubjectEvent, BookBySubjectState> {
  final GetBookBySubject getBookBySubject;

  BookBySubjectBloc(this.getBookBySubject) : super(BookBySubjectEmpty()) {
    on<FetchBookBySubject>((event, emit) async {
      final subjectName = event.subjectName;
      emit(BookBySubjectLoading());

      final failureOrSubject = await getBookBySubject(Params(subjectName: subjectName));
      failureOrSubject.fold(
            (failure) => emit(const BookBySubjectError(message: serverFailureMessage)),
              (subject) => emit(BookBySubjectLoaded(subject: subject)));
    });
  }
}
