// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';
// import 'package:media_plex/core/failure.dart';
// import 'package:media_plex/core/use_case.dart';
// import 'package:media_plex/media_plex/books/domain/entities/author.dart';
// import 'package:media_plex/media_plex/books/domain/repositories/books_repository.dart';
//
// class GetAuthor extends UseCase<Author, Params>{
//   LibraryBookRepository repository;
//
//   GetAuthor({required this.repository});
//
//   @override
//   Future<Either<Failure, Author>> call(Params params) async {
//     return await repository.getAuthor(params.author);
//   }
// }
//
// class Params extends Equatable {
//   const Params({required this.author});
//   final String author;
//
//   @override
//   List<Object?> get props => [author];
// }