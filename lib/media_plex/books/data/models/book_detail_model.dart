import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:media_plex/media_plex/books/domain/entities/book_detail.dart';

class BookDetailModel extends BookDetail {
  const BookDetailModel({
    required this.descriptionModel,
    required this.linksModel,
    required super.title,
    required super.covers,
    required super.subjectPlaces,
    required super.firstPublishDate,
    required super.subjectPeople,
    required super.key,
    required this.authorsModel,
    required super.subjectTimes,
    required this.typeModel,
    required super.subjects,
    required super.latestRevision,
    required super.revision,
    required this.createdModel,
    required this.lastModifiedModel,
  }) : super(
    description: descriptionModel,
    links: linksModel,
    authors: authorsModel,
    type: typeModel,
    created: createdModel,
    lastModified: lastModifiedModel,
  );

  final dynamic descriptionModel;
  final List<LinkModel> linksModel;
  final List<AuthorModel> authorsModel;
  final TypeModel typeModel;
  final CreatedModel createdModel;
  final CreatedModel lastModifiedModel;

  factory BookDetailModel.fromJson(Map<String, dynamic> json) {
    var descriptionModel = const DescriptionModel(type: "-", value: "No description available");
    try {
      if (json["description"] != null) {
        descriptionModel = DescriptionModel.fromJson(json['description']);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return BookDetailModel(
      descriptionModel: descriptionModel,
      linksModel: List<LinkModel>.from(json["links"]?.map((x) => LinkModel.fromJson(x)) ?? []),
      title: json["title"],
      covers: List<int>.from(json["covers"]?.map((x) => x) ?? []),
      subjectPlaces: List<String>.from(json["subject_places"]?.map((x) => x) ?? []),
      firstPublishDate: json["first_publish_date"] ?? "",
      subjectPeople: List<String>.from(json["subject_people"]?.map((x) => x) ?? []),
      key: json["key"],
      authorsModel: List<AuthorModel>.from(json["authors"]?.map((x) => AuthorModel.fromJson(x)) ?? []),
      subjectTimes: List<String>.from(json["subject_times"]?.map((x) => x) ?? []),
      typeModel: TypeModel.fromJson(json["type"] ?? ""),
      subjects: List<String>.from(json["subjects"]?.map((x) => x) ?? []),
      latestRevision: json["latest_revision"] ?? 0,
      revision: json["revision"] ?? 0,
      createdModel: CreatedModel.fromJson(json["created"] ?? ""),
      lastModifiedModel: CreatedModel.fromJson(json["last_modified"] ?? ""),
    );
  }
}

class DescriptionModel extends Description {
  const DescriptionModel({
    required super.type,
    required super.value,
  });

  factory DescriptionModel.fromJson(dynamic json) {
    if (json is String) {
      json = jsonDecode(json);
    }
    return DescriptionModel(
      type: json["type"] ?? "-",
      value: json["value"] ?? "No description available",
    );
  }
}

class AuthorModel extends Author{
  const AuthorModel({
    required this.authorModel,
    required this.typeModel,
  }) : super (author: authorModel, type: typeModel);

  final TypeModel authorModel;
  final TypeModel typeModel;

  factory AuthorModel.fromJson(Map<String, dynamic> json) => AuthorModel(
    authorModel: TypeModel.fromJson(json["author"]),
    typeModel: TypeModel.fromJson(json["type"]),
  );
}

class TypeModel extends Type{
  const TypeModel({required super.key});

  factory TypeModel.fromJson(Map<String, dynamic> json) => TypeModel(
    key: json["key"],
  );
}

class CreatedModel extends Created {
  const CreatedModel({
    required super.type,
    required super.value,
  });

  factory CreatedModel.fromJson(Map<String, dynamic> json) => CreatedModel(
    type: json["type"],
    value: DateTime.tryParse(json["value"] ?? "") ?? DateTime.utc(0, 0, 0),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "value": value.toIso8601String(),
  };
}

class LinkModel extends Link{
  const LinkModel({
    required super.title,
    required super.url,
    required this.typeModel,
  }) : super(type: typeModel);

  final TypeModel typeModel;

  factory LinkModel.fromJson(Map<String, dynamic> json) => LinkModel(
    title: json["title"] ?? "",
    url: json["url"] ?? "",
    typeModel: TypeModel.fromJson(json["type"] ?? ""),
  );
}