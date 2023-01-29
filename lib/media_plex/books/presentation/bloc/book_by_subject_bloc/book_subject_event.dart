part of 'book_subject_bloc.dart';

abstract class BookBySubjectEvent extends Equatable {
  const BookBySubjectEvent();

  @override
  List<Object?> get props => [];
}

class FetchBookBySubject extends BookBySubjectEvent {
  const FetchBookBySubject(this.subjectName);
  final String subjectName;

  @override
  List<Object?> get props => [subjectName];
}
