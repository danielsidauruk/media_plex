import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:media_plex/core/utils/failure.dart';
import 'package:media_plex/media_plex/movie/domain/entities/movie.dart';
import 'package:media_plex/media_plex/movie/domain/usecases/search_the_movies.dart';
import 'package:media_plex/media_plex/movie/presentation/bloc/search_the_movie_bloc/search_the_movie_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_the_movies_bloc_test.mocks.dart';

@GenerateMocks([SearchTheMovies])
void main() {
  late MockSearchTheMovies mockSearchTheMovies;
  late SearchTheMovieBloc searchTheMovieBloc;

  setUp(() {
    mockSearchTheMovies = MockSearchTheMovies();
    searchTheMovieBloc = SearchTheMovieBloc(mockSearchTheMovies);
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
    'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tMovieList = <Movie>[tMovieModel];
  const tQuery = 'spiderman';

  test('initial state should be empty', () {
    expect(searchTheMovieBloc.state, SearchTheMovieEmpty());
  });

  blocTest<SearchTheMovieBloc, SearchTheMovieState>(
    'Should emit [SearchTheMovieLoading, SearchTheMovieHasData] when data is gotten successfully',
    build: () {
      when(mockSearchTheMovies.call(const Params(query: tQuery)))
          .thenAnswer((realInvocation) async => Right(tMovieList));
      return searchTheMovieBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchTheMovieLoading(),
      SearchTheMovieHasData(tMovieList),
    ],
    verify: (bloc) {
      verify(mockSearchTheMovies.call(const Params(query: tQuery)));
    }
  );

  blocTest<SearchTheMovieBloc, SearchTheMovieState>(
    'Should emit [SearchTheMoviesBlocLoading, SearchTheMoviesBlocError] when get search is unsuccessful',
    build: () {
      when(mockSearchTheMovies.call(const Params(query: tQuery)))
          .thenAnswer((realInvocation) async => const Left(ServerFailure('Server Failure')));
      return searchTheMovieBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchTheMovieLoading(),
      const SearchTheMovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTheMovies.call(const Params(query: tQuery)));
    }
  );
}





















