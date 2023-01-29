import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_plex/media_plex/movie/presentation/bloc/now_playing_movies_bloc/now_playing_movies_bloc.dart';
import 'package:media_plex/media_plex/movie/presentation/bloc/popular_movies_bloc/movie_popular_bloc.dart';
import 'package:media_plex/media_plex/movie/presentation/widgets/movie_list.dart';
import 'package:media_plex/shared/presentation/widget/loading_animation.dart';

class MovieNowPlayingPage extends StatefulWidget {
  const MovieNowPlayingPage({super.key});

  @override
  State<MovieNowPlayingPage> createState() => _MovieNowPlayingPageState();
}

class _MovieNowPlayingPageState extends State<MovieNowPlayingPage> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PopularMoviesBloc>(context, listen: false)
        .add(FetchPopularMovies());
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
      child: BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(
        builder: (context, state) {
          if (state is NowPlayingMoviesLoading) {
            return const LoadingAnimation();
          } else if (state is NowPlayingMoviesHasData) {
            final movieResult = state.result;
            return MovieList(list: movieResult);
          } else if (state is NowPlayingMoviesError) {
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
