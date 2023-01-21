import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/horizontal_card_list.dart';
import '../../../../core/utils/routes.dart';
import '../../domain/entities/movie.dart';

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
