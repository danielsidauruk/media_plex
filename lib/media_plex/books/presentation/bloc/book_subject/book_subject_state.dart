part of 'book_subject_bloc.dart';

abstract class BookSubjectState extends Equatable {
  const BookSubjectState();

  @override
  List<Object?> get props => [];
}

class SubjectEmpty extends BookSubjectState {}

class SubjectLoading extends BookSubjectState {}

class SubjectLoaded extends BookSubjectState {
  const SubjectLoaded ({required this.subject});
  final BookSubject subject;

  @override
  List<Object?> get props => [subject];
}

class SubjectError extends BookSubjectState {
  const SubjectError ({required this.message});
  final String message;

  @override
  List<Object?> get props => [message];
}