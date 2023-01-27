import 'package:dartz/dartz.dart';
import 'package:media_plex/core/utils/exception.dart';
import 'package:media_plex/core/utils/failure.dart';
import 'package:media_plex/media_plex/books/data/data_sources/book_local_data_sources.dart';
import 'package:media_plex/media_plex/books/data/data_sources/book_remote_data_sources.dart';
import 'package:media_plex/media_plex/books/data/models/book_table.dart';
import 'package:media_plex/media_plex/books/domain/entities/book_popular.dart';
import 'package:media_plex/media_plex/books/domain/entities/book_detail.dart';
import 'package:media_plex/media_plex/books/domain/entities/book_search.dart';
import 'package:media_plex/media_plex/books/domain/entities/book_subject.dart';
import 'package:media_plex/media_plex/books/domain/repositories/books_repository.dart';

class BookRepositoryImpl implements BookRepository {
  final BookRemoteDataSource remoteDataSource;
  final BookLocalDataSource localDataSource;

  BookRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });


  @override
  Future<Either<Failure, BookDetail>> getBookDetail(String key) async {
    try {
      return Right(await remoteDataSource.getBookDetail(key));
    } on ServerException {
      return const Left(ServerFailure(""));
    }
  }

  @override
  Future<Either<Failure, Search>> searchBooks(String query) async {
    try {
      return Right(await remoteDataSource.searchBook(query));
    } on ServerException {
      return const Left(ServerFailure(""));
    }
  }

  @override
  Future<Either<Failure, Popular>> getPopularBooks(String dataSortQuery) async {
    try {
      return Right(await remoteDataSource.getPopularBook(dataSortQuery));
    } on ServerException {
      return const Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, BookSubject>> getSubjectBooks(String subjectName) async {
    try {
      return Right(await remoteDataSource.getSubjectBook(subjectName));
    } on ServerException {
      return const Left(ServerFailure(''));
    }
  }

  @override
  Future<bool> isBookmarked(String key) async{
    final result = await localDataSource.getBookByKey(key);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeBookmark(BookDetail book) async {
    try {
      final result = await localDataSource.removeBookmark(BookTable.fromEntity(book));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> saveBookmark(BookDetail book) async {
    try {
      final result = await localDataSource.insertBookmark(BookTable.fromEntity(book));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch(e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, List<BookTable>>> getBookmarkedBook() async {
    final result = await localDataSource.getBookmarkedBook();
    return Right(result);
  }
}
