import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:media_plex/media_plex/movie/domain/usecases/remove_from_watchlist.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_object.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveFromWatchlist useCase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    useCase = RemoveFromWatchlist(mockMovieRepository);
  });

  test('should remove watchlist movie from repository', () async {
    // arrange
    when(mockMovieRepository.removeFromWatchlist(testMovieDetail))
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await useCase.execute(testMovieDetail);
    // assert
    verify(mockMovieRepository.removeFromWatchlist(testMovieDetail));
    expect(result, const Right('Removed from watchlist'));
  });
}