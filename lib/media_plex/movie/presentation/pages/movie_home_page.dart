import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/app_drawer.dart';
import '../../../../core/presentation/widgets/sub_heading.dart';
import '../../../../core/styles/text_styles.dart';
import '../../../../core/utils/routes.dart';
import '../bloc/movie_now_playing_bloc/movie_now_playing_bloc.dart';
import '../bloc/movie_popular_bloc/movie_popular_bloc.dart';
import '../bloc/movie_top_rated_bloc/movie_top_rated_bloc.dart';
import '../widgets/movie_list.dart';

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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(
        route: homeMovieRoute,
      ),
      appBar: AppBar(
        title: const Text('Ditonton | Movie'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white,),
            onPressed: () => Navigator.pushNamed(context, searchMovieRoute),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<MovieNowPlayingBloc, MovieNowPlayingState>(
                  builder: (context, state) {
                    if (state is MovieNowPlayingLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is MovieNowPlayingHasData) {
                      final nowPlayingList = state.result;
                      return MovieList(list: nowPlayingList);
                    } else if (state is MovieNowPlayingError) {
                      return Text(state.message);
                    } else {
                      return const Center();
                    }
                  }),
              SubHeading(
                title: 'Popular Movie',
                onTap: () =>
                    Navigator.pushNamed(context, popularMovieRoute),
              ),
              BlocBuilder<MoviePopularBloc, MoviePopularState>(
                  builder: (context, state) {
                    if (state is MovieNowPlayingLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is MoviePopularHasData) {
                      final popularList = state.result;
                      return MovieList(list: popularList);
                    } else if (state is MoviePopularError) {
                      return Text(state.message);
                    } else {
                      return const Center();
                    }
                  }),
              SubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, topRatedMovieRoute),
              ),
              BlocBuilder<MovieTopRatedBloc, MovieTopRatedState>(
                  builder: (context, state) {
                    if (state is MovieTopRatedLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is MovieTopRatedHasData) {
                      final topRatedList = state.result;
                      return MovieList(list: topRatedList);
                    } else if (state is MovieTopRatedError) {
                      return Text(state.message);
                    } else {
                      return const Center();
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
