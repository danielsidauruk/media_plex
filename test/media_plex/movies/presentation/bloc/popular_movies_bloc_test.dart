import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:media_plex/media_plex/movie/domain/usecases/get_popular_movies.dart';
import 'package:media_plex/media_plex/movie/presentation/bloc/popular_movies_bloc/movie_popular_bloc.dart';
import 'package:media_plex/shared/domain/use_cases/use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_object.dart';
import 'popular_movies_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late PopularMoviesBloc moviePopularBloc;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    moviePopularBloc = PopularMoviesBloc(mockGetPopularMovies);
  });

  test('initial state should be Empty', () {
    expect(moviePopularBloc.state, PopularMoviesEmpty());
  });

  blocTest<PopularMoviesBloc, PopularMoviesState>(
    'Should emit [MoviePopularLoading, MoviePopularHasData] when popular data list id gotten successfully',
    build: () {
      when(mockGetPopularMovies.call(NoParams()))
          .thenAnswer((realInvocation) async => Right(testMovieList));
      return moviePopularBloc;
    },
    act: (bloc) => bloc.add(FetchPopularMovies()),
    expect: () => [
      PopularMoviesLoading(),
      PopularMoviesHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.call(NoParams()));
    }
  );
}
















