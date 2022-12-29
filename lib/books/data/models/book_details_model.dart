import 'package:media_plex/books/data/models/book_type_model.dart';
import 'package:media_plex/books/data/models/create_model.dart';
import 'package:media_plex/books/domain/entities/books_details.dart';

class BookDetailsModel extends BookDetail {
  const BookDetailsModel({
    required this.descriptionModel,
    required super.subjects,
    required super.key,
    required super.title,
    required this.authorsModel,
    required this.bookTypeModel,
    required super.covers,
    required super.latestRevision,
    required super.revision,
    required this.createdModel,
    required this.lastModifiedModel,
  }) : super(
          description: descriptionModel,
          authors: authorsModel,
          type: bookTypeModel,
          created: createdModel,
          lastModified: lastModifiedModel,
        );

  final CreatedModel descriptionModel;
  final List<AuthorModel> authorsModel;
  final BookTypeModel bookTypeModel;
  final CreatedModel createdModel;
  final CreatedModel lastModifiedModel;

  factory BookDetailsModel.fromJson(Map<String, dynamic> json) =>
      BookDetailsModel(
        bookTypeModel: BookTypeModel.fromJson(json["type"]),
        title: json["title"],
        subjects: List<String>.from(json["subjects"]?.map((x) => x) ?? []),
        descriptionModel: CreatedModel.fromJson(json["description"] ?? {}),
        key: json["key"],
        covers: List<int>.from(json["covers"]?.map((x) => x) ?? []),
        authorsModel: List<AuthorModel>.from(
            json["authors"].map((x) => AuthorModel.fromJson(x))),
        latestRevision: json["latest_revision"] ?? "",
        revision: json["revision"],
        createdModel: CreatedModel.fromJson(json["created"] ?? ""),
        lastModifiedModel: CreatedModel.fromJson(json["last_modified"] ?? ""),
      );

  Map<String, dynamic> toJson() => {
        "type": bookTypeModel.toJson(),
        "title": title,
        "subjects": List<dynamic>.from(subjects.map((x) => x)),
        "description": descriptionModel.toJson(),
        "key": key,
        "covers": List<dynamic>.from(covers.map((x) => x)),
        "authors": List<dynamic>.from(authorsModel.map((x) => x.toJson())),
        "latest_revision": latestRevision,
        "revision": revision,
        "created": createdModel.toJson(),
        "last_modified": lastModifiedModel.toJson(),
      };
}

class AuthorModel extends Author {
  const AuthorModel({
    required this.authorModel,
    required this.typeModel,
  }) : super(
          author: authorModel,
          type: typeModel,
        );

  final BookTypeModel authorModel;
  final BookTypeModel typeModel;

  factory AuthorModel.fromJson(Map<String, dynamic> json) => AuthorModel(
        typeModel: BookTypeModel.fromJson(json["type"]),
        authorModel: BookTypeModel.fromJson(json["author"]),
      );

  Map<String, dynamic> toJson() => {
        "type": typeModel.toJson(),
        "author": authorModel.toJson(),
      };
}
