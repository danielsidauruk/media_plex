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
import 'package:media_plex/media_plex/tv_series/data/datasources/database/database_helper_tv_series.dart';
import 'package:media_plex/media_plex/tv_series/data/datasources/tv_series_local_data_source.dart';
import 'package:media_plex/media_plex/tv_series/data/datasources/tv_series_remote_data_source.dart';
import 'package:media_plex/media_plex/tv_series/data/repositories/tv_series_repository_impl.dart';
import 'package:media_plex/media_plex/tv_series/domain/repositories/tv_series_repository.dart';
import 'package:media_plex/media_plex/tv_series/domain/usecases/get_on_air_tv_series.dart';
import 'package:media_plex/media_plex/tv_series/domain/usecases/get_popular_tv_series.dart';
import 'package:media_plex/media_plex/tv_series/domain/usecases/get_top_rated_tv_series.dart';
import 'package:media_plex/media_plex/tv_series/domain/usecases/get_tv_series_detail.dart';
import 'package:media_plex/media_plex/tv_series/domain/usecases/get_tv_series_recommendations.dart';
import 'package:media_plex/media_plex/tv_series/domain/usecases/get_watchlist_tv_series.dart';
import 'package:media_plex/media_plex/tv_series/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:media_plex/media_plex/tv_series/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:media_plex/media_plex/tv_series/domain/usecases/save_watchlist_tv_series.dart';
import 'package:media_plex/media_plex/tv_series/domain/usecases/search_tv_series.dart';
import 'package:media_plex/media_plex/tv_series/presentation/bloc/tv_series_detail_bloc/tv_series_detail_bloc.dart';
import 'package:media_plex/media_plex/tv_series/presentation/bloc/tv_series_on_air_bloc/tv_series_on_air_bloc.dart';
import 'package:media_plex/media_plex/tv_series/presentation/bloc/tv_series_popular_bloc/tv_series_popular_bloc.dart';
import 'package:media_plex/media_plex/tv_series/presentation/bloc/tv_series_recommendation_bloc/tv_series_recommendation_bloc.dart';
import 'package:media_plex/media_plex/tv_series/presentation/bloc/tv_series_search_bloc/tv_series_search_bloc.dart';
import 'package:media_plex/media_plex/tv_series/presentation/bloc/tv_series_top_rated_bloc/tv_series_top_rated_bloc.dart';
import 'package:media_plex/media_plex/tv_series/presentation/bloc/tv_series_watchlist_bloc/tv_series_watchlist_bloc.dart';

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

  // => TV Series
  // BLoC
  locator.registerFactory(() => SearchTVSeriesBloc(locator()));
  locator.registerFactory(() => TVSeriesDetailBloc(locator()));
  locator.registerFactory(() => TVSeriesRecommendationBloc(locator()));
  locator.registerFactory(() => TVSeriesWatchlistBloc(
    locator(),
    locator(),
    locator(),
    locator(),
  ));
  locator.registerFactory(() => TVSeriesOnAirBloc(locator()));
  locator.registerFactory(() => TVSeriesPopularBloc(locator()));
  locator.registerFactory(() => TVSeriesTopRatedBloc(locator()));

  // Use Case
  locator.registerLazySingleton(() => GetOnAirTVSeries(locator()));
  locator.registerLazySingleton(() => GetPopularTVSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTVSeries(locator()));
  locator.registerLazySingleton(() => GetTVSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetTVSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTVSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistTVSeriesStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTVSeries(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTVSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistTVSeries(locator()));

  // Repository
  locator.registerLazySingleton<TVSeriesRepository>(
        () => TVSeriesRepositoryImpl(
          tvSeriesRemoteDataSource: locator(),
          tvSeriesLocalDataSource: locator(),
        ),
  );

  // Data Sources
  locator.registerLazySingleton<TVSeriesRemoteDataSource>(
        () => TVSeriesRemoteDataSourceImpl(client: locator()),
  );
  locator.registerLazySingleton<TVSeriesLocalDataSource>(
        () => TVSeriesLocalDataSourceImpl(databaseHelper: locator()),
  );

  // Helper
  locator.registerLazySingleton<DatabaseHelperTVSeries>(
        () => DatabaseHelperTVSeries(),
  );
}
















