import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:media_plex/core/utils/failure.dart';
import 'package:media_plex/media_plex/books/domain/entities/books_by_subject.dart';
import 'package:media_plex/media_plex/books/domain/repositories/books_repository.dart';
import 'package:media_plex/shared/domain/use_cases/use_case.dart';

class GetBookBySubject extends UseCase<BooksBySubject, Params> {
  GetBookBySubject({required this.repository});
  BookRepository repository;

  @override
  Future<Either<Failure, BooksBySubject>> call(Params params) async {
    return await repository.getBookBySubject(params.subjectName);
  }

}

class Params extends Equatable {
  const Params({required this.subjectName});
  final String subjectName;

  @override
  List<Object?> get props => [subjectName];
}