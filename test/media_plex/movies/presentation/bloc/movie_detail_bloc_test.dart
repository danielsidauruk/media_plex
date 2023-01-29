import 'package:flutter_test/flutter_test.dart';
import 'package:media_plex/media_plex/movie/domain/usecases/get_movie_detail.dart';
import 'package:media_plex/media_plex/movie/presentation/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:mockito/annotations.dart';

import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail])
void main() {
  late MockGetMovieDetail mockGetMovieDetail;
  late MovieDetailBloc movieDetailBloc;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    movieDetailBloc = MovieDetailBloc(mockGetMovieDetail);
  });

  const tId = 1;

  test('initial state should be Empty', () {
    expect(movieDetailBloc.state, MovieDetailEmpty());
  });


}