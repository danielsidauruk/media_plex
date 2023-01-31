import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:media_plex/media_plex/movie/domain/usecases/get_movie_recommendations.dart';
import 'package:media_plex/media_plex/movie/presentation/bloc/movie_recommendations_bloc/movie_recommendations_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_object.dart';
import 'movie_recommendations_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MovieRecommendationBloc movieRecommendationBloc;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    movieRecommendationBloc = MovieRecommendationBloc(mockGetMovieRecommendations);
  });

  const tId = 1;

  test('initial state should be Empty', () {
    expect(movieRecommendationBloc.state, MovieRecommendationEmpty());
  });

  blocTest(
    'Should emit [MovieRecommendationLoading, MovieRecommendationHasData] when detail data is gotten successfully',
    build: () {
      when(mockGetMovieRecommendations.call(const Params(id: tId)))
          .thenAnswer((realInvocation) async => Right(testMovieList));
      return movieRecommendationBloc;
    },
    act: (bloc) => bloc.add(const FetchMovieRecommendation(tId)),
    expect: () => [
      MovieRecommendationLoading(),
      MovieRecommendationHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.call(const Params(id: tId)));
    }
  );
}