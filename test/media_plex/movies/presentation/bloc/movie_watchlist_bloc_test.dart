import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:media_plex/core/utils/failure.dart';
import 'package:media_plex/media_plex/movie/domain/usecases/get_movie_detail.dart';
import 'package:media_plex/media_plex/movie/domain/usecases/get_watchlist_movies.dart';
import 'package:media_plex/media_plex/movie/domain/usecases/get_watchlist_status.dart';
import 'package:media_plex/media_plex/movie/domain/usecases/remove_from_watchlist.dart';
import 'package:media_plex/media_plex/movie/domain/usecases/save_to_watchlist.dart';
import 'package:media_plex/media_plex/movie/presentation/bloc/movie_watchlist_bloc/movie_watchlist_bloc.dart';
import 'package:media_plex/shared/domain/use_cases/use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_object.dart';
import 'movie_watchlist_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistMovies,
  RemoveFromWatchlist,
  SaveToWatchlist,
  GetWatchListStatus,
])
void main() {
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockRemoveFromWatchlist mockRemoveFromWatchlist;
  late MockSaveToWatchlist mockSaveToWatchlist;
  late MockGetWatchListStatus mockGetWatchListStatus;

  late MovieWatchlistBloc movieWatchlistBloc;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockRemoveFromWatchlist = MockRemoveFromWatchlist();
    mockSaveToWatchlist = MockSaveToWatchlist();
    mockGetWatchListStatus = MockGetWatchListStatus();
    movieWatchlistBloc = MovieWatchlistBloc(
        mockGetWatchlistMovies,
        mockGetWatchListStatus,
        mockSaveToWatchlist,
        mockRemoveFromWatchlist,
    );
  });

  const tId = 1;

  test('initial state should be Empty', () {
    expect(movieWatchlistBloc.state, MovieWatchlistEmpty());
  });

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'Should emit [MovieWatchlistLoading, MovieWatchlistHasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistMovies.call(NoParams()))
          .thenAnswer((realInvocation) async => Right(testMovieList));
      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(FetchMovieWatchlist()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      MovieWatchlistLoading(),
      MovieWatchlistHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.call(NoParams()));
    }
  );

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'Should emit [MovieWatchlistLoading, MovieWatchlistError] when data is gotten unsuccessfully',
      build: () {
        when(mockGetWatchlistMovies.call(NoParams()))
            .thenAnswer((realInvocation) async => const Left(ServerFailure('Server Failure')));
        return movieWatchlistBloc;
      },
    act: (bloc) => bloc.add(FetchMovieWatchlist()),
    expect: () => [
      MovieWatchlistLoading(),
      const MovieWatchlistError('Server Failure'),
    ],
    verify: (bloc) {
        verify(mockGetWatchlistMovies.call(NoParams()));
    }
  );
}














