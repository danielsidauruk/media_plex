import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_plex/media_plex/books/presentation/bloc/popular_bloc/popular_bloc.dart';
import 'package:media_plex/media_plex/books/presentation/pages/detail_page.dart';
import 'package:media_plex/dependency_injection.dart' as di;
import 'package:media_plex/media_plex/books/presentation/bloc/book_detail_bloc/book_detail_bloc.dart';
import 'package:media_plex/media_plex/books/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:media_plex/media_plex/books/presentation/pages/book_home_page.dart';
import 'package:media_plex/media_plex/movie/presentation/pages/movie_home_page.dart';

import 'core/common/utils.dart';
import 'core/utils/routes.dart';
import 'home_page.dart';
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
import 'media_plex/movie/presentation/pages/movie_watchlist_page.dart';

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
        BlocProvider(create: (_) => di.locator<SearchBloc>()),
        BlocProvider(create: (_) => di.locator<PopularBloc>()),

        // movie
        BlocProvider(create: (_) => di.locator<MovieDetailBloc>()),
        BlocProvider(create: (_) => di.locator<SearchMoviesBloc>()),
        BlocProvider(create: (_) => di.locator<MovieNowPlayingBloc>()),
        BlocProvider(create: (_) => di.locator<MoviePopularBloc>()),
        BlocProvider(create: (_) => di.locator<MovieTopRatedBloc>()),
        BlocProvider(create: (_) => di.locator<MovieWatchlistBloc>()),
        BlocProvider(create: (_) => di.locator<MovieRecommendationBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Media Flex',
        theme: ThemeData(
          fontFamily: 'Roboto',
          scaffoldBackgroundColor: Colors.white,
          textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 56, color: Colors.black),
            headline2: TextStyle(fontSize: 45, color: Colors.grey),
            bodyText1: TextStyle(fontSize: 28, color: Colors.black),
            subtitle1: TextStyle(fontSize: 16, color: Colors.black),
            subtitle2: TextStyle(fontSize: 14, color: Colors.black),
            button: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14,
                color: Colors.black),
          ),
          appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(color: Colors.blueGrey)),
          colorScheme: const ColorScheme.light(
            primary: Colors.blueGrey,
            secondary: Colors.deepOrangeAccent,
          ),
        ),
        // home: const BookHomePage(),
        home: const HomePage(),
        // home: const WatchlistMoviesPage(),

        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            // movie
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
              return MaterialPageRoute(builder: (_) => const SearchPage());
            case topRatedMovieRoute:
              return MaterialPageRoute(builder: (_) => const TopRatedMoviesPage());
            case WatchlistMoviesPage.routeName:
              return MaterialPageRoute(builder: (_) => const WatchlistMoviesPage());


            case HomePage.routeName:
              return MaterialPageRoute(builder: (_) => const HomePage());
            case BookHomePage.routeName:
              return MaterialPageRoute(builder: (_) => const BookHomePage());
            case DetailPage.routeName:
              final key = settings.arguments as String;
              return MaterialPageRoute(
                builder: (_) => DetailPage(bookKey: key),
                settings: settings,
              );
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
