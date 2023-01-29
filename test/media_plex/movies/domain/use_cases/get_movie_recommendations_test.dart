import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:media_plex/media_plex/movie/domain/entities/movie.dart';
import 'package:media_plex/media_plex/movie/domain/usecases/get_movie_recommendations.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late GetMovieRecommendations useCase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    useCase = GetMovieRecommendations(mockMovieRepository);
  });

  const tId = 1;
  final tMovies = <Movie>[];

  test('should get list of movie recommendations from the repository', () async {
    // arrange
    when(mockMovieRepository.getMovieRecommendations(tId))
        .thenAnswer((_) async => Right(tMovies));
    // act
    final result = await useCase.call(const Params(id: tId));
    // assert
    expect(result, Right(tMovies));
  });
}