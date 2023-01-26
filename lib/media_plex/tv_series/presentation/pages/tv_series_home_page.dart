import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:media_plex/core/utils/constants.dart';
import 'package:media_plex/core/utils/routes.dart';
import 'package:media_plex/media_plex/tv_series/domain/entities/tv_series.dart';
import 'package:media_plex/media_plex/tv_series/presentation/bloc/tv_series_on_air_bloc/tv_series_on_air_bloc.dart';
import 'package:media_plex/media_plex/tv_series/presentation/bloc/tv_series_popular_bloc/tv_series_popular_bloc.dart';
import 'package:media_plex/media_plex/tv_series/presentation/bloc/tv_series_top_rated_bloc/tv_series_top_rated_bloc.dart';
import 'package:media_plex/shared/presentation/widget/horizontal_loading_animation.dart';
import 'package:media_plex/shared/presentation/widget/search_tile.dart';
import 'package:media_plex/shared/presentation/widget/sub_heading_tile.dart';

class TVSeriesHomePage extends StatefulWidget {
  const TVSeriesHomePage({super.key});

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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: const AppDrawer(
      //   route: homeTVSeriesRoute,
      // ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'TV Series',
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SearchTile(
                context: context,
                title: 'Search your TV Series',
                routeName: searchTVSeriesRoute,
              ),

              onAirTile(context),

              popularTile(context),

              topRatedTile(context),
            ],
          ),
        ),
      ),
    );
  }

  Container onAirTile(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.all(8.0),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.white),
      ),
      child: Column(
        children: [

          SubHeadingTile(context: context, title: 'On Air TV Series', routeName: onAirTVSeriesRoute),

          BlocBuilder<TVSeriesOnAirBloc, TVSeriesOnAirState>(
            builder: (context, state) {
              if (state is TVSeriesOnAirLoading) {
                return const HorizontalLoadingAnimation();
              } else if (state is TVSeriesOnAirHasData) {
                final tvSeriesResult = state.result;
                return buildTVSeriesResult(tvSeriesResult);
              } else if (state is TVSeriesOnAirError) {
                return const Text('Failed');
              } else {
                return const Center();
              }
            },
          ),
        ],
      ),
    );
  }

  Container popularTile(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.all(8.0),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.white),
      ),
      child: Column(
        children: [

          SubHeadingTile(context: context, title: 'Popular TV Series', routeName: popularTVSeriesRoute),

          BlocBuilder<TVSeriesPopularBloc, TVSeriesPopularState>(
            builder: (context, state) {
              if (state is TVSeriesPopularLoading) {
                return const HorizontalLoadingAnimation();
              } else if (state is TVSeriesPopularHasData) {
                final tvSeriesResult = state.result;
                return buildTVSeriesResult(tvSeriesResult);
              } else if (state is TVSeriesOnAirError) {
                return const Text('Failed');
              } else {
                return const Center();
              }
            },
          ),
        ],
      ),
    );
  }

  Container topRatedTile(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.all(8.0),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.white),
      ),
      child: Column(
        children: [
          SubHeadingTile(context: context, title: 'Top Rated TV Series', routeName: topRatedTVSeriesRoute),

          BlocBuilder<TVSeriesTopRatedBloc, TVSeriesTopRatedState>(
            builder: (context, state) {
              if (state is TVSeriesTopRatedLoading) {
                return const HorizontalLoadingAnimation();
              } else if (state is TVSeriesTopRatedHasData) {
                final tvSeriesResult = state.result;
                return buildTVSeriesResult(tvSeriesResult);
              } else if (state is TVSeriesTopRatedError) {
                return const Text('Failed');
              } else {
                return const Center();
              }
            },
          ),
        ],
      ),
    );
  }

  SizedBox buildTVSeriesResult(List<TVSeries> tvSeriesResult) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => Navigator.pushNamed(
              context,
              detailTVSeriesRoute,
              arguments: tvSeriesResult[index].id,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: tvSeriesResult[index].posterPath != null ?
              CachedNetworkImage(
                width: 80,
                imageUrl: baseImageURL(tvSeriesResult[index].posterPath!),
                placeholder: (context, url) => Container(
                  width: 80,
                  height: 126,
                  color: Colors.grey,
                ),
                errorWidget: (context, url, error) => Image.asset(
                  'assets/images/not_applicable_icon.png',
                ),
              ) : const Center(),
            ),
          );
        },
      ),
    );
  }
}