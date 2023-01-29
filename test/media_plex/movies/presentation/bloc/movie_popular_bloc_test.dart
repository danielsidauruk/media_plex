import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:media_plex/media_plex/movie/domain/usecases/get_popular_movies.dart';
import 'package:media_plex/media_plex/movie/presentation/bloc/movie_popular_bloc/movie_popular_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_object.dart';
import 'movie_popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late MoviePopularBloc moviePopularBloc;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    moviePopularBloc = MoviePopularBloc(mockGetPopularMovies);
  });

  test('initial state should be Empty', () {
    expect(moviePopularBloc.state, MoviePopularEmpty());
  });

  blocTest<MoviePopularBloc, MoviePopularState>(
    'Should emit [MoviePopularLoading, MoviePopularHasData] when popular data list id gotten successfully',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((realInvocation) async => Right(testMovieList));
      return moviePopularBloc;
    },
    act: (bloc) => bloc.add(FetchMoviePopular()),
    expect: () => [
      MoviePopularLoading(),
      MoviePopularHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    }
  );
}
















