import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_plex/core/utils/routes.dart';
import 'package:media_plex/media_plex/books/presentation/widgets/loading_animation.dart';
import 'package:media_plex/media_plex/movie/presentation/bloc/movie_popular_bloc/movie_popular_bloc.dart';
import 'package:media_plex/media_plex/movie/presentation/widgets/movie_list.dart';

class PopularMoviesPage extends StatefulWidget {
  const PopularMoviesPage({super.key});

  @override
  State<PopularMoviesPage> createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
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
          'Popular',
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
      child: BlocBuilder<MoviePopularBloc, MoviePopularState>(
        builder: (context, state) {
          if (state is MoviePopularLoading) {
            return const LoadingAnimation(tileHeight: 100, totalTile: 5);
          } else if (state is MoviePopularHasData) {
            final movieResult = state.result;
            return MovieList(
              list: movieResult,
              route: detailMovieRoute,
            );
          } else if (state is MoviePopularError) {
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
