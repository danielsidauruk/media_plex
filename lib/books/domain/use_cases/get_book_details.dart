import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:media_plex/core/failure.dart';
import 'package:media_plex/core/use_case.dart';
import 'package:media_plex/books/domain/entities/books_details.dart';
import 'package:media_plex/books/domain/repositories/books_repository.dart';

class GetBookDetails extends UseCase<BookDetail, Params> {
  LibraryBookRepository repository;

  GetBookDetails({required this.repository});

  @override
  Future<Either<Failure, BookDetail>> call(Params params) async {
    return await repository.getBookDetail(params.key);
  }
}

class Params extends Equatable {
  const Params({required this.key});
  final String key;

  @override
  List<Object?> get props => [key];
}
