import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:media_plex/media_plex/movie/presentation/bloc/search_the_movie_bloc/search_the_movie_bloc.dart';
import 'package:media_plex/media_plex/movie/presentation/widgets/movie_list.dart';
import 'package:media_plex/shared/presentation/widget/loading_animation.dart';

class SearchTheMoviePage extends StatelessWidget {
  const SearchTheMoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Search Movies',
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: buildBody(context),
    );
  }

  Padding buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            'Search movies by title :',
            style: Theme.of(context).textTheme.subtitle1
                ?.copyWith(fontWeight: FontWeight.bold),
          ),

          searchTile(context),

          buildBloc(),
        ],
      ),
    );
  }

  Expanded buildBloc() {
    return Expanded(
      child: BlocBuilder<SearchTheMovieBloc, SearchTheMovieState>(
        builder: (context, state) {
          if (state is SearchTheMovieLoading) {
            return const LoadingAnimation();
          } else if (state is SearchTheMovieHasData) {
            final movieResult = state.result;
            return MovieList(list: movieResult);
          } else if (state is SearchTheMovieError) {
            return const Center();
          } else {
            return const Center();
          }
        },
      ),
    );
  }

  Container searchTile(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(8.0),
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.white),
      ),
      child: TextField(
        onChanged: (query) =>
            context.read<SearchTheMovieBloc>().add(OnQueryChanged(query)),
        style: const TextStyle(),
        decoration: null,
      ),
    );
  }
}