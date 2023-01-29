import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_plex/media_plex/books/presentation/bloc/book_by_subject_bloc/book_subject_bloc.dart';
import 'package:media_plex/media_plex/books/presentation/bloc/book_search_bloc/book_search_bloc.dart';
import 'package:media_plex/media_plex/books/presentation/bloc/bookmark_bloc/bookmark_bloc.dart';
import 'package:media_plex/media_plex/books/presentation/bloc/popular_books_bloc/book_popular_bloc.dart';
import 'package:media_plex/media_plex/books/presentation/pages/popular_books_page.dart';
import 'package:media_plex/media_plex/books/presentation/pages/book_search_page.dart';
import 'package:media_plex/media_plex/books/presentation/pages/book_detail_page.dart';
import 'package:media_plex/dependency_injection.dart' as di;
import 'package:media_plex/media_plex/books/presentation/bloc/book_detail_bloc/book_detail_bloc.dart';
import 'package:media_plex/media_plex/books/presentation/pages/book_home_page.dart';
import 'package:media_plex/media_plex/books/presentation/pages/book_by_subject_page.dart';
import 'package:media_plex/media_plex/movie/domain/usecases/search_the_movies.dart';
import 'package:media_plex/media_plex/movie/presentation/bloc/now_playing_movies_bloc/now_playing_movies_bloc.dart';
import 'package:media_plex/media_plex/movie/presentation/bloc/popular_movies_bloc/movie_popular_bloc.dart';
import 'package:media_plex/media_plex/movie/presentation/bloc/search_the_movie_bloc/search_the_movie_bloc.dart';
import 'package:media_plex/media_plex/movie/presentation/bloc/top_rated_movies_bloc/movie_top_rated_bloc.dart';
import 'package:media_plex/media_plex/movie/presentation/pages/movie_home_page.dart';
import 'package:media_plex/media_plex/movie/presentation/pages/movie_now_playing_page.dart';
import 'package:media_plex/media_plex/tv_series/presentation/bloc/tv_series_detail_bloc/tv_series_detail_bloc.dart';
import 'package:media_plex/media_plex/tv_series/presentation/bloc/tv_series_on_air_bloc/tv_series_on_air_bloc.dart';
import 'package:media_plex/media_plex/tv_series/presentation/bloc/tv_series_popular_bloc/tv_series_popular_bloc.dart';
import 'package:media_plex/media_plex/tv_series/presentation/bloc/tv_series_recommendation_bloc/tv_series_recommendation_bloc.dart';
import 'package:media_plex/media_plex/tv_series/presentation/bloc/tv_series_search_bloc/tv_series_search_bloc.dart';
import 'package:media_plex/media_plex/tv_series/presentation/bloc/tv_series_top_rated_bloc/tv_series_top_rated_bloc.dart';
import 'package:media_plex/media_plex/tv_series/presentation/bloc/tv_series_watchlist_bloc/tv_series_watchlist_bloc.dart';
import 'package:media_plex/media_plex/tv_series/presentation/pages/tv_series_detail_page.dart';
import 'package:media_plex/media_plex/tv_series/presentation/pages/tv_series_home_page.dart';
import 'package:media_plex/media_plex/tv_series/presentation/pages/tv_series_on_air_page.dart';
import 'package:media_plex/media_plex/tv_series/presentation/pages/tv_series_popular_page.dart';
import 'package:media_plex/media_plex/tv_series/presentation/pages/tv_series_search_page.dart';
import 'package:media_plex/media_plex/tv_series/presentation/pages/tv_series_top_rated_page.dart';

import 'core/utils/utils.dart';
import 'core/utils/routes.dart';
import 'home_page.dart';
import 'media_plex/movie/presentation/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'media_plex/movie/presentation/bloc/movie_recommendations_bloc/movie_recommendations_bloc.dart';
import 'media_plex/movie/presentation/bloc/movie_watchlist_bloc/movie_watchlist_bloc.dart';
import 'media_plex/movie/presentation/pages/movie_detail_page.dart';
import 'media_plex/movie/presentation/pages/movie_popular_page.dart';
import 'media_plex/movie/presentation/pages/movie_search_page.dart';
import 'media_plex/movie/presentation/pages/movie_top_rated_page.dart';
import 'shared/presentation/page/repository_page.dart';

