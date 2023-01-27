import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_plex/core/utils/constants.dart';
import 'package:media_plex/media_plex/books/domain/entities/book_subject.dart';
import 'package:media_plex/media_plex/books/domain/use_cases/get_subject_book.dart';

part 'book_subject_event.dart';
part 'book_subject_state.dart';

class BookSubjectBloc extends Bloc<BookSubjectEvent, BookSubjectState> {
  final GetSubjectBook getSubjectBook;

  BookSubjectBloc(this.getSubjectBook) : super(SubjectEmpty()) {
    on<GetForBookSubject>((event, emit) async {
      final subjectName = event.subjectName;
      emit(SubjectLoading());

      final failureOrSubject = await getSubjectBook(Params(subjectName: subjectName));
      failureOrSubject.fold(
            (failure) => emit(const SubjectError(message: serverFailureMessage)),
              (subject) => emit(SubjectLoaded(subject: subject)));
    });
  }
}
