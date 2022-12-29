import 'package:media_plex/books/data/models/book_type_model.dart';
import 'package:media_plex/books/data/models/create_model.dart';
import 'package:media_plex/books/domain/entities/author.dart';

class AuthorModel extends Author {
  final RemoteIdsModel remoteIdsModel;
  final BookTypeModel bookTypeModel;
  final List<LinkModel> linksModel;
  final CreatedModel createdModel;
  final CreatedModel lastModifiedModel;

  const AuthorModel({
    required super.wikipedia,
    required super.personalName,
    required super.key,
    required super.alternateNames,
    required this.remoteIdsModel,
    required this.bookTypeModel,
    required this.linksModel,
    required super.name,
    required super.title,
    required super.birthDate,
    required super.entityType,
    required super.photos,
    required super.sourceRecords,
    required super.bio,
    required super.latestRevision,
    required super.revision,
    required this.createdModel,
    required this.lastModifiedModel,
  }) : super(
          remoteIds: remoteIdsModel,
          type: bookTypeModel,
          links: linksModel,
          created: createdModel,
          lastModified: lastModifiedModel,
        );

  factory AuthorModel.fromJson(Map<String, dynamic> json) => AuthorModel(
        wikipedia: json["wikipedia"],
        personalName: json["personal_name"],
        key: json["key"],
        alternateNames:
            List<String>.from(json["alternate_names"].map((x) => x)),
        remoteIdsModel: RemoteIdsModel.fromJson(json["remote_ids"]),
        bookTypeModel: BookTypeModel.fromJson(json["type"]),
        linksModel: List<LinkModel>.from(
            json["links"].map((x) => LinkModel.fromJson(x))),
        name: json["name"],
        title: json["title"],
        birthDate: json["birth_date"],
        entityType: json["entity_type"],
        photos: List<int>.from(json["photos"].map((x) => x)),
        sourceRecords: List<String>.from(json["source_records"].map((x) => x)),
        bio: json["bio"],
        latestRevision: json["latest_revision"],
        revision: json["revision"],
        createdModel: CreatedModel.fromJson(json["created"]),
        lastModifiedModel: CreatedModel.fromJson(json["last_modified"]),
      );

  Map<String, dynamic> toJson() => {
        "wikipedia": wikipedia,
        "personal_name": personalName,
        "key": key,
        "alternate_names": List<dynamic>.from(alternateNames.map((x) => x)),
        "remote_ids": remoteIdsModel.toJson(),
        "type": bookTypeModel.toJson(),
        "links": List<dynamic>.from(linksModel.map((x) => x.toJson())),
        "name": name,
        "title": title,
        "birth_date": birthDate,
        "entity_type": entityType,
        "photos": List<dynamic>.from(photos.map((x) => x)),
        "source_records": List<dynamic>.from(sourceRecords.map((x) => x)),
        "bio": bio,
        "latest_revision": latestRevision,
        "revision": revision,
        "created": createdModel.toJson(),
        "last_modified": lastModifiedModel.toJson(),
      };
}

class LinkModel extends Link {
  final BookTypeModel bookTypeModel;

  const LinkModel({
    required super.title,
    required super.url,
    required this.bookTypeModel,
  }) : super(type: bookTypeModel);

  factory LinkModel.fromJson(Map<String, dynamic> json) => LinkModel(
        title: json["title"],
        url: json["url"],
        bookTypeModel: BookTypeModel.fromJson(json["type"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "url": url,
        "type": bookTypeModel.toJson(),
      };
}

class RemoteIdsModel extends RemoteIds {
  const RemoteIdsModel(
      {required super.wikidata,
      required super.isni,
      required super.goodreads,
      required super.viaf,
      required super.librarything,
      required super.amazon});

  factory RemoteIdsModel.fromJson(Map<String, dynamic> json) => RemoteIdsModel(
        wikidata: json["wikidata"],
        isni: json["isni"],
        goodreads: json["goodreads"],
        viaf: json["viaf"],
        librarything: json["librarything"],
        amazon: json["amazon"],
      );

  Map<String, dynamic> toJson() => {
        "wikidata": wikidata,
        "isni": isni,
        "goodreads": goodreads,
        "viaf": viaf,
        "librarything": librarything,
        "amazon": amazon,
      };
}
