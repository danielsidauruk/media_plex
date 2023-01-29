import 'package:dartz/dartz.dart';
import 'package:media_plex/core/utils/exception.dart';
import 'package:media_plex/core/utils/failure.dart';
import 'package:media_plex/media_plex/books/data/data_sources/book_local_data_sources.dart';
import 'package:media_plex/media_plex/books/data/data_sources/book_remote_data_sources.dart';
import 'package:media_plex/media_plex/books/data/models/book_table.dart';
import 'package:media_plex/media_plex/books/domain/entities/popular_books.dart';
import 'package:media_plex/media_plex/books/domain/entities/book_detail.dart';
import 'package:media_plex/media_plex/books/domain/entities/search_the_book.dart';
import 'package:media_plex/media_plex/books/domain/entities/books_by_subject.dart';
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
  Future<Either<Failure, SearchTheBook>> searchTheBook(String query) async {
    try {
      return Right(await remoteDataSource.searchTheBook(query));
    } on ServerException {
      return const Left(ServerFailure(""));
    }
  }

  @override
  Future<Either<Failure, PopularBooks>> getPopularBooks(String dataSortQuery) async {
    try {
      return Right(await remoteDataSource.getPopularBooks(dataSortQuery));
    } on ServerException {
      return const Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, BooksBySubject>> getBookBySubject(String subjectName) async {
    try {
      return Right(await remoteDataSource.getBookBySubject(subjectName));
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
      final result = await localDataSource.removeBookmark(BookTableModel.fromEntity(book));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> saveBookmark(BookDetail book) async {
    try {
      final result = await localDataSource.insertBookmark(BookTableModel.fromEntity(book));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch(e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, List<BookTableModel>>> getBookmark() async {
    final result = await localDataSource.getBookmark();
    return Right(result);
  }
}
