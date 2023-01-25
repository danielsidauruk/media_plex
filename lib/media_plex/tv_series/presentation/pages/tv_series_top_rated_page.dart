import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:media_plex/core/utils/routes.dart';
import 'package:media_plex/media_plex/books/presentation/widgets/loading_animation.dart';
import 'package:media_plex/media_plex/tv_series/presentation/bloc/tv_series_top_rated_bloc/tv_series_top_rated_bloc.dart';
import 'package:media_plex/media_plex/tv_series/presentation/widgets/tv_series_card_list.dart';
import 'package:media_plex/media_plex/tv_series/presentation/widgets/tv_series_list.dart';

class TVSeriesTopRatedPage extends StatefulWidget {
  const TVSeriesTopRatedPage({super.key});


  @override
  State<TVSeriesTopRatedPage> createState() => _TVSeriesTopRatedPageState();
}

class _TVSeriesTopRatedPageState extends State<TVSeriesTopRatedPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TVSeriesTopRatedBloc>(context, listen: false)
        .add(FetchTVSeriesTopRated());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'On Air TV Series',
          style: Theme.of(context).textTheme.bodyText1
              ?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),

      body: buildBody(),
    );
  }

  Padding buildBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<TVSeriesTopRatedBloc, TVSeriesTopRatedState>(
        builder: (context, state) {
          if (state is TVSeriesTopRatedLoading) {
            return const LoadingAnimation(tileHeight: 100, totalTile: 6);
          } else if (state is TVSeriesTopRatedHasData) {
            final tvSeriesResult = state.result;
            return TVSeriesList(
              list: tvSeriesResult,
              route: detailTVSeriesRoute,
            );
          } else if (state is TVSeriesTopRatedError) {
            return Center(
              key: const Key('error_message'),
              child: Text(state.message),
            );
          } else {
            return const Center();
          }
        },
      ),
    );
  }
}
