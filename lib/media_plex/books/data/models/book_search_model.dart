import 'package:media_plex/media_plex/books/domain/entities/search_the_book.dart';

class SearchTheBookModel extends SearchTheBook {
  SearchTheBookModel({
    required super.numFound,
    required super.start,
    required super.numFoundExact,
    required this.docsModel,
    required super.searchNumFound,
    required super.q,
    required super.offset,
  }) : super(docs: docsModel);

  final List<DocModel> docsModel;

  factory SearchTheBookModel.fromJson(Map<String, dynamic> json) => SearchTheBookModel(
    numFound: json["numFound"],
    start: json["start"],
    numFoundExact: json["numFoundExact"],
    docsModel:
    List<DocModel>.from(json["docs"].map((x) => DocModel.fromJson(x))),
    searchNumFound: json["num_found"],
    q: json["q"],
    offset: json["offset"],
  );
}

class DocModel extends Doc {
  DocModel({
    required super.key,
    required super.type,
    required super.seed,
    required super.title,
    required super.titleSuggest,
    required super.editionCount,
    required super.editionKey,
    required super.publishDate,
    required super.publishYear,
    required super.firstPublishYear,
    required super.numberOfPagesMedian,
    required super.lccn,
    required super.publishPlace,
    required super.contributor,
    required super.lcc,
    required super.ddc,
    required super.lastModifiedI,
    required super.ebookCountI,
    required super.ebookAccess,
    required super.hasFulltext,
    required super.publicScanB,
    required super.publisher,
    required super.language,
    required super.authorKey,
    required super.authorName,
    required super.person,
    required super.place,
    required super.subject,
    required super.idLibrarything,
    required super.publisherFacet,
    required super.personKey,
    required super.placeKey,
    required super.personFacet,
    required super.subjectFacet,
    required super.version,
    required super.placeFacet,
    required super.lccSort,
    required super.authorFacet,
    required super.subjectKey,
    required super.ddcSort,
    required super.oclc,
    required super.isbn,
    required super.ia,
    required super.iaCollectionS,
    required super.lendingEditionS,
    required super.lendingIdentifierS,
    required super.printdisabledS,
    required super.coverEditionKey,
    required super.coverI,
    required super.firstSentence,
    required super.idGoodreads,
    required super.iaBoxId,
    required super.authorAlternativeName,
    required super.subtitle,
    required super.iaCollection,
    required super.time,
    required super.timeFacet,
    required super.timeKey,
    required super.idAmazon,
  });

