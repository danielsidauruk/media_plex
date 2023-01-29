import 'package:equatable/equatable.dart';
import 'package:media_plex/media_plex/books/domain/entities/book_detail.dart';

class BookTableModel extends Equatable {
  final String key;
  final String title;

  const BookTableModel({
    required this.key,
    required this.title,
  });

  factory BookTableModel.fromEntity(BookDetail book) => BookTableModel(
    key: book.key,
    title: book.title,
  );

  factory BookTableModel.fromMap(Map<String, dynamic> map) => BookTableModel(
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