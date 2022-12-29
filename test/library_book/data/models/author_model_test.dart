import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:media_plex/books/data/models/book_type_model.dart';
import 'package:media_plex/books/data/models/create_model.dart';
import 'package:media_plex/books/data/models/author_model.dart';
import 'package:media_plex/books/domain/entities/author.dart';

import '../../../dummy_object/dummy_object.dart';
import '../../../fixtures/fixture_reader.dart';

void main() {
  AuthorModel tAuthorModel = AuthorModel(
    wikipedia: 'wikipedia',
    personalName: 'personalName',
    key: 'key',
    alternateNames: const ['alternateNames'],
    remoteIdsModel: const RemoteIdsModel(
      wikidata: 'wikidata',
      isni: 'isni',
      goodreads: 'goodreads',
      viaf: 'viaf',
      librarything: 'librarything',
      amazon: 'amazon',
    ),
    bookTypeModel: const BookTypeModel(key: 'key'),
    linksModel: const [
      LinkModel(
        title: 'title',
        url: 'url',
        bookTypeModel: BookTypeModel(key: 'key'),
      ),
    ],
    name: 'name',
    title: 'title',
    birthDate: 'birthDate',
    entityType: 'entityType',
    photos: const [1, 2, 3],
    sourceRecords: const ['sourceRecords'],
    bio: 'bio',
    latestRevision: 1,
    revision: 1,
    createdModel: CreatedModel(
      type: 'type',
      value: DateTime.now(),
    ),
    lastModifiedModel: CreatedModel(
      type: 'type',
      value: DateTime.now(),
    ),
  );

  test('should be a subclass of Author entity', () async {
    // assert
    expect(tAuthorModel, isA<Author>());
  });

  group('fromJson', () {
    test('should return a valid model', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('author.json'));
      // act
      final result = AuthorModel.fromJson(jsonMap);
      // assert
      expect(result, tAuthor);
    });
  });

  // group('toJson', () {
  //   test('should return a JSON map containing the proper data', () async {
  //     // act
  //     final result = tAuthorModel.toJson();
  //     // assert
  //     final expectedJsonMap = {
  //       "wikipedia": "wikipedia",
  //       "personal_name": "personalName",
  //       "key": "key",
  //       "alternate_names": ["alternateNames"],
  //       "remote_ids": {
  //         "wikidata": "wikidata",
  //         "isni": "isni",
  //         "goodreads": "goodreads",
  //         "viaf": "viaf",
  //         "librarything": "librarything",
  //         "amazon": "amazon",
  //       },
  //       "type": {"key": "key"},
  //       "links": [{
  //         "title": "title",
  //         "url": "url",
  //         "type": {"key": "key"},
  //       }],
  //       "name": "name",
  //       "title": "title",
  //       "birth_date": "birthDate",
  //       "entity_type": "entityType",
  //       "photos": [1, 2, 3],
  //       "source_records": ["sourceRecords"],
  //       "bio": "bio",
  //       "latest_revision": 1,
  //       "revision": 1,
  //       "created": [{
  //         "type": "type",
  //         "value": 1,
  //       }],
  //       "last_modified": [{
  //         "type": "type",
  //         "value": 1,
  //       }],
  //     };
  //     expect(result, expectedJsonMap);
  //   });
  // });
}
