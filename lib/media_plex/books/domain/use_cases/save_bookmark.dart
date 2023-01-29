import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:media_plex/core/utils/failure.dart';
import 'package:media_plex/media_plex/books/domain/entities/book_detail.dart';
import 'package:media_plex/media_plex/books/domain/repositories/books_repository.dart';
import 'package:media_plex/shared/domain/use_cases/use_case.dart';

class SaveBookmark extends UseCase<String, SaveParams>{
  SaveBookmark(this.repository);
  final BookRepository repository;

  @override
  Future<Either<Failure, String>> call(SaveParams params) {
    return repository.removeFromBookmark(params.bookDetail);
  }
}

class SaveParams extends Equatable {
  final BookDetail bookDetail;
  const SaveParams({required this.bookDetail});

  @override
  List<Object?> get props => [bookDetail];
}