import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:media_plex/core/exception.dart';
import 'package:media_plex/books/data/models/book_details_model.dart';
import 'package:media_plex/books/data/models/search_model.dart';

const String apiUrl = 'https://openlibrary.org/';
const String detailBookUrl = apiUrl;
const String searchUrl = '${apiUrl}search.json?title=';

abstract class BookRemoteDataSource {
  Future<SearchModel> searchBook(String query);
  Future<BookDetailsModel> getBookDetail(String key);
}

class BookRemoteDataSourceImpl implements BookRemoteDataSource {
  final http.Client client;

  BookRemoteDataSourceImpl({required this.client});

  @override
  Future<BookDetailsModel> getBookDetail(String key) async {
    final response = await client.get(
      Uri.parse('$detailBookUrl$key.json'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return BookDetailsModel.fromJson(json.decode(response.body));
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
}
