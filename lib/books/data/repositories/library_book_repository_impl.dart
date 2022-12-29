import 'package:dartz/dartz.dart';
import 'package:media_plex/core/exception.dart';
import 'package:media_plex/core/failure.dart';
import 'package:media_plex/books/data/data_sources/book_remote_data_sources.dart';
import 'package:media_plex/books/domain/entities/books_details.dart';
import 'package:media_plex/books/domain/entities/search.dart';
import 'package:media_plex/books/domain/repositories/books_repository.dart';

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
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Search>> searchBooks(String query) async {
    try {
      return Right(await remoteDataSource.searchBook(query));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
