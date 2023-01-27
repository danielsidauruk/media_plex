import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:media_plex/core/utils/failure.dart';
import 'package:media_plex/media_plex/books/domain/entities/book_subject.dart';
import 'package:media_plex/media_plex/books/domain/repositories/books_repository.dart';
import 'package:media_plex/shared/domain/use_cases/use_case.dart';

class GetSubjectBook extends UseCase<BookSubject, Params> {
  GetSubjectBook({required this.repository});
  BookRepository repository;

  @override
  Future<Either<Failure, BookSubject>> call(Params params) async {
    return await repository.getSubjectBooks(params.subjectName);
  }

}

class Params extends Equatable {
  const Params({required this.subjectName});
  final String subjectName;

  @override
  List<Object?> get props => [subjectName];
}