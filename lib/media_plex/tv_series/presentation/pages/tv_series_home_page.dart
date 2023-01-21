import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:media_plex/core/presentation/widgets/app_drawer.dart';
import 'package:media_plex/core/presentation/widgets/sub_heading.dart';
import 'package:media_plex/core/utils/routes.dart';
import 'package:media_plex/media_plex/tv_series/presentation/bloc/tv_series_on_air_bloc/tv_series_on_air_bloc.dart';
import 'package:media_plex/media_plex/tv_series/presentation/bloc/tv_series_popular_bloc/tv_series_popular_bloc.dart';
import 'package:media_plex/media_plex/tv_series/presentation/bloc/tv_series_top_rated_bloc/tv_series_top_rated_bloc.dart';
import 'package:media_plex/media_plex/tv_series/presentation/widgets/tv_series_list.dart';

class TVSeriesHomePage extends StatefulWidget {
  const TVSeriesHomePage({Key? key}) : super(key: key);

  @override
  State<TVSeriesHomePage> createState() => _TVSeriesHomePageState();
}

class _TVSeriesHomePageState extends State<TVSeriesHomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<TVSeriesOnAirBloc>(context, listen: false)
          .add(FetchTVSeriesOnAir());
      BlocProvider.of<TVSeriesTopRatedBloc>(context, listen: false)
          .add(FetchTVSeriesTopRated());
      BlocProvider.of<TVSeriesPopularBloc>(context, listen: false)
          .add(FetchTVSeriesPopular());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(
        route: homeTVSeriesRoute,
      ),
      appBar: AppBar(
        title: const Text('Ditonton | TV Series'),
        actions: [
          IconButton(
            onPressed: () {
              // FirebaseCrashlytics.instance.crash();
              Navigator.pushNamed(context, searchTVSeriesRoute);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SubHeading(
                title: 'On Air TV Series',
                onTap: () => Navigator.pushNamed(context, onAirTVSeriesRoute),
              ),
              BlocBuilder<TVSeriesOnAirBloc, TVSeriesOnAirState>(
                  builder: (context, state) {
                if (state is TVSeriesOnAirLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TVSeriesOnAirHasData) {
                  final onAirList = state.result;
                  return TVSeriesList(list: onAirList);
                } else if (state is TVSeriesOnAirError) {
                  return const Text('Failed');
                } else {
                  return const Center();
                }
              }),
              SubHeading(
                title: 'Popular TV Series',
                onTap: () => Navigator.pushNamed(context, popularTVSeriesRoute),
              ),
              BlocBuilder<TVSeriesPopularBloc, TVSeriesPopularState>(
                  builder: (context, state) {
                if (state is TVSeriesPopularLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TVSeriesPopularHasData) {
                  final popularList = state.result;
                  return TVSeriesList(list: popularList);
                } else if (state is TVSeriesOnAirError) {
                  return const Text('Failed');
                } else {
                  return const Center();
                }
              }),
              SubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, topRatedTVSeriesRoute),
              ),
              BlocBuilder<TVSeriesTopRatedBloc, TVSeriesTopRatedState>(
                  builder: (context, state) {
                if (state is TVSeriesTopRatedLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TVSeriesTopRatedHasData) {
                  final topRatedList = state.result;
                  return TVSeriesList(list: topRatedList);
                } else if (state is TVSeriesTopRatedError) {
                  return const Text('Failed');
                } else {
                  return const Center();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
