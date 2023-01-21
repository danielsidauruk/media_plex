import 'package:dartz/dartz.dart';
import 'package:media_plex/media_plex/books/domain/use_cases/get_book_details.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_object/dummy_object.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockLibraryBookRepository mockLibraryBookRepository;
  late GetBookDetails getBookDetails;

  setUp(() {
    mockLibraryBookRepository = MockLibraryBookRepository();
    getBookDetails = GetBookDetails(repository: mockLibraryBookRepository);
  });

  const tQuery = 'query';

  test('should get bookDetails for the book from the repository', () async {
    // arrange
    when(mockLibraryBookRepository.getBookDetail(any))
        .thenAnswer((_) async => Right(tBookDetails));
    // act
    final result = await getBookDetails(const Params(key: tQuery));
    // assert
    expect(result, Right(tBookDetails));
    // verify that the method has been called on the Repository
    verify(mockLibraryBookRepository.getBookDetail(tQuery));
    // Only the above method should be called and nothing more.
    verifyNoMoreInteractions(mockLibraryBookRepository);
  });
}
