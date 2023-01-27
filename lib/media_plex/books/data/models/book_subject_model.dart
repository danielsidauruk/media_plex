import 'package:media_plex/media_plex/books/domain/entities/book_subject.dart';

class BookSubjectModel extends BookSubject {
  const BookSubjectModel({
    required super.key,
    required super.name,
    required super.subjectType,
    required super.workCount,
    required this.worksModel,
  }) : super(works: worksModel);

  final List<WorkModel> worksModel;

  factory BookSubjectModel.fromJson(Map<String, dynamic> json) => BookSubjectModel(
    key: json["key"],
    name: json["name"],
    subjectType: json["subject_type"],
    workCount: json["work_count"],
    worksModel: List<WorkModel>.from(json["works"].map((x) => WorkModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "name": name,
    "subject_type": subjectType,
    "work_count": workCount,
    "works": List<dynamic>.from(worksModel.map((x) => x.toJson())),
  };
}

class WorkModel extends Work {
  const WorkModel({
    required super.key,
    required super.title,
    required super.editionCount,
    required super.coverId,
    required super.coverEditionKey,
    required super.subject,
    required super.iaCollection,
    required super.lendinglibrary,
    required super.printdisabled,
    required super.lendingEdition,
    required super.lendingIdentifier,
    required this.authorsModel,
    required super.firstPublishYear,
    required super.ia,
    required super.publicScan,
    required super.hasFulltext,
  }) : super(authors: authorsModel);

  final List<AuthorModel> authorsModel;

  factory WorkModel.fromJson(Map<String, dynamic> json) => WorkModel(
    key: json["key"],
    title: json["title"],
    editionCount: json["edition_count"],
    coverId: json["cover_id"],
    coverEditionKey: json["cover_edition_key"],
    subject: List<String>.from(json["subject"].map((x) => x)),
    iaCollection: List<String>.from(json["ia_collection"].map((x) => x)),
    lendinglibrary: json["lendinglibrary"],
    printdisabled: json["printdisabled"],
    lendingEdition: json["lending_edition"],
    lendingIdentifier: json["lending_identifier"],
    authorsModel: List<AuthorModel>.from(json["authors"].map((x) => AuthorModel.fromJson(x))),
    firstPublishYear: json["first_publish_year"],
    ia: json["ia"],
    publicScan: json["public_scan"],
    hasFulltext: json["has_fulltext"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "title": title,
    "edition_count": editionCount,
    "cover_id": coverId,
    "cover_edition_key": coverEditionKey,
    "subject": List<dynamic>.from(subject.map((x) => x)),
    "ia_collection": List<dynamic>.from(iaCollection.map((x) => x)),
    "lendinglibrary": lendinglibrary,
    "printdisabled": printdisabled,
    "lending_edition": lendingEdition,
    "lending_identifier": lendingIdentifier,
    "authors": List<dynamic>.from(authorsModel.map((x) => x.toJson())),
    "first_publish_year": firstPublishYear,
    "ia": ia,
    "public_scan": publicScan,
    "has_fulltext": hasFulltext,
  };
}

class AuthorModel extends Author {
  const AuthorModel({
    required super.key,
    required super.name,
  });

  factory AuthorModel.fromJson(Map<String, dynamic> json) => AuthorModel(
    key: json["key"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "name": name,
  };
}
