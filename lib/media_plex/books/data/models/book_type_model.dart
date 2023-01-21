import 'package:media_plex/media_plex/books/domain/entities/_book_type.dart';

class BookTypeModel extends BookType {
  const BookTypeModel({required super.key});

  factory BookTypeModel.fromJson(Map<String, dynamic> json) => BookTypeModel(
        key: json["key"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
      };
}
