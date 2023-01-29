import 'package:media_plex/media_plex/movie/domain/repositories/movie_repository.dart';

class GetWatchListStatus {
  final MovieRepository repository;
  GetWatchListStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
