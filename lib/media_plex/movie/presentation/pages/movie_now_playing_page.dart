import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_plex/core/utils/routes.dart';
import 'package:media_plex/media_plex/books/presentation/widgets/loading_animation.dart';
import 'package:media_plex/media_plex/movie/presentation/bloc/movie_now_playing_bloc/movie_now_playing_bloc.dart';
import 'package:media_plex/media_plex/movie/presentation/bloc/movie_popular_bloc/movie_popular_bloc.dart';
import 'package:media_plex/media_plex/movie/presentation/widgets/movie_list.dart';

class MovieNowPlayingPage extends StatefulWidget {
  static const routeName = '/nowPlayingMovieRoute';
  const MovieNowPlayingPage({super.key});

  @override
  State<MovieNowPlayingPage> createState() => _MovieNowPlayingPageState();
}

class _MovieNowPlayingPageState extends State<MovieNowPlayingPage> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MoviePopularBloc>(context, listen: false)
        .add(FetchMoviePopular());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Now Playing Movies',
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
      child: BlocBuilder<MovieNowPlayingBloc, MovieNowPlayingState>(
        builder: (context, state) {
          if (state is MovieNowPlayingLoading) {
            return const LoadingAnimation(tileHeight: 100, totalTile: 6);
          } else if (state is MovieNowPlayingHasData) {
            final movieResult = state.result;
            return MovieList(
              list: movieResult,
              route: detailMovieRoute,
            );
          } else if (state is MovieNowPlayingError) {
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
