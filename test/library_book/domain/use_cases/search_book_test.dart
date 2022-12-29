import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:media_plex/books/domain/use_cases/search_book.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_object/dummy_object.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockLibraryBookRepository mockLibraryBookRepository;
  late SearchBook searchBook;

  setUp(() {
    mockLibraryBookRepository = MockLibraryBookRepository();
    searchBook = SearchBook(repository: mockLibraryBookRepository);
  });

  const tQuery = 'query';

  test('should searchBook from the repository', () async {
    // arrange
    when(mockLibraryBookRepository.searchBooks(any))
        .thenAnswer((_) async => Right(tSearch));
    // act
    final result = await searchBook(const Params(query: tQuery));
    // assert
    expect(result, Right(tSearch));
    // verify that the method has been called on the Repository
    verify(mockLibraryBookRepository.searchBooks(tQuery));
    // Only the above method should be called and nothing more.
    verifyNoMoreInteractions(mockLibraryBookRepository);
  });
}
