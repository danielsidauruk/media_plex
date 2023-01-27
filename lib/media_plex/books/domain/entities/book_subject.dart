import 'package:equatable/equatable.dart';

class BookSubject extends Equatable{
  const BookSubject({
    required this.key,
    required this.name,
    required this.subjectType,
    required this.workCount,
    required this.works,
  });

  final String key;
  final String name;
  final String subjectType;
  final int workCount;
  final List<Work> works;

  @override
  List<Object?> get props => [key, name, subjectType, workCount, works];
}

class Work extends Equatable {
  const Work({
    required this.key,
    required this.title,
    required this.editionCount,
    required this.coverId,
    required this.coverEditionKey,
    required this.subject,
    required this.iaCollection,
    required this.lendinglibrary,
    required this.printdisabled,
    required this.lendingEdition,
    required this.lendingIdentifier,
    required this.authors,
    required this.firstPublishYear,
    required this.ia,
    required this.publicScan,
    required this.hasFulltext,
  });

  final String key;
  final String title;
  final int editionCount;
  final int coverId;
  final String coverEditionKey;
  final List<String> subject;
  final List<String> iaCollection;
  final bool lendinglibrary;
  final bool printdisabled;
  final String lendingEdition;
  final String lendingIdentifier;
  final List<Author> authors;
  final int firstPublishYear;
  final String ia;
  final bool publicScan;
  final bool hasFulltext;

  @override
  List<Object?> get props => [
    key,
    title,
    editionCount,
    coverId,
    coverEditionKey,
    subject,
    iaCollection,
    lendinglibrary,
    printdisabled,
    lendingEdition,
    lendingIdentifier,
    authors,
    firstPublishYear,
    ia,
    publicScan,
    hasFulltext,
  ];
}

class Author extends Equatable{
  const Author({
    required this.key,
    required this.name,
  });

  final String key;
  final String name;

  @override
  List<Object?> get props => [key, name];
}
