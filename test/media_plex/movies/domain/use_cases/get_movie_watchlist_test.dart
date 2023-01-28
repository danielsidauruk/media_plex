import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:media_plex/media_plex/movie/domain/usecases/get_watchlist_movies.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_object.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistMovies useCase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    useCase = GetWatchlistMovies(mockMovieRepository);
  });

  test('should get watchlist from repository', () async {
    // arrange
    when(mockMovieRepository.getWatchlistMovies())
        .thenAnswer((_) async => Right(testMovieList));
    // act
    final result = await useCase.execute();
    // assert
    expect(result, Right(testMovieList));
  });
}