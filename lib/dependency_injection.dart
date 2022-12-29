import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:media_plex/books/data/data_sources/book_remote_data_sources.dart';
import 'package:media_plex/books/data/repositories/library_book_repository_impl.dart';
import 'package:media_plex/books/domain/repositories/books_repository.dart';
import 'package:media_plex/books/domain/use_cases/get_book_details.dart';
import 'package:media_plex/books/domain/use_cases/search_book.dart';
import 'package:media_plex/books/presentation/bloc/book_detail_bloc/book_detail_bloc.dart';
import 'package:media_plex/books/presentation/bloc/search_bloc/search_bloc.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // external
  locator.registerLazySingleton<http.Client>(() => http.Client());

  // bloc
  locator.registerFactory(() => BookDetailBloc(locator()));
  locator.registerFactory(() => SearchBloc(locator()));

  // use cases
  locator.registerLazySingleton(() => GetBookDetails(repository: locator()));
  locator.registerLazySingleton(() => SearchBook(repository: locator()));

  // repository
  locator.registerLazySingleton<LibraryBookRepository>(
    () => LibraryBookRepositoryImpl(remoteDataSource: locator()),
  );

  // data sources
  locator.registerLazySingleton<BookRemoteDataSource>(
      () => BookRemoteDataSourceImpl(client: locator()));
}
