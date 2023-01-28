import 'package:flutter_test/flutter_test.dart';
import 'package:media_plex/core/utils/constants.dart';
import 'package:media_plex/core/utils/exception.dart';
import 'package:media_plex/media_plex/movie/data/datasources/movie_local_data_source.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_object.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MovieLocalDataSourceImpl dataSource;
  late MockMovieDatabaseHelper mockMovieDatabaseHelper;

  setUp(() {
    mockMovieDatabaseHelper = MockMovieDatabaseHelper();
    dataSource = MovieLocalDataSourceImpl(databaseHelper: mockMovieDatabaseHelper);
  });

  group('save movie to watchlist', () {
    test('should return success message when insert movie to database is success', () async {
      // arrange
      when(mockMovieDatabaseHelper.insertWatchlist(testMovieTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlist(testMovieTable);
      // assert
      expect(result, addMessage);
    });

    test('should throw DatabaseException when insert movie to database is failed', () async {
      // arrange
      when(mockMovieDatabaseHelper.insertWatchlist(testMovieTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlist(testMovieTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove the movie from database is success', () async {
      // arrange
      when(mockMovieDatabaseHelper.removeWatchlist(testMovieTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlist(testMovieTable);
      // assert
      expect(result, removeMessage);
    });

    test('should throw Database Exception when remove the movie from database is failed', () async {
      // arrange
      when(mockMovieDatabaseHelper.removeWatchlist(testMovieTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlist(testMovieTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Movie Detail By Id', () {
    const tId = 1;

    test('should return Movie Detail Table when data is found', () async {
      // arrange
      when(mockMovieDatabaseHelper.getMovieById(tId))
          .thenAnswer((_) async => testMovieMap);
      // act
      final result = await dataSource.getMovieById(tId);
      // assert
      expect(result, testMovieTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockMovieDatabaseHelper.getMovieById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await dataSource.getMovieById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist movies', () {
    test('should return list of MovieTable from database', () async {
      // arrange
      when(mockMovieDatabaseHelper.getWatchlistMovies())
          .thenAnswer((_) async => [testMovieMap]);
      // act
      final result = await dataSource.getWatchlistMovies();
      // assert
      expect(result, [testMovieTable]);
    });
  });
}














