import 'package:media_plex/media_plex/movie/data/datasources/database/movie_database_helper.dart';
import 'package:media_plex/media_plex/movie/data/datasources/movie_local_data_source.dart';
import 'package:media_plex/media_plex/movie/data/datasources/movie_remote_data_source.dart';
import 'package:media_plex/media_plex/movie/domain/repositories/movie_repository.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

@GenerateMocks([
  MovieRepository,
  MovieDatabaseHelper,
  MovieRemoteDataSource,
  MovieLocalDataSource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])

void main() {}
