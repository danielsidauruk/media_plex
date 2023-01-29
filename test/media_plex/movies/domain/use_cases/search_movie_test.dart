import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:media_plex/media_plex/movie/domain/entities/movie.dart';
import 'package:media_plex/media_plex/movie/domain/usecases/search_the_movies.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTheMovies useCase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    useCase = SearchTheMovies(mockMovieRepository);
  });

  final tMovies = <Movie>[];
  const tQuery = 'Spiderman';

  test('should return list of movie from the repository', () async {
    // arrange
    when(mockMovieRepository.searchTheMovie(tQuery))
        .thenAnswer((_) async => Right(tMovies));
    // act
    final result = await useCase.execute(tQuery);
    // assert
    expect(result, Right(tMovies));
  });
}