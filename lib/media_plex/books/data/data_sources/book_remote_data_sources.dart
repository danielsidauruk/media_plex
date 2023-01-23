import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:media_plex/core/utils/exception.dart';
import 'package:media_plex/media_plex/books/data/models/book_detail_model.dart';
import 'package:media_plex/media_plex/books/data/models/book_popular_model.dart';
import 'package:media_plex/media_plex/books/data/models/search_model.dart';

const String apiUrl = 'https://openlibrary.org/';
// const String detailBookUrl = apiUrl;
const String searchUrl = '${apiUrl}search.json?title=';
String detailBook(String key) => 'https://openlibrary.org/$key.json';
String popularBook(String dataSortQuery) => '${apiUrl}trending/$dataSortQuery.json';

abstract class BookRemoteDataSource {
  Future<SearchModel> searchBook(String query);
  Future<BookDetailModel> getBookDetail(String key);
  Future<PopularModel> getPopularBook(String dataSortQuery);
}

class BookRemoteDataSourceImpl implements BookRemoteDataSource {
  final http.Client client;

  BookRemoteDataSourceImpl({required this.client});

  @override
  Future<BookDetailModel> getBookDetail(String key) async {
    final response = await client.get(
      Uri.parse(detailBook(key)),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return BookDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SearchModel> searchBook(String query) async {
    final response = await client.get(
      Uri.parse('$searchUrl$query'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return SearchModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<PopularModel> getPopularBook(String dataSortQuery) async {
    final response = await client.get(
      Uri.parse(popularBook(dataSortQuery)),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return PopularModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}