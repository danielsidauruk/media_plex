import 'package:get_it/get_it.dart';
import 'package:media_plex/media_plex/books/data/data_sources/book_remote_data_sources.dart';
import 'package:media_plex/media_plex/books/data/repositories/library_book_repository_impl.dart';
import 'package:media_plex/media_plex/books/domain/repositories/books_repository.dart';
import 'package:media_plex/media_plex/books/domain/use_cases/get_book_details.dart';
import 'package:media_plex/media_plex/books/domain/use_cases/get_popular_book.dart';
import 'package:media_plex/media_plex/books/domain/use_cases/search_book.dart';
import 'package:media_plex/media_plex/books/presentation/bloc/book_detail_bloc/book_detail_bloc.dart';
import 'package:media_plex/media_plex/books/presentation/bloc/popular_bloc/book_popular_bloc.dart';
import 'package:media_plex/media_plex/books/presentation/bloc/search_bloc/book_search_bloc.dart';
import 'package:media_plex/media_plex/movie/domain/usecases/get_now_playing_movies.dart';
import 'package:media_plex/media_plex/movie/presentation/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:media_plex/media_plex/movie/presentation/bloc/movie_recommendations_bloc/movie_recommendations_bloc.dart';
import 'package:media_plex/media_plex/movie/presentation/bloc/movie_search_bloc/search_bloc.dart';

import 'core/utils/ssl_pinning.dart';
import 'media_plex/movie/data/datasources/database/database_helper.dart';
import 'media_plex/movie/data/datasources/movie_local_data_source.dart';
import 'media_plex/movie/data/datasources/movie_remote_data_source.dart';
import 'media_plex/movie/data/repositories/movie_repository_impl.dart';
import 'media_plex/movie/domain/repositories/movie_repository.dart';
import 'media_plex/movie/domain/usecases/get_movie_detail.dart';
import 'media_plex/movie/domain/usecases/get_movie_recommendations.dart';
import 'media_plex/movie/domain/usecases/get_popular_movies.dart';
import 'media_plex/movie/domain/usecases/get_top_rated_movies.dart';
import 'media_plex/movie/domain/usecases/get_watchlist_movies.dart';
import 'media_plex/movie/domain/usecases/get_watchlist_status.dart';
import 'media_plex/movie/domain/usecases/remove_watchlist.dart';
import 'media_plex/movie/domain/usecases/save_watchlist.dart';
import 'media_plex/movie/domain/usecases/search_movies.dart';
import 'media_plex/movie/presentation/bloc/movie_now_playing_bloc/movie_now_playing_bloc.dart';
import 'media_plex/movie/presentation/bloc/movie_popular_bloc/movie_popular_bloc.dart';
import 'media_plex/movie/presentation/bloc/movie_top_rated_bloc/movie_top_rated_bloc.dart';
import 'media_plex/movie/presentation/bloc/movie_watchlist_bloc/movie_watchlist_bloc.dart';

final locator = GetIt.instance;

Future<void> init() async {

  // => BOOK
  // external
  locator.registerLazySingleton(() => HttpSSLPinning.client);

  // bloc
  locator.registerFactory(() => BookDetailBloc(locator()));
  locator.registerFactory(() => BookSearchBloc(locator()));
  locator.registerFactory(() => PopularBloc(locator()));

  // use cases
  locator.registerLazySingleton(() => GetBookDetails(repository: locator()));
  locator.registerLazySingleton(() => SearchBook(repository: locator()));
  locator.registerLazySingleton(() => GetPopularBook(repository: locator()));

  // repository
  locator.registerLazySingleton<LibraryBookRepository>(
    () => LibraryBookRepositoryImpl(remoteDataSource: locator()),
  );

  // data sources
  locator.registerLazySingleton<BookRemoteDataSource>(
      () => BookRemoteDataSourceImpl(client: locator()));

  // => MOVIE
  // bloc
  locator.registerFactory(() => SearchMoviesBloc(locator()));
  locator.registerFactory(() => MovieDetailBloc(locator()));
  locator.registerFactory(() => MovieRecommendationBloc(locator()));
  locator.registerFactory(() => MovieWatchlistBloc(
    locator(),
    locator(),
    locator(),
    locator(),
  ));
  locator.registerFactory(() => MovieNowPlayingBloc(locator()));
  locator.registerFactory(() => MoviePopularBloc(locator()));
  locator.registerFactory(() => MovieTopRatedBloc(locator()));

  // use cases
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
        () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
          () => MovieRemoteDataSourceImpl(client: locator()));

  locator.registerLazySingleton<MovieLocalDataSource>(
          () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  // database helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());


}
