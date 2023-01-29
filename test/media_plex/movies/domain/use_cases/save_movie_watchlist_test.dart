import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:media_plex/media_plex/movie/domain/usecases/save_to_watchlist.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_object.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late SaveToWatchlist useCase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    useCase = SaveToWatchlist(mockMovieRepository);
  });

  test('should add watchlist movie from repository', () async {
    // arrange
    when(mockMovieRepository.saveToWatchlist(testMovieDetail))
        .thenAnswer((_) async => const Right('Added to watchlist'));
    // act
    final result = await useCase.call(const SaveParams(movieDetail: testMovieDetail));
    // assert
    verify(mockMovieRepository.saveToWatchlist(testMovieDetail));
    expect(result, const Right('Added to watchlist'));
  });
}