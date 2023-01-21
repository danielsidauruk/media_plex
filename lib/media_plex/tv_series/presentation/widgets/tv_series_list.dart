import 'package:flutter/material.dart';
import 'package:media_plex/core/presentation/widgets/horizontal_card_list.dart';
import 'package:media_plex/core/utils/routes.dart';
import 'package:media_plex/media_plex/tv_series/domain/entities/tv_series.dart';

class TVSeriesList extends StatelessWidget {
  final List<TVSeries> list;

  const TVSeriesList({
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
          final tvSeries = list[index];
          return HorizontalCardList(
            posterPath: tvSeries.posterPath,
            onTap: () {
              Navigator.pushNamed(
                context,
                detailTVSeriesRoute,
                arguments: tvSeries.id,
              );
            },
          );
        },
        itemCount: list.length,
      ),
    );
  }
}
