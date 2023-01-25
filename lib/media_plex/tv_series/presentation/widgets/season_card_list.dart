import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:media_plex/core/styles/text_styles.dart';
import 'package:media_plex/media_plex/tv_series/domain/entities/season.dart';

class SeasonCard extends StatelessWidget {
  final Season item;

  const SeasonCard({
    Key? key,
    required this.item
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String year = item.airDate?.substring(0, 4) ?? '-';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: CachedNetworkImage(
              imageUrl: 'https://image.tmdb.org/t/p/w500${item.posterPath}',
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              width: 100.0,
              height: 70.0,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: kSubtitle,
              ),
              Text('${item.episodeCount} episodes'),
              const SizedBox(
                height: 4.0,
              ),
              Text(year),
            ],
          )
        ]),
      ),
    );
  }
}