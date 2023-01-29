import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:media_plex/core/utils/constants.dart';
import 'package:media_plex/core/utils/routes.dart';
import 'package:media_plex/media_plex/movie/domain/entities/movie.dart';
import 'package:media_plex/media_plex/movie/presentation/bloc/now_playing_movies_bloc/now_playing_movies_bloc.dart';
import 'package:media_plex/media_plex/movie/presentation/bloc/popular_movies_bloc/movie_popular_bloc.dart';
import 'package:media_plex/media_plex/movie/presentation/bloc/top_rated_movies_bloc/movie_top_rated_bloc.dart';
import 'package:media_plex/shared/presentation/widget/horizontal_loading_animation.dart';
import 'package:media_plex/shared/presentation/widget/search_tile.dart';
import 'package:media_plex/shared/presentation/widget/sub_heading_tile.dart';

class MovieHomePage extends StatefulWidget {
  const MovieHomePage({super.key});

  @override
  State<MovieHomePage> createState() => _MovieHomePageState();
}

class _MovieHomePageState extends State<MovieHomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<NowPlayingMoviesBloc>(context, listen: false)
          .add(FetchNowPlayingMovies());
      BlocProvider.of<TopRatedMoviesBloc>(context, listen: false)
          .add(FetchTopRatedMovies());
      BlocProvider.of<PopularMoviesBloc>(context, listen: false)
          .add(FetchPopularMovies());
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
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, repositoryRoute),
            icon: const Icon(Icons.bookmark_border),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              SearchTile(
                context: context,
                title: 'Search your Movie',
                routeName: movieSearchRoute,
              ),

              nowPlayingTile(context),

              popularTile(context),

              topRatedTile(context),

            ],
          ),
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

          SubHeadingTile(context: context, title: 'Now Playing Movies', routeName: movieNowPlayingRoute),

          BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(
            builder: (context, state) {
              if (state is NowPlayingMoviesLoading) {
                return const HorizontalLoadingAnimation();
              } else if (state is NowPlayingMoviesHasData) {
                final movieResult = state.result;
                return buildMovieResult(movieResult);
              } else if (state is NowPlayingMoviesError) {
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

          SubHeadingTile(context: context, title: 'Popular Movies', routeName: moviePopularRoute),

          BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
              builder: (context, state) {
                if (state is PopularMoviesLoading) {
                  return const HorizontalLoadingAnimation();
                } else if (state is PopularMoviesHasData) {
                  final movieResult = state.result;
                  return buildMovieResult(movieResult);
                } else if (state is PopularMoviesError) {
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

          SubHeadingTile(context: context, title: 'Top Rated Movies', routeName: movieTopRatedRoute),

          BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
            builder: (context, state) {
              if (state is TopRatedMoviesLoading) {
                return const HorizontalLoadingAnimation();
              } else if (state is TopRatedMoviesHasData) {
                final movieResult = state.result;
                return buildMovieResult(movieResult);
              } else if (state is TopRatedMoviesError) {
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
              movieDetailRoute,
              arguments: movieResult[index].id,
            ),
            child: movieResult[index].posterPath != null ?
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CachedNetworkImage(
                width: 80,
                imageUrl: baseImageURL(movieResult[index].posterPath!),
                placeholder: (context, url) => Container(
                  width: 80,
                  height: 126,
                  color: Colors.grey,
                ),
                errorWidget: (context, url, error) => Image.asset(
                  'assets/images/not_applicable_icon.png',
                ),
              ),
            ) : const Center(),
          );
        },
      ),
    );
  }
}