  factory DocModel.fromJson(Map<String, dynamic> json) => DocModel(
    key: json["key"],
    type: typeValues.map[json["type"]]!,
    seed: List<String>.from(json["seed"].map((x) => x)),
    title: json["title"],
    titleSuggest: json["title_suggest"],
    editionCount: json["edition_count"],
    editionKey: List<String>.from(json["edition_key"]?.map((x) => x) ?? []),
    publishDate:
    List<String>.from(json["publish_date"]?.map((x) => x) ?? []),
    publishYear: List<int>.from(json["publish_year"]?.map((x) => x) ?? []),
    firstPublishYear: json["first_publish_year"] ?? 0,
    numberOfPagesMedian: json["number_of_pages_median"] ?? 0,
    lccn: List<String>.from(json["lccn"]?.map((x) => x) ?? []),
    publishPlace:
    List<String>.from(json["publish_place"]?.map((x) => x) ?? []),
    contributor:
    List<String>.from(json["contributor"]?.map((x) => x) ?? []),
    lcc: List<String>.from(json["lcc"]?.map((x) => x) ?? []),
    ddc: List<String>.from(json["ddc"]?.map((x) => x) ?? []),
    lastModifiedI: json["last_modified_i"],
    ebookCountI: json["ebook_count_i"],
    ebookAccess:
    ebookAccessValues.map[json["ebook_access"]] ?? EbookAccess.NO_EBOOK,
    hasFulltext: json["has_fulltext"],
    publicScanB: json["public_scan_b"],
    publisher: List<String>.from(json["publisher"]?.map((x) => x) ?? []),
    language: List<Language>.from(json["language"]
        ?.map((x) => languageValues.map[x] ?? Language.UND) ??
        []),
    authorKey: List<String>.from(json["author_key"]?.map((x) => x) ?? []),
    authorName: List<String>.from(json["author_name"]?.map((x) => x) ?? []),
    person: List<String>.from(json["person"]?.map((x) => x) ?? []),
    place: List<String>.from(json["place"]?.map((x) => x) ?? []),
    subject: List<String>.from(json["subject"]?.map((x) => x) ?? []),
    idLibrarything:
    List<String>.from(json["id_librarything"]?.map((x) => x) ?? []),
    publisherFacet:
    List<String>.from(json["publisher_facet"]?.map((x) => x) ?? []),
    personKey: List<String>.from(json["person_key"]?.map((x) => x) ?? []),
    placeKey: List<String>.from(json["place_key"]?.map((x) => x) ?? []),
    personFacet:
    List<String>.from(json["person_facet"]?.map((x) => x) ?? []),
    subjectFacet:
    List<String>.from(json["subject_facet"]?.map((x) => x) ?? []),
    version: json["_version_"].toDouble(),
    placeFacet: List<String>.from(json["place_facet"]?.map((x) => x) ?? []),
    lccSort: json["lcc_sort"] ?? "",
    authorFacet:
    List<String>.from(json["author_facet"]?.map((x) => x) ?? []),
    subjectKey: List<String>.from(json["subject_key"]?.map((x) => x) ?? []),
    ddcSort: json["ddc_sort"] ?? "",
    oclc: List<String>.from(json["oclc"]?.map((x) => x) ?? []),
    isbn: List<String>.from(json["isbn"]?.map((x) => x) ?? []),
    ia: List<String>.from(json["ia"]?.map((x) => x) ?? []),
    iaCollectionS: iaCollectionSValues.map[json["ia_collection_s"]],
    lendingEditionS: json["lending_edition_s"] ?? "",
    lendingIdentifierS: json["lending_identifier_s"] ?? "",
    printdisabledS: json["printdisabled_s"] ?? "",
    coverEditionKey: json["cover_edition_key"] ?? "",
    coverI: json["cover_i"] ?? 0,
    firstSentence:
    List<String>.from(json["first_sentence"]?.map((x) => x) ?? []),
    idGoodreads:
    List<String>.from(json["id_goodreads"]?.map((x) => x) ?? []),
    iaBoxId: List<String>.from(json["ia_box_id"]?.map((x) => x) ?? []),
    authorAlternativeName: List<String>.from(
        json["author_alternative_name"]?.map((x) => x) ?? []),
    subtitle: json["subtitle"] ?? "",
    iaCollection:
    List<String>.from(json["ia_collection"]?.map((x) => x) ?? []),
    time: List<String>.from(json["time"]?.map((x) => x) ?? []),
    timeFacet: List<String>.from(json["time_facet"]?.map((x) => x) ?? []),
    timeKey: List<String>.from(json["time_key"]?.map((x) => x) ?? []),
    idAmazon: List<String>.from(json["id_amazon"]?.map((x) => x) ?? []),
  );
}

final ebookAccessValues = EnumValues({
  "borrowable": EbookAccess.BORROWABLE,
  "no_ebook": EbookAccess.NO_EBOOK,
});

enum IaCollectionS {
  INLIBRARY_INTERNETARCHIVEBOOKS_PRINTDISABLED_UDC_OL_UNI_OL,
  INLIBRARY_INTERNETARCHIVEBOOKS_PRINTDISABLED,
  CHINA_INLIBRARY_INTERNETARCHIVEBOOKS_PRINTDISABLED
}

final iaCollectionSValues = EnumValues({
  "china;inlibrary;internetarchivebooks;printdisabled":
      IaCollectionS.CHINA_INLIBRARY_INTERNETARCHIVEBOOKS_PRINTDISABLED,
  "inlibrary;internetarchivebooks;printdisabled":
      IaCollectionS.INLIBRARY_INTERNETARCHIVEBOOKS_PRINTDISABLED,
  "inlibrary;internetarchivebooks;printdisabled;udc-ol;uni-ol":
      IaCollectionS.INLIBRARY_INTERNETARCHIVEBOOKS_PRINTDISABLED_UDC_OL_UNI_OL
});

enum Language { ENG, FRE, UND, RUM, SPA, ITA, GER }

final languageValues = EnumValues({
  "eng": Language.ENG,
  "fre": Language.FRE,
  "ger": Language.GER,
  "ita": Language.ITA,
  "rum": Language.RUM,
  "spa": Language.SPA,
  "und": Language.UND
});

final typeValues = EnumValues({"work": BookTypeValues.WORK});

class EnumValues<T> {
  late Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));

    return reverseMap;
  }
}
