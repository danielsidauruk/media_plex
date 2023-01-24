import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:media_plex/core/utils/constants.dart';
import 'package:media_plex/media_plex/movie/domain/entities/movie.dart';

class MovieList extends StatelessWidget {
  final List<Movie> movieResult;
  final String detailMovieRoute;

  const MovieList({
    super.key,
    required this.movieResult,
    required this.detailMovieRoute,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => Navigator.pushNamed(
                  context,
                  detailMovieRoute,
                  arguments: movieResult[index].id,
                ),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.white),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CachedNetworkImage(
                        width: 60,
                        fit: BoxFit.fill,
                        imageUrl: '$baseImageURL${movieResult[index].posterPath}',
                        placeholder: (context, url) => const Center(),
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/images/not_applicable_icon.png',
                        ),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  textAlign: TextAlign.start,
                                  '${movieResult[index].title}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),

                                movieResult[index].releaseDate != "" ?
                                Text(
                                  'Release in ${DateFormat("MMM d, yyyy").format(DateTime.parse(movieResult[index].releaseDate!))}',
                                  style: Theme.of(context).textTheme.subtitle2?.
                                  copyWith(fontWeight: FontWeight.bold, color: Colors.grey),
                                ) :
                                const Center(),

                                Text(
                                  'Vote Average : ${movieResult[index].voteAverage.toString()}',
                                  style: Theme.of(context).textTheme.subtitle2?.copyWith(
                                      fontWeight: FontWeight.bold, color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: movieResult.length,
          ),
        ),

        const SizedBox(height: 8),

        Align(
          alignment: Alignment.centerRight,
          child: Text(
            'Total result : ${movieResult.length.toString()}',
            style: Theme.of(context).textTheme.subtitle1?.
            copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
