part of 'book_subject_bloc.dart';

abstract class BookSubjectEvent extends Equatable {
  const BookSubjectEvent();

  @override
  List<Object?> get props => [];
}

class GetForBookSubject extends BookSubjectEvent {
  const GetForBookSubject(this.subjectName);
  final String subjectName;

  @override
  List<Object?> get props => [subjectName];
}
