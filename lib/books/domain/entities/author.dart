import 'package:equatable/equatable.dart';
import 'package:media_plex/books/domain/entities/_created.dart';
import 'package:media_plex/books/domain/entities/_book_type.dart';

class Author extends Equatable {
  const Author({
    required this.wikipedia,
    required this.personalName,
    required this.key,
    required this.alternateNames,
    required this.remoteIds,
    required this.type,
    required this.links,
    required this.name,
    required this.title,
    required this.birthDate,
    required this.entityType,
    required this.photos,
    required this.sourceRecords,
    required this.bio,
    required this.latestRevision,
    required this.revision,
    required this.created,
    required this.lastModified,
  });

  final String wikipedia;
  final String personalName;
  final String key;
  final List<String> alternateNames;
  final RemoteIds remoteIds;
  final BookType type;
  final List<Link> links;
  final String name;
  final String title;
  final String birthDate;
  final String entityType;
  final List<int> photos;
  final List<String> sourceRecords;
  final String bio;
  final int latestRevision;
  final int revision;
  final Created created;
  final Created lastModified;

  @override
  List<Object?> get props => [
        wikipedia,
        personalName,
        key,
        alternateNames,
        remoteIds,
        type,
        links,
        name,
        title,
        birthDate,
        entityType,
        photos,
        sourceRecords,
        bio,
        latestRevision,
        revision,
        created,
        lastModified,
      ];
}

class Link extends Equatable {
  const Link({
    required this.title,
    required this.url,
    required this.type,
  });

  final String title;
  final String url;
  final BookType type;

  @override
  List<Object?> get props => [title, url, type];
}

class RemoteIds extends Equatable {
  const RemoteIds({
    required this.wikidata,
    required this.isni,
    required this.goodreads,
    required this.viaf,
    required this.librarything,
    required this.amazon,
  });

  final String wikidata;
  final String isni;
  final String goodreads;
  final String viaf;
  final String librarything;
  final String amazon;

  @override
  List<Object?> get props => [
        wikidata,
        isni,
        goodreads,
        viaf,
        librarything,
        amazon,
      ];
}
