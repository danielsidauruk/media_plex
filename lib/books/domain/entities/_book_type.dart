import 'package:equatable/equatable.dart';

class BookType extends Equatable{
  const BookType({
    required this.key,
  });

  final String key;

  @override
  List<Object?> get props => [key];
}