import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:media_plex/core/utils/exception.dart';
import 'package:media_plex/core/utils/failure.dart';
import 'package:media_plex/media_plex/movie/data/models/movie_detail_model.dart';
import 'package:media_plex/media_plex/movie/data/models/movie_model.dart';
import 'package:media_plex/media_plex/movie/data/repositories/movie_repository_impl.dart';
import 'package:media_plex/media_plex/movie/domain/entities/movie.dart';
import 'package:media_plex/shared/data/models/genre_model.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_object.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MovieRepositoryImpl repository;
  late MockMovieRemoteDataSource mockMovieRemoteDataSource;
  late MockMovieLocalDataSource mockMovieLocalDataSource;

  setUp(() {
    mockMovieLocalDataSource = MockMovieLocalDataSource();
    mockMovieRemoteDataSource = MockMovieRemoteDataSource();
    repository = MovieRepositoryImpl(
      remoteDataSource: mockMovieRemoteDataSource,
      localDataSource: mockMovieLocalDataSource,
    );
  });

  const tMovieModel = MovieModel(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
    'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tMovie = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
    'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tMovieModelList = <MovieModel>[tMovieModel];
  final tMovieList = <Movie>[tMovie];

  group('Now Playing Movies', () {
    test(
        'should return remote data when the call to remote data source is successful',
            () async {
          // arrange
          when(mockMovieRemoteDataSource.getNowPlayingMovies())
              .thenAnswer((_) async => tMovieModelList);
          // act
          final result = await repository.getNowPlayingMovies();
          // assert
          verify(mockMovieRemoteDataSource.getNowPlayingMovies());
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tMovieList);
        });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockMovieRemoteDataSource.getNowPlayingMovies())
              .thenThrow(ServerException());
          // act
          final result = await repository.getNowPlayingMovies();
          // assert
          verify(mockMovieRemoteDataSource.getNowPlayingMovies());
          expect(result, equals(const Left(ServerFailure(''))));
        });

    test(
        'should return connection failure when the device is not connected to internet',
            () async {
          // arrange
          when(mockMovieRemoteDataSource.getNowPlayingMovies())
              .thenThrow(const SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getNowPlayingMovies();
          // assert
          verify(mockMovieRemoteDataSource.getNowPlayingMovies());
          expect(
              result,
              equals(const Left(
                  ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Popular Movies', () {
    test('should return movie list when call to data source is success',
            () async {
          // arrange
          when(mockMovieRemoteDataSource.getPopularMovies())
              .thenAnswer((_) async => tMovieModelList);
          // act
          final result = await repository.getPopularMovies();
          // assert
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tMovieList);
        });

    test(
        'should return server failure when call to data source is unsuccessful',
            () async {
          // arrange
          when(mockMovieRemoteDataSource.getPopularMovies())
              .thenThrow(ServerException());
          // act
          final result = await repository.getPopularMovies();
          // assert
          expect(result, const Left(ServerFailure('')));
        });

    test(
        'should return connection failure when device is not connected to the internet',
            () async {
          // arrange
          when(mockMovieRemoteDataSource.getPopularMovies())
              .thenThrow(const SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getPopularMovies();
          // assert
          expect(result,
              const Left(ConnectionFailure('Failed to connect to the network')));
        });
  });

  group('Top Rated Movies', () {
    test('should return movie list when call to data source is successful',
            () async {
          // arrange
          when(mockMovieRemoteDataSource.getTopRatedMovies())
              .thenAnswer((_) async => tMovieModelList);
          // act
          final result = await repository.getTopRatedMovies();
          // assert
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tMovieList);
        });

    test('should return ServerFailure when call to data source is unsuccessful',
            () async {
          // arrange
          when(mockMovieRemoteDataSource.getTopRatedMovies())
              .thenThrow(ServerException());
          // act
          final result = await repository.getTopRatedMovies();
          // assert
          expect(result, const Left(ServerFailure('')));
        });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
            () async {
          // arrange
          when(mockMovieRemoteDataSource.getTopRatedMovies())
              .thenThrow(const SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getTopRatedMovies();
          // assert
          expect(result,
              const Left(ConnectionFailure('Failed to connect to the network')));
        });
  });

  group('Get Movie Detail', () {
    const tId = 1;
    const tMovieResponse = MovieDetailResponse(
      adult: false,
      backdropPath: 'backdropPath',
      budget: 100,
      genres: [GenreModel(id: 1, name: 'Action')],
      homepage: "https://google.com",
      id: 1,
      imdbId: 'imdb1',
      originalLanguage: 'en',
      originalTitle: 'originalTitle',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      revenue: 12000,
      runtime: 120,
      status: 'Status',
      tagline: 'Tagline',
      title: 'title',
      video: false,
      voteAverage: 1,
      voteCount: 1,
    );

    test(
        'should return Movie data when the call to remote data source is successful',
            () async {
          // arrange
          when(mockMovieRemoteDataSource.getMovieDetail(tId))
              .thenAnswer((_) async => tMovieResponse);
          // act
          final result = await repository.getMovieDetail(tId);
          // assert
          verify(mockMovieRemoteDataSource.getMovieDetail(tId));
          expect(result, equals(const Right(testMovieDetail)));
        });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockMovieRemoteDataSource.getMovieDetail(tId))
              .thenThrow(ServerException());
          // act
          final result = await repository.getMovieDetail(tId);
          // assert
          verify(mockMovieRemoteDataSource.getMovieDetail(tId));
          expect(result, equals(const Left(ServerFailure(''))));
        });

    test(
        'should return connection failure when the device is not connected to internet',
            () async {
          // arrange
          when(mockMovieRemoteDataSource.getMovieDetail(tId))
              .thenThrow(const SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getMovieDetail(tId);
          // assert
          verify(mockMovieRemoteDataSource.getMovieDetail(tId));
          expect(
              result,
              equals(const Left(
                  ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Get Movie Recommendations', () {
    final tMovieList = <MovieModel>[];
    const tId = 1;

    test('should return data (movie list) when the call is successful',
            () async {
          // arrange
          when(mockMovieRemoteDataSource.getMovieRecommendations(tId))
              .thenAnswer((_) async => tMovieList);
          // act
          final result = await repository.getMovieRecommendations(tId);
          // assert
          verify(mockMovieRemoteDataSource.getMovieRecommendations(tId));
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, equals(tMovieList));
        });

    test(
        'should return server failure when call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockMovieRemoteDataSource.getMovieRecommendations(tId))
              .thenThrow(ServerException());
          // act
          final result = await repository.getMovieRecommendations(tId);
          // assert build runner
          verify(mockMovieRemoteDataSource.getMovieRecommendations(tId));
          expect(result, equals(const Left(ServerFailure(''))));
        });

    test(
        'should return connection failure when the device is not connected to the internet',
            () async {
          // arrange
          when(mockMovieRemoteDataSource.getMovieRecommendations(tId))
              .thenThrow(const SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getMovieRecommendations(tId);
          // assert
          verify(mockMovieRemoteDataSource.getMovieRecommendations(tId));
          expect(
              result,
              equals(const Left(
                  ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Seach Movies', () {
    const tQuery = 'spiderman';

    test('should return movie list when call to data source is successful',
            () async {
          // arrange
          when(mockMovieRemoteDataSource.searchMovies(tQuery))
              .thenAnswer((_) async => tMovieModelList);
          // act
          final result = await repository.searchTheMovie(tQuery);
          // assert
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tMovieList);
        });

    test('should return ServerFailure when call to data source is unsuccessful',
            () async {
          // arrange
          when(mockMovieRemoteDataSource.searchMovies(tQuery))
              .thenThrow(ServerException());
          // act
          final result = await repository.searchTheMovie(tQuery);
          // assert
          expect(result, const Left(ServerFailure('')));
        });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
            () async {
          // arrange
          when(mockMovieRemoteDataSource.searchMovies(tQuery))
              .thenThrow(const SocketException('Failed to connect to the network'));
          // act
          final result = await repository.searchTheMovie(tQuery);
          // assert
          expect(result,
              const Left(ConnectionFailure('Failed to connect to the network')));
        });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockMovieLocalDataSource.insertWatchlist(testMovieTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveToWatchlist(testMovieDetail);
      // assert
      expect(result, const Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockMovieLocalDataSource.insertWatchlist(testMovieTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveToWatchlist(testMovieDetail);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockMovieLocalDataSource.removeWatchlist(testMovieTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeFromWatchlist(testMovieDetail);
      // assert
      expect(result, const Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockMovieLocalDataSource.removeWatchlist(testMovieTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeFromWatchlist(testMovieDetail);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      const tId = 1;
      when(mockMovieLocalDataSource.getMovieById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist movies', () {
    test('should return list of Movies', () async {
      // arrange
      when(mockMovieLocalDataSource.getWatchlistMovies())
          .thenAnswer((_) async => [testMovieTable]);
      // act
      final result = await repository.getWatchlistMovies();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistMovie]);
    });
  });
}