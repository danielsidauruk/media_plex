import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:media_plex/media_plex/movie/domain/usecases/get_now_playing_movies.dart';
import 'package:media_plex/media_plex/movie/presentation/bloc/movie_now_playing_bloc/now_playing_movies_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_object.dart';
import 'movie_now_playing_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MovieNowPlayingBloc movieNowPlayingBloc;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    movieNowPlayingBloc = MovieNowPlayingBloc(mockGetNowPlayingMovies);
  });

  test('initial state should be Empty', () {
    expect(movieNowPlayingBloc.state, MovieNowPlayingEmpty());
  });

  blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
    'Should emit [MovieNowPlayingLoading, MovieNowPlayingHasData] when detail data is gotten successfully',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((realInvocation) async => Right(testMovieList));
      return movieNowPlayingBloc;
    },
    act: (bloc) => bloc.add(FetchMovieNowPlaying()),
    expect: () => [
      MovieNowPlayingLoading(),
      MovieNowPlayingHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    }
  );
}