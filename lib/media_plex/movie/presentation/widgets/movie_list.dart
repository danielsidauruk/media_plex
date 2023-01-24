import 'package:flutter/material.dart';
import 'package:media_plex/core/presentation/widgets/horizontal_card_list.dart';
import 'package:media_plex/core/utils/routes.dart';
import 'package:media_plex/media_plex/movie/domain/entities/movie.dart';

class MovieList extends StatelessWidget {
  final List<Movie> list;

  const MovieList({
    Key? key,
    required this.list
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = list[index];
          return HorizontalCardList(
            posterPath: movie.posterPath,
            onTap: () {
              Navigator.pushNamed(
                context,
                detailMovieRoute,
                arguments: movie.id,
              );
            },
          );
        },
        itemCount: list.length,
      ),
    );
  }
}
