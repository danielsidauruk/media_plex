import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:media_plex/media_plex/movie/domain/usecases/get_movie_detail.dart';

import '../../../../dummy_object.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late GetMovieDetail useCase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    useCase = GetMovieDetail(mockMovieRepository);
  });

  const tId = 1;

  test('should get movie detail from the repository', () async {
    // arrange
    when(mockMovieRepository.getMovieDetail(tId))
        .thenAnswer((_) async => const Right(testMovieDetail));
    // act
    final result = await useCase.call(const Params(id: tId));
    // assert
    expect(result, const Right(testMovieDetail));
  });
}