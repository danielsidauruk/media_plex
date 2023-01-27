import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:media_plex/core/utils/routes.dart';
import 'package:media_plex/media_plex/tv_series/presentation/bloc/tv_series_on_air_bloc/tv_series_on_air_bloc.dart';
import 'package:media_plex/media_plex/tv_series/presentation/widgets/tv_series_list.dart';
import 'package:media_plex/shared/presentation/widget/loading_animation.dart';

class TVSeriesOnAirPage extends StatefulWidget {
  const TVSeriesOnAirPage({super.key});

  @override
  State<TVSeriesOnAirPage> createState() => _TVSeriesOnAirPageState();
}

class _TVSeriesOnAirPageState extends State<TVSeriesOnAirPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TVSeriesOnAirBloc>(context, listen: false)
        .add(FetchTVSeriesOnAir());
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
      child: BlocBuilder<TVSeriesOnAirBloc, TVSeriesOnAirState>(
        builder: (context, state) {
          if (state is TVSeriesOnAirLoading) {
            return const LoadingAnimation();
          } else if (state is TVSeriesOnAirHasData) {
            final tvSeriesResult = state.result;
            return TVSeriesList(
              list: tvSeriesResult,
              route: tvSeriesDetailRoute,
            );
          } else if (state is TVSeriesOnAirError) {
            return Center(
              key: const Key('error_message'),
              child: Text(state.message),
            );
          } else {
            return const Text('Failed');
          }
        },
      ),
    );
  }
}
