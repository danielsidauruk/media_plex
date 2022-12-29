import 'package:media_plex/books/domain/entities/_book_type.dart';

import '../../data/models/search_model.dart';

class Search {
  Search({
    required this.numFound,
    required this.start,
    required this.numFoundExact,
    required this.docs,
    required this.searchNumFound,
    required this.q,
    required this.offset,
  });

  final int numFound;
  final int start;
  final bool numFoundExact;
  final List<Doc> docs;
  final int searchNumFound;
  final String q;
  final dynamic offset;
}

class Doc {
  Doc({
    required this.key,
    required this.type,
    required this.seed,
    required this.title,
    required this.titleSuggest,
    required this.editionCount,
    required this.editionKey,
    required this.publishDate,
    required this.publishYear,
    required this.firstPublishYear,
    required this.numberOfPagesMedian,
    required this.lccn,
    required this.publishPlace,
    required this.contributor,
    required this.lcc,
    required this.ddc,
    required this.lastModifiedI,
    required this.ebookCountI,
    required this.ebookAccess,
    required this.hasFulltext,
    required this.publicScanB,
    required this.publisher,
    required this.language,
    required this.authorKey,
    required this.authorName,
    required this.person,
    required this.place,
    required this.subject,
    required this.idLibrarything,
    required this.publisherFacet,
    required this.personKey,
    required this.placeKey,
    required this.personFacet,
    required this.subjectFacet,
    required this.version,
    required this.placeFacet,
    required this.lccSort,
    required this.authorFacet,
    required this.subjectKey,
    required this.ddcSort,
    required this.oclc,
    required this.isbn,
    required this.ia,
    required this.iaCollectionS,
    required this.lendingEditionS,
    required this.lendingIdentifierS,
    required this.printdisabledS,
    required this.coverEditionKey,
    required this.coverI,
    required this.firstSentence,
    required this.idGoodreads,
    required this.iaBoxId,
    required this.authorAlternativeName,
    required this.subtitle,
    required this.iaCollection,
    required this.time,
    required this.timeFacet,
    required this.timeKey,
    required this.idAmazon,
  });

  final String key;
  final BookTypeValues type;
  final List<String> seed;
  final String title;
  final String titleSuggest;
  final int editionCount;
  final List<String> editionKey;
  final List<String> publishDate;
  final List<int> publishYear;
  final int firstPublishYear;
  final int numberOfPagesMedian;
  final List<String> lccn;
  final List<String> publishPlace;
  final List<String> contributor;
  final List<String> lcc;
  final List<String> ddc;
  final int lastModifiedI;
  final int ebookCountI;
  final EbookAccess ebookAccess;
  final bool hasFulltext;
  final bool publicScanB;
  final List<String> publisher;
  final List<Language>? language;
  final List<String> authorKey;
  final List<String> authorName;
  final List<String> person;
  final List<String> place;
  final List<String> subject;
  final List<String> idLibrarything;
  final List<String> publisherFacet;
  final List<String> personKey;
  final List<String> placeKey;
  final List<String> personFacet;
  final List<String> subjectFacet;
  final double version;
  final List<String> placeFacet;
  final String lccSort;
  final List<String> authorFacet;
  final List<String> subjectKey;
  final String ddcSort;
  final List<String> oclc;
  final List<String> isbn;
  final List<String> ia;
  final IaCollectionS? iaCollectionS;
  final String lendingEditionS;
  final String lendingIdentifierS;
  final String printdisabledS;
  final String coverEditionKey;
  final int coverI;
  final List<String>? firstSentence;
  final List<String> idGoodreads;
  final List<String> iaBoxId;
  final List<String> authorAlternativeName;
  final String? subtitle;
  final List<String> iaCollection;
  final List<String> time;
  final List<String>? timeFacet;
  final List<String> timeKey;
  final List<String> idAmazon;
}

enum EbookAccess { BORROWABLE, NO_EBOOK, PRINTDISABLED }

enum BookTypeValues { WORK }
