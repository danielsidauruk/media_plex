import 'package:media_plex/media_plex/books/domain/repositories/books_repository.dart';

class GetBookmarkStatus {
  GetBookmarkStatus(this.repository);
  final BookRepository repository;

  Future<bool> execute(String key) async {
    return repository.isBookmarked(key);
  }
}