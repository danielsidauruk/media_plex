import 'package:media_plex/media_plex/books/domain/entities/book_popular.dart';

class PopularModel extends Popular {
  const PopularModel({
    required super.query,
    required this.worksModel,
    required super.days,
    required super.hours,
  }) : super (works: worksModel);

  final List<WorkModel> worksModel;

  factory PopularModel.fromJson(Map<String, dynamic> json) => PopularModel(
    query: json["query"],
    worksModel: List<WorkModel>.from(json["works"].map((x) => WorkModel.fromJson(x))),
    days: json["days"],
    hours: json["hours"],
  );

  Map<String, dynamic> toJson() => {
    "query": query,
    "works": List<dynamic>.from(worksModel.map((x) => x.toJson())),
    "days": days,
    "hours": hours,
  };
}

class WorkModel extends Work {
  const WorkModel({
    required super.key,
    required super.title,
    required super.editionCount,
    required super.firstPublishYear,
    required super.hasFulltext,
    required super.publicScanB,
    required super.coverEditionKey,
    required super.coverI,
    required super.language,
    required super.authorKey,
    required super.authorName,
    required super.ia,
    required super.iaCollectionS,
    required super.lendingEditionS,
    required super.lendingIdentifierS,
    required this.availabilityModel,
    required super.subtitle,
    required super.idLibrivox,
    required super.idProjectGutenberg,
    required super.idStandardEbooks,
  }) : super(availability: availabilityModel);

  final AvailabilityModel availabilityModel;

  factory WorkModel.fromJson(Map<String, dynamic> json) => WorkModel(
    key: json["key"],
    title: json["title"],
    editionCount: json["edition_count"],
    firstPublishYear: json["first_publish_year"],
    hasFulltext: json["has_fulltext"] ?? false,
    publicScanB: json["public_scan_b"] ?? false,
    coverEditionKey: json["cover_edition_key"] ?? "",
    coverI: json["cover_i"] ?? 0,
    language: List<String>.from(json["language"]?.map((x) => x) ?? []),
    authorKey: List<String>.from(json["author_key"].map((x) => x)),
    authorName: List<String>.from(json["author_name"].map((x) => x)),
    ia: List<String>.from(json["ia"]?.map((x) => x) ?? []),
    iaCollectionS: json["ia_collection_s"] ?? "",
    lendingEditionS: json["lending_edition_s"] ?? "",
    lendingIdentifierS: json["lending_identifier_s"] ?? "",
    availabilityModel: AvailabilityModel.fromJson(json["availability"] ?? {"status": "unavailable"}),
    subtitle: json["subtitle"] ?? "",
    idLibrivox: List<String>.from(json["id_librivox"]?.map((x) => x) ?? []),
    idProjectGutenberg: List<String>.from(json["id_project_gutenberg"]?.map((x) => x) ?? []),
    idStandardEbooks: List<String>.from(json["id_standard_ebooks"]?.map((x) => x) ?? []),
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "title": title,
    "edition_count": editionCount,
    "first_publish_year": firstPublishYear,
    "has_fulltext": hasFulltext,
    "public_scan_b": publicScanB,
    "cover_edition_key": coverEditionKey,
    "cover_i": coverI,
    "language": List<dynamic>.from(language.map((x) => x)),
    "author_key": List<dynamic>.from(authorKey.map((x) => x)),
    "author_name": List<dynamic>.from(authorName.map((x) => x)),
    "ia": List<dynamic>.from(ia.map((x) => x)),
    "ia_collection_s": iaCollectionS,
    "lending_edition_s": lendingEditionS,
    "lending_identifier_s": lendingIdentifierS,
    "availability": availabilityModel.toJson(),
    "subtitle": subtitle,
    "id_librivox": List<dynamic>.from(idLibrivox.map((x) => x)),
    "id_project_gutenberg": List<dynamic>.from(idProjectGutenberg.map((x) => x)),
    "id_standard_ebooks": List<dynamic>.from(idStandardEbooks.map((x) => x)),
  };
}

class AvailabilityModel extends Availability {
  const AvailabilityModel({
    required super.status,
    required super.availableToBrowse,
    required super.availableToBorrow,
    required super.availableToWaitlist,
    required super.isPrintdisabled,
    required super.isReadable,
    required super.isLendable,
    required super.isPreviewable,
    required super.identifier,
    required super.isbn,
    required super.oclc,
    required super.openlibraryWork,
    required super.openlibraryEdition,
    required super.lastLoanDate,
    required super.numWaitlist,
    required super.lastWaitlistDate,
    required super.isRestricted,
    required super.isBrowseable,
    required super.src,
    required super.errorMessage,
  });

  factory AvailabilityModel.fromJson(Map<String, dynamic> json) => AvailabilityModel(
    status: statusValues.map[json["status"]] ?? Status.BORROW_UNAVAILABLE,
    availableToBrowse: json["available_to_browse"] ?? false,
    availableToBorrow: json["available_to_borrow"] ?? false,
    availableToWaitlist: json["available_to_waitlist"] ?? false,
    isPrintdisabled: json["is_printdisabled"] ?? false,
    isReadable: json["is_readable"] ?? false,
    isLendable: json["is_lendable"] ?? false,
    isPreviewable: json["is_previewable"] ?? false,
    identifier: json["identifier"] ?? "",
    isbn: json["isbn"] ?? "",
    oclc: json["oclc"],
    openlibraryWork: json["openlibrary_work"] ?? "",
    openlibraryEdition: json["openlibrary_edition"] ?? "",
    lastLoanDate: DateTime.tryParse(json["last_loan_date"] ?? "") ?? DateTime.utc(0, 0, 0),
    numWaitlist: json["num_waitlist"] ?? "",
    lastWaitlistDate: DateTime.tryParse(json["last_waitlist_date"] ?? "") ?? DateTime.utc(0, 0, 0),
    isRestricted: json["is_restricted"] ?? false,
    isBrowseable: json["is_browseable"] ?? false,
    src: srcValues.map[json["__src__"]] ?? Src.CORE_MODELS_LENDING_GET_AVAILABILITY,
    errorMessage: json["error_message"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "status": statusValues.reverse[status],
    "available_to_browse": availableToBrowse,
    "available_to_borrow": availableToBorrow,
    "available_to_waitlist": availableToWaitlist,
    "is_printdisabled": isPrintdisabled,
    "is_readable": isReadable,
    "is_lendable": isLendable,
    "is_previewable": isPreviewable,
    "identifier": identifier,
    "isbn": isbn,
    "oclc": oclc,
    "openlibrary_work": openlibraryWork,
    "openlibrary_edition": openlibraryEdition,
    "last_loan_date": lastLoanDate.toIso8601String(),
    "num_waitlist": numWaitlist,
    "last_waitlist_date": lastWaitlistDate.toIso8601String(),
    "is_restricted": isRestricted,
    "is_browseable": isBrowseable,
    "__src__": srcValues.reverse[src],
    "error_message": errorMessage,
  };
}

final srcValues = EnumValues({
  "core.models.lending.get_availability": Src.CORE_MODELS_LENDING_GET_AVAILABILITY
});

final statusValues = EnumValues({
  "borrow_available": Status.BORROW_AVAILABLE,
  "borrow_unavailable": Status.BORROW_UNAVAILABLE,
  "error": Status.ERROR,
  "open": Status.OPEN,
  "private": Status.PRIVATE
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}