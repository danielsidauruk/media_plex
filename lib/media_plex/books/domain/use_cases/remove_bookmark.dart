import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:media_plex/core/utils/failure.dart';
import 'package:media_plex/media_plex/books/domain/entities/book_detail.dart';
import 'package:media_plex/media_plex/books/domain/repositories/books_repository.dart';
import 'package:media_plex/shared/domain/use_cases/use_case.dart';

class RemoveBookmark extends UseCase<String, RemoveParams>{
  final BookRepository repository;
  RemoveBookmark(this.repository);

  @override
  Future<Either<Failure, String>> call(RemoveParams params) {
    return repository.removeFromBookmark(params.bookDetail);
  }
}

class RemoveParams extends Equatable {
  final BookDetail bookDetail;
  const RemoveParams({required this.bookDetail});

  @override
  List<Object?> get props => [bookDetail];
}