import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:media_plex/core/utils/routes.dart';
import 'package:media_plex/media_plex/tv_series/presentation/bloc/tv_series_popular_bloc/tv_series_popular_bloc.dart';
import 'package:media_plex/media_plex/tv_series/presentation/widgets/tv_series_list.dart';
import 'package:media_plex/shared/presentation/widget/loading_animation.dart';

class TVSeriesPopularPage extends StatefulWidget {
  const TVSeriesPopularPage({super.key});

  @override
  State<TVSeriesPopularPage> createState() => _TVSeriesPopularPageState();
}

class _TVSeriesPopularPageState extends State<TVSeriesPopularPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TVSeriesPopularBloc>(context, listen: false)
        .add(FetchTVSeriesPopular());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Popular TV Series',
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
      child: BlocBuilder<TVSeriesPopularBloc, TVSeriesPopularState>(
        builder: (context, state) {
          if (state is TVSeriesPopularLoading) {
            return const LoadingAnimation();
          } else if (state is TVSeriesPopularHasData) {
            final tvSeriesResult = state.result;
            return TVSeriesList(
              list: tvSeriesResult,
              route: tvSeriesDetailRoute,
            );
          } else if (state is TVSeriesPopularError) {
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