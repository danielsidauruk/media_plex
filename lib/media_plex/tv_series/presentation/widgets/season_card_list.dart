import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:media_plex/core/utils/constants.dart';
import 'package:media_plex/media_plex/tv_series/domain/entities/season.dart';

class SeasonTile extends StatelessWidget {
  final Season item;
  const SeasonTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    String year = item.airDate?.substring(0, 4) ?? '-';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [

            item.posterPath != null ?
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: CachedNetworkImage(
                imageUrl: baseImageURL(item.posterPath!),
                placeholder: (context, url) => Container(
                  width: 100.0,
                  height: 70.0,
                  color: Colors.grey,
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                width: 100.0,
                height: 70.0,
                fit: BoxFit.cover,
              ),
            ) : const Center(),

            const SizedBox(width: 12.0),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: Theme.of(context).textTheme.subtitle1?.
                    copyWith(fontWeight: FontWeight.bold),
                  ),

                  Text('${item.episodeCount} episodes'),

                  Text(year),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}