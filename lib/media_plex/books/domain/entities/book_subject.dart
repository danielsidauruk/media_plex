import 'package:equatable/equatable.dart';

class Subject extends Equatable{
  const Subject({
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
    required this.availability,
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
  final Availability availability;

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
    availability,
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

class Availability extends Equatable {
  const Availability({
    required this.status,
    required this.availableToBrowse,
    required this.availableToBorrow,
    required this.availableToWaitlist,
    required this.isPrintdisabled,
    required this.isReadable,
    required this.isLendable,
    required this.isPreviewable,
    required this.identifier,
    required this.isbn,
    required this.oclc,
    required this.openlibraryWork,
    required this.openlibraryEdition,
    required this.lastLoanDate,
    required this.numWaitlist,
    required this.lastWaitlistDate,
    required this.isRestricted,
    required this.isBrowseable,
    required this.src,
  });

  final Status status;
  final bool availableToBrowse;
  final bool availableToBorrow;
  final bool availableToWaitlist;
  final bool isPrintdisabled;
  final bool isReadable;
  final bool isLendable;
  final bool isPreviewable;
  final String identifier;
  final String isbn;
  final dynamic oclc;
  final String openlibraryWork;
  final String openlibraryEdition;
  final dynamic lastLoanDate;
  final dynamic numWaitlist;
  final dynamic lastWaitlistDate;
  final bool isRestricted;
  final bool isBrowseable;
  final Src src;

  @override
  List<Object?> get props => [
    status,
    availableToBrowse,
    availableToBorrow,
    availableToWaitlist,
    isPrintdisabled,
    isReadable,
    isLendable,
    isPreviewable,
    identifier,
    isbn,
    oclc,
    openlibraryWork,
    openlibraryEdition,
    lastLoanDate,
    numWaitlist,
    lastWaitlistDate,
    isRestricted,
    isBrowseable,
    src,
  ];
}

enum Src { CORE_MODELS_LENDING_GET_AVAILABILITY }

enum Status { OPEN, BORROW_AVAILABLE }
