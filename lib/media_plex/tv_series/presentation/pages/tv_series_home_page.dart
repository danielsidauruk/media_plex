import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:media_plex/core/presentation/widgets/app_drawer.dart';
import 'package:media_plex/core/presentation/widgets/sub_heading.dart';
import 'package:media_plex/core/utils/constants.dart';
import 'package:media_plex/core/utils/routes.dart';
import 'package:media_plex/media_plex/books/presentation/widgets/horizontal_loading_animation.dart';
import 'package:media_plex/media_plex/tv_series/domain/entities/tv_series.dart';
import 'package:media_plex/media_plex/tv_series/presentation/bloc/tv_series_on_air_bloc/tv_series_on_air_bloc.dart';
import 'package:media_plex/media_plex/tv_series/presentation/bloc/tv_series_popular_bloc/tv_series_popular_bloc.dart';
import 'package:media_plex/media_plex/tv_series/presentation/bloc/tv_series_top_rated_bloc/tv_series_top_rated_bloc.dart';
import 'package:media_plex/media_plex/tv_series/presentation/widgets/tv_series_list.dart';

import '../../../../core/widget/searchTile.dart';

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

              SearchTile(context: context, title: 'Search your TV Series', routeName: searchTVSeriesRoute),

              Container(
                margin: const EdgeInsets.all(4.0),
                padding: const EdgeInsets.all(8.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.white),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'On Air TV Series',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                          onTap: () =>
                              Navigator.pushNamed(context, onAirTVSeriesRoute),
                          child: const Icon(Icons.arrow_forward),
                        ),
                      ],
                    ),
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
              ),

              Container(
                margin: const EdgeInsets.all(4.0),
                padding: const EdgeInsets.all(8.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.white),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Popular TV Series',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                          onTap: () =>
                              Navigator.pushNamed(context, popularTVSeriesRoute),
                          child: const Icon(Icons.arrow_forward),
                        ),
                      ],
                    ),
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
              ),

              Container(
                margin: const EdgeInsets.all(4.0),
                padding: const EdgeInsets.all(8.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.white),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Top Rated TV Series',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                          onTap: () =>
                              Navigator.pushNamed(context, popularTVSeriesRoute),
                          child: const Icon(Icons.arrow_forward),
                        ),
                      ],
                    ),
                    BlocBuilder<TVSeriesTopRatedBloc, TVSeriesTopRatedState>(
                      builder: (context, state) {
                        if (state is TVSeriesTopRatedLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
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
              ),
            ],
          ),
        ),
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
              child: CachedNetworkImage(
                width: 80,
                imageUrl: '$baseImageURL${tvSeriesResult[index].posterPath}',
                placeholder: (context, url) => Container(
                  width: 80,
                  height: 126,
                  color: Colors.grey,
                ),
                errorWidget: (context, url, error) => Image.asset(
                  'assets/images/not_applicable_icon.png',
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
