part of 'book_subject_bloc.dart';

abstract class BookBySubjectState extends Equatable {
  const BookBySubjectState();

  @override
  List<Object?> get props => [];
}

class BookBySubjectEmpty extends BookBySubjectState {}

class BookBySubjectLoading extends BookBySubjectState {}

class BookBySubjectLoaded extends BookBySubjectState {
  const BookBySubjectLoaded ({required this.subject});
  final BooksBySubject subject;

  @override
  List<Object?> get props => [subject];
}

class BookBySubjectError extends BookBySubjectState {
  const BookBySubjectError ({required this.message});
  final String message;

  @override
  List<Object?> get props => [message];
}