import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:media_plex/core/utils/failure.dart';
import 'package:media_plex/media_plex/movie/domain/usecases/get_top_rated_movies.dart';
import 'package:media_plex/media_plex/movie/presentation/bloc/top_rated_movies_bloc/movie_top_rated_bloc.dart';
import 'package:media_plex/shared/domain/use_cases/use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_object.dart';
import 'top_rated_movies_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main(){
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late TopRatedMoviesBloc topRatedMoviesBloc;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMoviesBloc = TopRatedMoviesBloc(mockGetTopRatedMovies);
  });

  test('initial state should be empty', () {
    expect(topRatedMoviesBloc.state, TopRatedMoviesEmpty());
  });

  blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
    'Should emit [TopRatedMoviesLoading, TopRatedMoviesHasData] when get top rated movie data is successful',
    build: () {
      when(mockGetTopRatedMovies.call(NoParams()))
          .thenAnswer((realInvocation) async => Right(testMovieList));
      return topRatedMoviesBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedMovies()),
    expect: () => [
      TopRatedMoviesLoading(),
      TopRatedMoviesHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.call(NoParams()));
    }
  );

  blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
    'Should emit [TopRatedMoviesLoading, TopRatedMoviesError] when get top rated data is unsuccessful',
    build: () {
      when(mockGetTopRatedMovies.call(NoParams()))
          .thenAnswer((realInvocation) async => const Left(ServerFailure('Server Failure')));
      return topRatedMoviesBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedMovies()),
    expect: () => [
      TopRatedMoviesLoading(),
      const TopRatedMoviesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.call(NoParams()));
    }
  );
}