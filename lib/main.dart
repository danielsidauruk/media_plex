import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_plex/media_plex/books/presentation/bloc/bookmark/bookmark_bloc.dart';
import 'package:media_plex/media_plex/books/presentation/bloc/popular_bloc/book_popular_bloc.dart';
import 'package:media_plex/media_plex/books/presentation/pages/book_popular_page.dart';
import 'package:media_plex/media_plex/books/presentation/pages/book_search_page.dart';
import 'package:media_plex/media_plex/books/presentation/pages/book_detail_page.dart';
import 'package:media_plex/dependency_injection.dart' as di;
import 'package:media_plex/media_plex/books/presentation/bloc/book_detail_bloc/book_detail_bloc.dart';
import 'package:media_plex/media_plex/books/presentation/bloc/search_bloc/book_search_bloc.dart';
import 'package:media_plex/media_plex/books/presentation/pages/book_home_page.dart';
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

import 'core/common/utils.dart';
import 'core/utils/routes.dart';
import 'home_page.dart';
import 'media_plex/books/presentation/pages/book_by_subjects.dart';
import 'media_plex/movie/presentation/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'media_plex/movie/presentation/bloc/movie_now_playing_bloc/movie_now_playing_bloc.dart';
import 'media_plex/movie/presentation/bloc/movie_popular_bloc/movie_popular_bloc.dart';
import 'media_plex/movie/presentation/bloc/movie_recommendations_bloc/movie_recommendations_bloc.dart';
import 'media_plex/movie/presentation/bloc/movie_search_bloc/search_bloc.dart';
import 'media_plex/movie/presentation/bloc/movie_top_rated_bloc/movie_top_rated_bloc.dart';
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
        BlocProvider(create: (_) => di.locator<BookSearchBloc>()),
        BlocProvider(create: (_) => di.locator<PopularBloc>()),
        BlocProvider(create: (_) => di.locator<BookmarkBloc>()),

        // movie
        BlocProvider(create: (_) => di.locator<MovieDetailBloc>()),
        BlocProvider(create: (_) => di.locator<SearchMoviesBloc>()),
        BlocProvider(create: (_) => di.locator<MovieNowPlayingBloc>()),
        BlocProvider(create: (_) => di.locator<MoviePopularBloc>()),
        BlocProvider(create: (_) => di.locator<MovieTopRatedBloc>()),
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

            // repository
            case RepositoryPage.routeName:
              return MaterialPageRoute(builder: (_) => const RepositoryPage());

            // books
            case HomePage.routeName:
              return MaterialPageRoute(builder: (_) => const HomePage());
            case BookHomePage.routeName:
              return MaterialPageRoute(builder: (_) => const BookHomePage());
            case BookSearchPage.routeName:
              return MaterialPageRoute(builder: (_) => const BookSearchPage());
            case BookPopularPage.routeName:
              return MaterialPageRoute(builder: (_) => const BookPopularPage());

              // case BookBySubjectsPage.routeName:
            //   final bookSubject = settings.arguments as String;
            //   final iconSubject = settings.arguments as String;
            //   return MaterialPageRoute(
            //     builder: (_) => BookBySubjectsPage(
            //       subject: bookSubject,
            //       icon: iconSubject,),
            //     settings: settings,
            //   );

            case BookDetailPage.routeName:
              final key = settings.arguments as String;
              return MaterialPageRoute(
                builder: (_) => BookDetailPage(bookKey: key),
                settings: settings,
              );

          // movies
            case MovieHomePage.routeName:
              return MaterialPageRoute(builder: (_) => const MovieHomePage());
            case detailMovieRoute:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case popularMovieRoute:
              return MaterialPageRoute(builder: (_) => const PopularMoviesPage());
            case searchMovieRoute:
              return MaterialPageRoute(builder: (_) => const MovieSearchPage());
            case topRatedMovieRoute:
              return MaterialPageRoute(builder: (_) => const MovieTopRatedPage());
            case MovieNowPlayingPage.routeName:
              return MaterialPageRoute(builder: (_) => const MovieNowPlayingPage());

          // TV Series
            case homeTVSeriesRoute:
              return MaterialPageRoute(builder: (_) => const TVSeriesHomePage());
            case detailTVSeriesRoute:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TVSeriesDetailPage(id: id),
                settings: settings,
              );

            case onAirTVSeriesRoute:
              return MaterialPageRoute(builder: (_) => const TVSeriesOnAirPage());
            case popularTVSeriesRoute:
              return MaterialPageRoute(builder: (_) => const TVSeriesPopularPage());
            case searchTVSeriesRoute:
              return MaterialPageRoute(builder: (_) => const TVSeriesSearchPage());
            case topRatedTVSeriesRoute:
              return MaterialPageRoute(builder: (_) => const TVSeriesTopRatedPage());

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
