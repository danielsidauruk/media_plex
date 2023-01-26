import 'package:dartz/dartz.dart';
import 'package:media_plex/core/utils/exception.dart';
import 'package:media_plex/core/utils/failure.dart';
import 'package:media_plex/media_plex/tv_series/data/datasources/tv_series_local_data_source.dart';
import 'package:media_plex/media_plex/tv_series/data/datasources/tv_series_remote_data_source.dart';
import 'package:media_plex/media_plex/tv_series/data/models/tv_series_table.dart';
import 'package:media_plex/media_plex/tv_series/domain/entities/tv_series.dart';
import 'package:media_plex/media_plex/tv_series/domain/entities/tv_series_detail.dart';
import 'package:media_plex/media_plex/tv_series/domain/repositories/tv_series_repository.dart';
import 'dart:io';

class TVSeriesRepositoryImpl implements TVSeriesRepository {
  final TVSeriesRemoteDataSource tvSeriesRemoteDataSource;
  final TVSeriesLocalDataSource tvSeriesLocalDataSource;

  TVSeriesRepositoryImpl({
    required this.tvSeriesRemoteDataSource,
    required this.tvSeriesLocalDataSource,
  });

  @override
  Future<Either<Failure, List<TVSeries>>> getOnAirTVSeries() async {
    try {
      final result = await tvSeriesRemoteDataSource.getOnAirTVSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(SSLFailure('CERTIFICATE_VERIFY_FAILED\n${e.message}'));
    } catch (e) {
      return Left(SSLFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TVSeriesDetail>> getTVSeriesDetail(int id) async {
    try {
      final result = await tvSeriesRemoteDataSource.getTVSeriesDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(SSLFailure('CERTIFICATE_VERIFY_FAILED\n${e.message}'));
    } catch (e) {
      return Left(SSLFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TVSeries>>> getTVSeriesRecommendations(
      int id) async {
    try {
      final result =
          await tvSeriesRemoteDataSource.getTVSeriesRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(SSLFailure('CERTIFICATE_VERIFY_FAILED\n${e.message}'));
    } catch (e) {
      return Left(SSLFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TVSeries>>> getPopularTVSeries() async {
    try {
      final result = await tvSeriesRemoteDataSource.getPopularTVSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(SSLFailure('CERTIFICATE_VERIFY_FAILED\n${e.message}'));
    } catch (e) {
      return Left(SSLFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TVSeries>>> getTopRatedTVSeries() async {
    try {
      final result = await tvSeriesRemoteDataSource.getTopRatedTVSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(SSLFailure('CERTIFICATE_VERIFY_FAILED\n${e.message}'));
    } catch (e) {
      return Left(SSLFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TVSeries>>> searchTVSeries(String query) async {
    try {
      final result = await tvSeriesRemoteDataSource.searchTVSeries(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(SSLFailure('CERTIFICATE_VERIFY_FAILED\n${e.message}'));
    } catch (e) {
      return Left(SSLFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlist(TVSeriesDetail tvSeries) async {
    try {
      final result = await tvSeriesLocalDataSource
          .insertWatchlist(TVSeriesTable.fromEntity(tvSeries));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(
      TVSeriesDetail tvSeries) async {
    try {
      final result = await tvSeriesLocalDataSource
          .removeWatchlist(TVSeriesTable.fromEntity(tvSeries));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    final result = await tvSeriesLocalDataSource.getTVSeriesById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, List<TVSeries>>> getWatchlistTVSeries() async {
    final result = await tvSeriesLocalDataSource.getWatchlistTVSeries();
    return Right(result.map((data) => data.toEntity()).toList());
  }
}
