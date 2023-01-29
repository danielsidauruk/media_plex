import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:media_plex/media_plex/movie/presentation/bloc/top_rated_movies_bloc/movie_top_rated_bloc.dart';
import 'package:media_plex/media_plex/movie/presentation/widgets/movie_list.dart';
import 'package:media_plex/shared/presentation/widget/loading_animation.dart';

class TopRatedMoviesPage extends StatefulWidget {
  const TopRatedMoviesPage({super.key});

  @override
  State<TopRatedMoviesPage> createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TopRatedMoviesBloc>(context, listen: false)
        .add(FetchTopRatedMovies());
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
      child: BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
        builder: (context, state) {
          if (state is TopRatedMoviesLoading) {
            return const LoadingAnimation();
          } else if (state is TopRatedMoviesHasData) {
            final movieResult = state.result;
            return MovieList(list: movieResult);
          } else if (state is TopRatedMoviesError) {
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
