import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:media_plex/media_plex/movie/presentation/bloc/movie_top_rated_bloc/movie_top_rated_bloc.dart';
import 'package:media_plex/media_plex/movie/presentation/widgets/movie_list.dart';
import 'package:media_plex/shared/presentation/widget/loading_animation.dart';

class MovieTopRatedPage extends StatefulWidget {
  const MovieTopRatedPage({super.key});

  @override
  State<MovieTopRatedPage> createState() => _MovieTopRatedPageState();
}

class _MovieTopRatedPageState extends State<MovieTopRatedPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MovieTopRatedBloc>(context, listen: false)
        .add(FetchMovieTopRated());
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
      child: BlocBuilder<MovieTopRatedBloc, MovieTopRatedState>(
        builder: (context, state) {
          if (state is MovieTopRatedLoading) {
            return const LoadingAnimation();
          } else if (state is MovieTopRatedHasData) {
            final movieResult = state.result;
            return MovieList(list: movieResult);
          } else if (state is MovieTopRatedError) {
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
