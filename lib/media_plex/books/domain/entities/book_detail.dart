import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class BookDetail extends Equatable{
  const BookDetail({
    required this.description,
    required this.links,
    required this.title,
    required this.covers,
    required this.subjectPlaces,
    required this.firstPublishDate,
    required this.subjectPeople,
    required this.key,
    required this.authors,
    required this.subjectTimes,
    required this.type,
    required this.subjects,
    required this.latestRevision,
    required this.revision,
    required this.created,
    required this.lastModified,
  });

  final Description description;
  final List<Link> links;
  final String title;
  final List<int> covers;
  final List<String> subjectPlaces;
  final String firstPublishDate;
  final List<String> subjectPeople;
  final String key;
  final List<Author> authors;
  final List<String> subjectTimes;
  final Type type;
  final List<String> subjects;
  final int latestRevision;
  final int revision;
  final Created created;
  final Created lastModified;

  @override
  List<Object?> get props => [
    description,
    links,
    title,
    covers,
    subjectPlaces,
    firstPublishDate,
    subjectPeople,
    key,
    authors,
    subjectTimes,
    type,
    subjects,
    latestRevision,
    revision,
    created,
    lastModified,
  ];
}

class Description extends Equatable {
  final String type;
  final String value;

  const Description({
    required this.type,
    required this.value,
  });

  @override
  List<Object?> get props => [type, value];
}

class Author extends Equatable{
  const Author({
    required this.author,
    required this.type,
  });

  final Type author;
  final Type type;

  @override
  List<Object?> get props => [author, type];
}

class Type extends Equatable{
  const Type({required this.key});

  final String key;

  @override
  List<Object?> get props => [key];
}

class Created extends Equatable{
  const Created({
    required this.type,
    required this.value,
  });

  final String type;
  final DateTime value;

  @override
  List<Object?> get props => [type, value];
}

class Link extends Equatable{
  const Link({
    required this.title,
    required this.url,
    required this.type,
  });

  final String title;
  final String url;
  final Type type;

  @override
  List<Object?> get props => [title, url, type];
}

