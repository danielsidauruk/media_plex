import 'package:equatable/equatable.dart';
import 'package:media_plex/media_plex/books/domain/entities/book_detail.dart';

class BookTable extends Equatable {
  final String key;
  final String title;

  const BookTable({
    required this.key,
    required this.title,
  });

  factory BookTable.fromEntity(BookDetail book) => BookTable(
    key: book.key,
    title: book.title,
  );

  factory BookTable.fromMap(Map<String, dynamic> map) => BookTable(
    key: map['key'],
    title: map['title'],
  );

  Map<String, dynamic> toJson() => {
    'key': key,
    'title': title,
  };

  @override
  List<Object?> get props => [key, title];
}