import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:media_plex/core/utils/constants.dart';
import 'package:media_plex/core/utils/routes.dart';
import 'package:media_plex/core/widget/searchTile.dart';
import 'package:media_plex/media_plex/books/presentation/widgets/horizontal_loading_animation.dart';
import 'package:media_plex/media_plex/movie/domain/entities/movie.dart';
import 'package:media_plex/media_plex/movie/presentation/bloc/movie_now_playing_bloc/movie_now_playing_bloc.dart';
import 'package:media_plex/media_plex/movie/presentation/bloc/movie_popular_bloc/movie_popular_bloc.dart';
import 'package:media_plex/media_plex/movie/presentation/bloc/movie_top_rated_bloc/movie_top_rated_bloc.dart';
import 'package:media_plex/media_plex/movie/presentation/pages/movie_now_playing_page.dart';

class MovieHomePage extends StatefulWidget {
  static const routeName = '/movieHomePageRoute';
  const MovieHomePage({super.key});

  @override
  State<MovieHomePage> createState() => _MovieHomePageState();
}

class _MovieHomePageState extends State<MovieHomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<MovieNowPlayingBloc>(context, listen: false)
          .add(FetchMovieNowPlaying());
      BlocProvider.of<MovieTopRatedBloc>(context, listen: false)
          .add(FetchMovieTopRated());
      BlocProvider.of<MoviePopularBloc>(context, listen: false)
          .add(FetchMoviePopular());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Movies',
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [

            SearchTile(
              context: context,
              title: 'Search your Movie',
              routeName: searchMovieRoute,
            ),

            nowPlayingTile(context),

            popularTile(context),

            topRatedTile(context),

          ],
        ),
      ),
    );
  }

  Container nowPlayingTile(BuildContext context) {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Now Playing Movies',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () =>
                    Navigator.pushNamed(context, MovieNowPlayingPage.routeName),
                child: const Icon(Icons.arrow_forward),
              ),
            ],
          ),
          BlocBuilder<MovieNowPlayingBloc, MovieNowPlayingState>(
            builder: (context, state) {
              if (state is MovieNowPlayingLoading) {
                return const HorizontalLoadingAnimation();
              } else if (state is MovieNowPlayingHasData) {
                final movieResult = state.result;
                return buildMovieResult(movieResult);
              } else if (state is MovieNowPlayingError) {
                return Text(state.message);
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Popular Movies',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () =>
                    Navigator.pushNamed(context, popularMovieRoute),
                child: const Icon(Icons.arrow_forward),
              ),
            ],
          ),

          BlocBuilder<MoviePopularBloc, MoviePopularState>(
              builder: (context, state) {
                if (state is MovieNowPlayingLoading) {
                  return const HorizontalLoadingAnimation();
                } else if (state is MoviePopularHasData) {
                  final movieResult = state.result;
                  return buildMovieResult(movieResult);
                } else if (state is MoviePopularError) {
                  return Text(state.message);
                } else {
                  return const Center();
                }
              }),

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Top Rated Movies',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () =>
                    Navigator.pushNamed(context, topRatedMovieRoute),
                child: const Icon(Icons.arrow_forward),
              ),
            ],
          ),

          BlocBuilder<MovieTopRatedBloc, MovieTopRatedState>(
            builder: (context, state) {
              if (state is MovieTopRatedLoading) {
                return const HorizontalLoadingAnimation();
              } else if (state is MovieTopRatedHasData) {
                final movieResult = state.result;
                return buildMovieResult(movieResult);
              } else if (state is MovieTopRatedError) {
                return Text(state.message);
              } else {
                return const Center();
              }
            },
          ),
        ],
      ),
    );
  }

  SizedBox buildMovieResult(List<Movie> movieResult) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => Navigator.pushNamed(
              context,
              detailMovieRoute,
              arguments: movieResult[index].id,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CachedNetworkImage(
                width: 80,
                imageUrl: '$baseImageURL${movieResult[index].posterPath}',
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
