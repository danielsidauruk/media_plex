import 'package:equatable/equatable.dart';

class PopularBooks extends Equatable{
  const PopularBooks({
    required this.query,
    required this.works,
    required this.days,
    required this.hours,
  });

  final String query;
  final List<Work> works;
  final int days;
  final int hours;

  @override
  List<Object?> get props => [query, works, days, hours];
}

class Work extends Equatable {
  const Work({
    required this.key,
    required this.title,
    required this.editionCount,
    required this.firstPublishYear,
    required this.hasFulltext,
    required this.publicScanB,
    required this.coverEditionKey,
    required this.coverI,
    required this.language,
    required this.authorKey,
    required this.authorName,
    required this.ia,
    required this.iaCollectionS,
    required this.lendingEditionS,
    required this.lendingIdentifierS,
    required this.availability,
    required this.subtitle,
    required this.idLibrivox,
    required this.idProjectGutenberg,
    required this.idStandardEbooks,
  });

  final String key;
  final String title;
  final int editionCount;
  final int firstPublishYear;
  final bool hasFulltext;
  final bool publicScanB;
  final String coverEditionKey;
  final int coverI;
  final List<String> language;
  final List<String> authorKey;
  final List<String> authorName;
  final List<String> ia;
  final String iaCollectionS;
  final String lendingEditionS;
  final String lendingIdentifierS;
  final Availability availability;
  final String subtitle;
  final List<String> idLibrivox;
  final List<String> idProjectGutenberg;
  final List<String> idStandardEbooks;

  @override
  List<Object?> get props => [
    key,
    title,
    editionCount,
    firstPublishYear,
    hasFulltext,
    publicScanB,
    coverI,
    language,
    authorKey,
    authorName,
    ia,
    iaCollectionS,
    lendingEditionS,
    lendingIdentifierS,
    availability,
    subtitle,
    idLibrivox,
    idProjectGutenberg,
    idStandardEbooks,
  ];
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
    required this.errorMessage,
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
  final DateTime lastLoanDate;
  final String numWaitlist;
  final DateTime lastWaitlistDate;
  final bool isRestricted;
  final bool isBrowseable;
  final Src src;
  final String errorMessage;

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
    errorMessage,
  ];
}

enum Status { BORROW_UNAVAILABLE, BORROW_AVAILABLE, PRIVATE, ERROR, OPEN }

enum Src { CORE_MODELS_LENDING_GET_AVAILABILITY }