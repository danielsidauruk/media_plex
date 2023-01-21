import 'package:dartz/dartz.dart';
import 'package:media_plex/media_plex/books/data/data_sources/book_remote_data_sources.dart';
import 'package:media_plex/media_plex/books/domain/entities/book_popular.dart';
import 'package:media_plex/media_plex/books/domain/entities/books_details.dart';
import 'package:media_plex/media_plex/books/domain/entities/search.dart';
import 'package:media_plex/media_plex/books/domain/repositories/books_repository.dart';

import '../../../../core/utils/exception.dart';
import '../../../../core/utils/failure.dart';

class LibraryBookRepositoryImpl implements LibraryBookRepository {
  final BookRemoteDataSource remoteDataSource;

  LibraryBookRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, BookDetail>> getBookDetail(String key) async {
    try {
      return Right(await remoteDataSource.getBookDetail(key));
    } on ServerException {
      return Left(ServerFailure(""));
    }
  }

  @override
  Future<Either<Failure, Search>> searchBooks(String query) async {
    try {
      return Right(await remoteDataSource.searchBook(query));
    } on ServerException {
      return Left(ServerFailure(""));
    }
  }

  @override
  Future<Either<Failure, Popular>> getPopularBooks() async {
    try {
      return Right(await remoteDataSource.getPopularBook());
    } on ServerException {
      return Left(ServerFailure(''));
    }
  }
}