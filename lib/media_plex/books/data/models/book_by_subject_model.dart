import 'package:media_plex/media_plex/books/domain/entities/books_by_subject.dart';

class BookBySubjectModel extends BooksBySubject {
  const BookBySubjectModel({
    required super.key,
    required super.name,
    required super.subjectType,
    required super.workCount,
    required this.worksModel,
  }) : super(works: worksModel);

  final List<WorkModel> worksModel;

  factory BookBySubjectModel.fromJson(Map<String, dynamic> json) => BookBySubjectModel(
    key: json["key"],
    name: json["name"],
    subjectType: json["subject_type"],
    workCount: json["work_count"],
    worksModel: List<WorkModel>.from(json["works"].map((x) => WorkModel.fromJson(x))),
  );
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
    editionCount: json["edition_count"] ?? 0,
    coverId: json["cover_id"] ?? 0,
    coverEditionKey: json["cover_edition_key"] ?? "",
    subject: List<String>.from(json["subject"]?.map((x) => x) ?? []),
    iaCollection: List<String>.from(json["ia_collection"]?.map((x) => x) ?? []),
    lendinglibrary: json["lendinglibrary"] ?? false,
    printdisabled: json["printdisabled"] ?? false,
    lendingEdition: json["lending_edition"] ?? "",
    lendingIdentifier: json["lending_identifier"] ?? "",
    authorsModel: List<AuthorModel>.from(json["authors"]?.map((x) => AuthorModel.fromJson(x)) ?? []),
    firstPublishYear: json["first_publish_year"] ?? 0,
    ia: json["ia"] ?? "",
    publicScan: json["public_scan"] ?? false,
    hasFulltext: json["has_fulltext"] ?? false,
  );
}

class AuthorModel extends Author {
  const AuthorModel({
    required super.key,
    required super.name,
  });

  factory AuthorModel.fromJson(Map<String, dynamic> json) => AuthorModel(
    key: json["key"] ?? "",
    name: json["name"] ?? "",
  );
}
