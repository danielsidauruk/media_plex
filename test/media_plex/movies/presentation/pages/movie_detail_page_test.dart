import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:media_plex/media_plex/movie/presentation/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:media_plex/media_plex/movie/presentation/bloc/movie_recommendations_bloc/movie_recommendations_bloc.dart';
import 'package:media_plex/media_plex/movie/presentation/bloc/movie_watchlist_bloc/movie_watchlist_bloc.dart';
import 'package:media_plex/media_plex/movie/presentation/pages/movie_detail_page.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../dummy_object.dart';

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

class MovieDetailEventFake extends Fake implements MovieDetailEvent {}

class MovieDetailStateFake extends Fake implements MovieDetailState {}

class MockMovieRecommendationBloc extends MockBloc<MovieRecommendationEvent, MovieRecommendationState>
    implements MovieRecommendationBloc {}

class MovieRecommendationEventFake extends Fake implements MovieRecommendationEvent {}

class MovieRecommendationStateFake extends Fake implements MovieRecommendationState {}

class MockMovieWatchListBloc extends MockBloc<MovieWatchlistEvent, MovieWatchlistState>
    implements MovieWatchlistBloc {}

class MovieWatchlistEventFake extends Fake implements MovieWatchlistState {}

class MovieWatchlistStateFake extends Fake implements MovieWatchlistState {}

@GenerateMocks([MovieDetailBloc])
void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;
  late MockMovieRecommendationBloc mockMovieRecommendationBloc;
  late MockMovieWatchListBloc mockMovieWatchListBloc;

  setUpAll(() {
    registerFallbackValue(MovieDetailEventFake());
    registerFallbackValue(MovieDetailStateFake());
    registerFallbackValue(MovieRecommendationEventFake());
    registerFallbackValue(MovieRecommendationStateFake());
    registerFallbackValue(MovieWatchlistEventFake());
    registerFallbackValue(MovieWatchlistStateFake());
  });

  setUp(() {
    mockMovieDetailBloc = MockMovieDetailBloc();
    mockMovieRecommendationBloc = MockMovieRecommendationBloc();
    mockMovieWatchListBloc = MockMovieWatchListBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailBloc>(create: (context) => mockMovieDetailBloc),
        BlocProvider<MovieRecommendationBloc>(create: (context) => mockMovieRecommendationBloc),
        BlocProvider<MovieWatchlistBloc>(create: (context) => mockMovieWatchListBloc),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'Watchlist button should display add icon when movie not added to watchlist',
        (widgetTester) async {
      when(() => mockMovieDetailBloc.state)
          .thenReturn(const MovieDetailHasData(testMovieDetail));
      when(() => mockMovieRecommendationBloc.state)
          .thenReturn(MovieRecommendationHasData(testMovieList));
      when(() => mockMovieWatchListBloc.state)
          .thenReturn(const WatchlistHasData(false));

      final watchlistButtonIcon = find.byIcon(Icons.add);
      await widgetTester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));
      expect(watchlistButtonIcon, findsOneWidget);
    },
  );

  testWidgets(
    'Watchlist button should displat checl icon when movie is added to watchlist',
        (widgetTester) async {
      when(() => mockMovieDetailBloc.state)
          .thenReturn(const MovieDetailHasData(testMovieDetail));
      when(() => mockMovieRecommendationBloc.state)
      .thenReturn(MovieRecommendationHasData(testMovieList));
      when(() => mockMovieWatchListBloc.state)
      .thenReturn(const WatchlistHasData(true));

      final watchlistButtonIcon = find.byIcon(Icons.check);
      await widgetTester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));
      expect(watchlistButtonIcon, findsOneWidget);
    },
  );
}



















