import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_plex/media_plex/movie/presentation/bloc/popular_movies_bloc/movie_popular_bloc.dart';
import 'package:media_plex/media_plex/movie/presentation/widgets/movie_list.dart';
import 'package:media_plex/shared/presentation/widget/loading_animation.dart';

class PopularMoviesPage extends StatefulWidget {
  const PopularMoviesPage({super.key});

  @override
  State<PopularMoviesPage> createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PopularMoviesBloc>(context, listen: false)
        .add(FetchPopularMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Popular'),

      body: buildBody(),
    );
  }

  AppBar buildAppBar(BuildContext context, String title) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyText1
            ?.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
    );
  }

  Padding buildBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
        builder: (context, state) {
          if (state is PopularMoviesLoading) {
            return const LoadingAnimation();
          } else if (state is PopularMoviesHasData) {
            final movieResult = state.result;
            return MovieList(list: movieResult);
          } else if (state is PopularMoviesError) {
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
