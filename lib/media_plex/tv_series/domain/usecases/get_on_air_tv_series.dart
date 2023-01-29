import 'package:dartz/dartz.dart';
import 'package:media_plex/core/utils/failure.dart';
import 'package:media_plex/media_plex/tv_series/domain/entities/tv_series.dart';
import 'package:media_plex/media_plex/tv_series/domain/repositories/tv_series_repository.dart';
import 'package:media_plex/shared/domain/use_cases/use_case.dart';

class GetOnAirTVSeries extends UseCase<List<TVSeries>, NoParams>{
  final TVSeriesRepository repository;
  GetOnAirTVSeries(this.repository);

  @override
  Future<Either<Failure, List<TVSeries>>> call(NoParams params) {
    return repository.getOnAirTVSeries();
  }
}
