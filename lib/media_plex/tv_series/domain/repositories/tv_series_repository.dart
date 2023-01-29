import 'package:dartz/dartz.dart';
import 'package:media_plex/core/utils/failure.dart';
import 'package:media_plex/media_plex/tv_series/domain/entities/tv_series.dart';
import 'package:media_plex/media_plex/tv_series/domain/entities/tv_series_detail.dart';

abstract class TVSeriesRepository {
  Future<Either<Failure, List<TVSeries>>> getOnAirTVSeries();
  Future<Either<Failure, List<TVSeries>>> getPopularTVSeries();
  Future<Either<Failure, List<TVSeries>>> getTopRatedTVSeries();
  Future<Either<Failure, TVSeriesDetail>> getTVSeriesDetail(int id);
  Future<Either<Failure, List<TVSeries>>> getTVSeriesRecommendations(int id);
  Future<Either<Failure, List<TVSeries>>> searchTheTVSeries(String query);
  Future<Either<Failure, String>> saveToWatchlist(TVSeriesDetail tvSeries);
  Future<Either<Failure, String>> removeFromWatchlist(TVSeriesDetail tvSeries);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<TVSeries>>> getWatchlistTVSeries();
}
