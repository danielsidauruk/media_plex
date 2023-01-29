import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:media_plex/core/utils/constants.dart';
import 'package:media_plex/core/utils/exception.dart';
import 'package:media_plex/media_plex/books/data/models/book_detail_model.dart';
import 'package:media_plex/media_plex/books/data/models/book_popular_model.dart';
import 'package:media_plex/media_plex/books/data/models/book_by_subject_model.dart';
import 'package:media_plex/media_plex/books/data/models/book_search_model.dart';

abstract class BookRemoteDataSource {
  Future<SearchTheBookModel> searchTheBook(String query);
  Future<BookDetailModel> getBookDetail(String key);
  Future<PopularBookModel> getPopularBooks(String dataSortQuery);
  Future<BookBySubjectModel> getBookBySubject(String subject);
}

class BookRemoteDataSourceImpl implements BookRemoteDataSource {
  final http.Client client;

  BookRemoteDataSourceImpl({required this.client});

  @override
  Future<BookDetailModel> getBookDetail(String key) async {
    final response = await client.get(
      Uri.parse(bookDetail(key)),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return BookDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SearchTheBookModel> searchTheBook(String query) async {
    final response = await client.get(
      Uri.parse(searchTheBookBy(query)),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return SearchTheBookModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<PopularBookModel> getPopularBooks(String dataSortQuery) async {
    final response = await client.get(
      Uri.parse(popularBooks(dataSortQuery)),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return PopularBookModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<BookBySubjectModel> getBookBySubject(String subject) async {
    final response = await client.get(
      Uri.parse(bookBySubject(subject)),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return BookBySubjectModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }


}