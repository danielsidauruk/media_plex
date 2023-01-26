import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:media_plex/core/utils/routes.dart';
import 'package:media_plex/media_plex/movie/presentation/pages/movie_detail_page.dart';
import 'package:media_plex/media_plex/tv_series/presentation/bloc/tv_series_detail_bloc/tv_series_detail_bloc.dart';
import 'package:media_plex/media_plex/tv_series/presentation/bloc/tv_series_recommendation_bloc/tv_series_recommendation_bloc.dart';
import 'package:media_plex/media_plex/tv_series/presentation/bloc/tv_series_watchlist_bloc/tv_series_watchlist_bloc.dart';
import 'package:media_plex/media_plex/tv_series/presentation/widgets/season_card_list.dart';
import 'package:media_plex/shared/domain/entities/genre.dart';

class TVSeriesDetailPage extends StatefulWidget {
  const TVSeriesDetailPage({super.key, required this.id});

  final int id;

  @override
  State<TVSeriesDetailPage> createState() => _TVSeriesDetailPageState();
}

class _TVSeriesDetailPageState extends State<TVSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<TVSeriesDetailBloc>(context, listen: false)
          .add(FetchTVSeriesDetail(widget.id));
      BlocProvider.of<TVSeriesWatchlistBloc>(context, listen: false)
          .add(LoadWatchlistTVSeriesStatus(widget.id));
      BlocProvider.of<TVSeriesRecommendationBloc>(context, listen: false)
          .add(FetchTVSeriesRecommendation(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TVSeriesDetailBloc, TVSeriesDetailState>(
        builder: (context, state) {
          if (state is TVSeriesDetailLoading) {
            return const DetailLoadingAnimation();
          } else if (state is TVSeriesDetailHasData) {
            final tvSeriesDetail = state.result;
            return SafeArea(
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: 'https://image.tmdb.org/t/p/w500${tvSeriesDetail.posterPath}',
                    width: double.infinity,
                    placeholder: (context, url) => Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.grey,
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/images/not_applicable_icon.png',
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 48 + 8),
                    child: DraggableScrollableSheet(
                      builder: (context, scrollController) {
                        return Container(
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                          ),
                          padding: const EdgeInsets.only(
                            left: 16,
                            top: 16,
                            right: 16,
                          ),
                          child: Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 16),
                                child: SingleChildScrollView(
                                  controller: scrollController,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        tvSeriesDetail.name,
                                        style: Theme.of(context).textTheme.bodyLarge
                                            ?.copyWith(fontWeight: FontWeight.bold),
                                      ),

                                      const SizedBox(height: 8.0),

                                      BlocConsumer<TVSeriesWatchlistBloc, TVSeriesWatchlistState>(
                                        listener: (context, state) {
                                          if (state is WatchlistSuccess) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text(state.message)));
                                          } else if (state is WatchlistFailure) {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  content: Text(state.message),
                                                );
                                              },
                                            );
                                          }
                                        },
                                        builder: (context, state) {
                                          return InkWell(
                                            onTap: () async {
                                              if (state is WatchlistHasData) {
                                                if (state.isAdded == false) {
                                                  context
                                                      .read<TVSeriesWatchlistBloc>()
                                                      .add(AddWatchlistTVSeries(tvSeriesDetail));
                                                } else if (state.isAdded == true) {
                                                  context
                                                      .read<TVSeriesWatchlistBloc>()
                                                      .add(DeleteWatchlistTVSeries(tvSeriesDetail));
                                                }
                                              }
                                            },
                                            child: Container(
                                              width: 110,
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8.0),
                                                border: Border.all(color: Colors.white),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  if (state is WatchlistHasData)
                                                    if (state.isAdded == false)
                                                      const Icon(Icons.add)
                                                    else if (state.isAdded == true)
                                                      const Icon(Icons.check),
                                                  const Text(
                                                    'Watchlist',
                                                    style: TextStyle(fontWeight: FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),

                                      const SizedBox(height: 8.0),

                                      Text(
                                        _showGenres(tvSeriesDetail.genres),
                                        style: Theme.of(context).textTheme.subtitle1?.
                                        copyWith(fontWeight: FontWeight.bold),
                                      ),

                                      const SizedBox(height: 2.0),

                                      IntrinsicHeight(
                                        child: Row(
                                          children: [
                                            Text(_showNumberOfSeasons(tvSeriesDetail.numberOfSeasons)),

                                            const Padding(
                                              padding: EdgeInsets.all(2.0),
                                              child: VerticalDivider(
                                                thickness: 1,
                                                color: Colors.grey,
                                              ),
                                            ),

                                            tvSeriesDetail.episodeRunTime.isNotEmpty ?
                                            Text(_showDuration(tvSeriesDetail.episodeRunTime[0])) :
                                            const Center(),
                                          ],
                                        ),
                                      ),

                                      const SizedBox(height: 2.0),

                                      Row(
                                        children: [
                                          RatingBarIndicator(
                                            rating: tvSeriesDetail.voteAverage / 2,
                                            itemCount: 5,
                                            itemBuilder: (context, index) =>
                                            const Icon(
                                              Icons.star,
                                              color: Colors.yellow,
                                            ),
                                            itemSize: 24,
                                          ),
                                          Text(
                                            '${tvSeriesDetail.voteAverage}',
                                            style: Theme.of(context).textTheme.subtitle2?.
                                            copyWith(fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),

                                      const SizedBox(height: 8),

                                      Text(
                                        'Overview',
                                        style: Theme.of(context).textTheme.subtitle1?.
                                        copyWith(fontWeight: FontWeight.bold),
                                      ),

                                      Text(tvSeriesDetail.overview),

                                      const SizedBox(height: 16),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                "Total ${_episode(tvSeriesDetail.numberOfEpisodes)}",
                                                style: Theme.of(context).textTheme.subtitle1?.
                                                copyWith(fontWeight: FontWeight.bold),
                                              ),

                                              Text(
                                                (tvSeriesDetail.numberOfEpisodes).toString(),
                                                style: Theme.of(context).textTheme.subtitle2?.
                                                copyWith(fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                "Total ${_season(tvSeriesDetail.numberOfSeasons)}",
                                                style: Theme.of(context).textTheme.subtitle1?.
                                                copyWith(fontWeight: FontWeight.bold),
                                              ),

                                              Text((tvSeriesDetail.numberOfSeasons).toString(),
                                                style: Theme.of(context).textTheme.subtitle2?.
                                                copyWith(fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 16),

                                      ListView.builder(
                                        itemBuilder: (context, index) {
                                          final season = tvSeriesDetail.seasons[index];
                                          return SeasonTile(item: season);
                                        },
                                        shrinkWrap: true,
                                        itemCount: tvSeriesDetail.seasons.length,
                                        physics: const NeverScrollableScrollPhysics(),
                                      ),

                                      const SizedBox(height: 8),

                                      Text(
                                        'Recommendations',
                                        style: Theme.of(context).textTheme.subtitle1?.
                                        copyWith(fontWeight: FontWeight.bold),
                                      ),

                                      BlocBuilder<TVSeriesRecommendationBloc,
                                          TVSeriesRecommendationState>(
                                        builder: (context, state) {
                                          if (state is TVSeriesRecommendationLoading) {
                                            return const Center(
                                              child: CircularProgressIndicator(),
                                            );
                                          } else if (state
                                          is TVSeriesRecommendationError) {
                                            return Text(state.message);
                                          } else if (state
                                          is TVSeriesRecommendationHasData) {
                                            return SizedBox(
                                              height: 150,
                                              child: ListView.builder(
                                                scrollDirection: Axis.horizontal,
                                                itemBuilder: (context, index) {
                                                  final recommendations =
                                                  state.result[index];
                                                  return Padding(
                                                    padding: const EdgeInsets.all(4.0),
                                                    child: InkWell(
                                                      onTap: () {
                                                        Navigator.pushReplacementNamed(
                                                          context,
                                                          detailTVSeriesRoute,
                                                          arguments: recommendations.id,
                                                        );
                                                      },
                                                      child: ClipRRect(
                                                        borderRadius:
                                                        const BorderRadius.all(
                                                          Radius.circular(8),
                                                        ),
                                                        child: CachedNetworkImage(
                                                          imageUrl:
                                                          'https://image.tmdb.org/t/p/w500${recommendations.posterPath}',
                                                          placeholder: (context, url) =>
                                                          const Center(
                                                            child:
                                                            CircularProgressIndicator(),
                                                          ),
                                                          errorWidget:
                                                              (context, url, error) =>
                                                          const Icon(Icons.error),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                itemCount: state.result.length,
                                              ),
                                            );
                                          } else {
                                            return Container();
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  color: Colors.white,
                                  height: 4,
                                  width: 48,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      minChildSize: 0.25,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            );
          } else if (state is TVSeriesDetailError) {
            return Text(state.message);
          } else {
            return Container();
          }
        },
      ),
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }
    if (result.isEmpty) {
      return result;
    }
    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  String _showNumberOfSeasons(int total) {
    return '$total ${total > 1 ? 'seasons' : 'season'}';
  }

  String _season(int season){
    return season > 1 ? 'seasons' : 'season';
  }

  String _episode(int episode){
    return episode > 1 ? 'episodes' : 'episode';
  }
}