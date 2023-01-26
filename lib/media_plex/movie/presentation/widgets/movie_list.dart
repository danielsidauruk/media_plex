import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:media_plex/core/utils/constants.dart';
import 'package:media_plex/core/utils/routes.dart';
import 'package:media_plex/media_plex/movie/domain/entities/movie.dart';

class MovieList extends StatelessWidget {
  final List<Movie> list;

  const MovieList({super.key, required this.list});

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
                  arguments: list[index].id,
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

                      list[index].posterPath != null ?
                      CachedNetworkImage(
                        width: 60,
                        fit: BoxFit.fill,
                        imageUrl: baseImageURL(list[index].posterPath!),
                        placeholder: (context, url) => const Center(),
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/images/not_applicable_icon.png',
                        ),
                      ) : const Center(),

                      const SizedBox(width: 8.0),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  textAlign: TextAlign.start,
                                  '${list[index].title}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),

                                list[index].releaseDate != "" || list[index].releaseDate != null ?
                                Text(
                                  'Release in ${DateFormat("MMM d, yyyy").format(DateTime.parse(list[index].releaseDate!))}',
                                  style: Theme.of(context).textTheme.subtitle2?.
                                  copyWith(fontWeight: FontWeight.bold, color: Colors.grey),
                                ) :
                                const Center(),

                                Text(
                                  'Vote Average : ${list[index].voteAverage.toString()}',
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
            itemCount: list.length,
          ),
        ),

        const SizedBox(height: 8),

        Align(
          alignment: Alignment.centerRight,
          child: Text(
            'Total result : ${list.length}',
            style: Theme.of(context).textTheme.subtitle1?.
            copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
