import 'package:dartz/dartz.dart';
import 'package:media_plex/core/utils/failure.dart';
import 'package:media_plex/media_plex/tv_series/domain/entities/tv_series_detail.dart';
import 'package:media_plex/media_plex/tv_series/domain/repositories/tv_series_repository.dart';

class SaveWatchlistTVSeries {
  final TVSeriesRepository repository;

  SaveWatchlistTVSeries(this.repository);

  Future<Either<Failure, String>> execute(TVSeriesDetail id) {
    return repository.saveToWatchlist(id);
  }
}