void main() async {
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // book
        BlocProvider(create: (_) => di.locator<BookDetailBloc>()),
        BlocProvider(create: (_) => di.locator<SearchTheBookBloc>()),
        BlocProvider(create: (_) => di.locator<PopularBooksBloc>()),
        BlocProvider(create: (_) => di.locator<BookmarkBloc>()),
        BlocProvider(create: (_) => di.locator<BookBySubjectBloc>()),

        // movie
        BlocProvider(create: (_) => di.locator<MovieDetailBloc>()),
        BlocProvider(create: (_) => di.locator<SearchTheMovieBloc>()),
        BlocProvider(create: (_) => di.locator<NowPlayingMoviesBloc>()),
        BlocProvider(create: (_) => di.locator<PopularMoviesBloc>()),
        BlocProvider(create: (_) => di.locator<TopRatedMoviesBloc>()),
        BlocProvider(create: (_) => di.locator<MovieRecommendationBloc>()),
        BlocProvider(create: (_) => di.locator<MovieWatchlistBloc>()),

        // tv series
        BlocProvider(create: (_) => di.locator<TVSeriesDetailBloc>()),
        BlocProvider(create: (_) => di.locator<SearchTVSeriesBloc>()),
        BlocProvider(create: (_) => di.locator<TVSeriesOnAirBloc>()),
        BlocProvider(create: (_) => di.locator<TVSeriesPopularBloc>()),
        BlocProvider(create: (_) => di.locator<TVSeriesTopRatedBloc>()),
        BlocProvider(create: (_) => di.locator<TVSeriesRecommendationBloc>()),
        BlocProvider(create: (_) => di.locator<TVSeriesWatchlistBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Media Flex',
        theme: ThemeData(

          fontFamily: 'Roboto',
          scaffoldBackgroundColor: Colors.black,
          textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 56),
            headline2: TextStyle(fontSize: 45),
            bodyText1: TextStyle(fontSize: 28),
            subtitle1: TextStyle(fontSize: 16),
            subtitle2: TextStyle(fontSize: 14),
            button: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 14,
            ),
          ),

          brightness: Brightness.dark,
          primaryColor: Colors.black,
          accentColor: Colors.white,
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(color: Colors.white),
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        ),
        home: const HomePage(),

        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {

            case homeRoute:
              return MaterialPageRoute(builder: (_) => const HomePage());

            // repository
            case repositoryRoute:
              return MaterialPageRoute(builder: (_) => const RepositoryPage());

            // books
            case bookHomeRoute:
              return MaterialPageRoute(builder: (_) => const BookHomePage());
            case searchTheBookRoute:
              return MaterialPageRoute(builder: (_) => const SearchTheBookPage());
            case popularBooksRoute:
              return MaterialPageRoute(builder: (_) => const PopularBooksPage());
            case bookBySubjectRoute:
              final title = settings.arguments as String;
              return MaterialPageRoute(
                builder: (_) => BookBySubjectPage(title: title),
                settings: settings,
              );

            case bookDetailRoute:
              final key = settings.arguments as String;
              return MaterialPageRoute(
                builder: (_) => BookDetailPage(bookKey: key),
                settings: settings,
              );

          // movies
            case movieHomeRoute:
              return MaterialPageRoute(builder: (_) => const MovieHomePage());
            case movieDetailRoute:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case popularMoviesRoute:
              return MaterialPageRoute(builder: (_) => const PopularMoviesPage());
            case searchTheMovieRoute:
              return MaterialPageRoute(builder: (_) => const SearchTheMoviePage());
            case topRatedMoviesRoute:
              return MaterialPageRoute(builder: (_) => const TopRatedMoviesPage());
            case nowPlayingMoviesRoute:
              return MaterialPageRoute(builder: (_) => const NowPlayingMoviesPage());

          // TV Series
            case tvSeriesHomeRoute:
              return MaterialPageRoute(builder: (_) => const TVSeriesHomePage());
            case tvSeriesDetailRoute:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TVSeriesDetailPage(id: id),
                settings: settings,
              );

            case tvSeriesOnAirRoute:
              return MaterialPageRoute(builder: (_) => const OnAirTVSeriesPage());
            case tvSeriesPopularRoute:
              return MaterialPageRoute(builder: (_) => const PopularTVSeriesPage());
            case tvSeriesSearchRoute:
              return MaterialPageRoute(builder: (_) => const SearchTheTVSeriesPage());
            case tvSeriesTopRatedRoute:
              return MaterialPageRoute(builder: (_) => const TopRatedTVSeriesPage());

            default:
              return MaterialPageRoute(
                builder: (_) {
                  return const Scaffold(
                    body: Center(child: Text('Page not found :(')),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
