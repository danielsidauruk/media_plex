import 'package:equatable/equatable.dart';
import 'package:media_plex/media_plex/books/domain/entities/_book_type.dart';
import 'package:media_plex/media_plex/books/domain/entities/_created.dart';

class BookDetail extends Equatable {
  const BookDetail({
    required this.description,
    required this.subjects,
    required this.key,
    required this.title,
    required this.authors,
    required this.type,
    required this.covers,
    required this.latestRevision,
    required this.revision,
    required this.created,
    required this.lastModified,
  });

  final Created description;
  final List<String> subjects;
  final String key;
  final String title;
  final List<Author> authors;
  final BookType type;
  final List<int> covers;
  final int latestRevision;
  final int revision;
  final Created created;
  final Created lastModified;

  @override
  List<Object?> get props => [
        description,
        subjects,
        key,
        title,
        authors,
        type,
        covers,
        latestRevision,
        revision,
        created,
        lastModified,
      ];
}

class Author extends Equatable {
  const Author({
    required this.author,
    required this.type,
  });

  final BookType author;
  final BookType type;

  @override
  List<Object?> get props => [author, type];
}
