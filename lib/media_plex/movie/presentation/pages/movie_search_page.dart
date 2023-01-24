import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:media_plex/core/utils/routes.dart';
import 'package:media_plex/media_plex/books/presentation/widgets/loading_animation.dart';
import 'package:media_plex/media_plex/movie/presentation/bloc/movie_search_bloc/search_bloc.dart';
import 'package:media_plex/media_plex/movie/presentation/widgets/movie_list.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

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
            style: Theme.of(context)
                .textTheme
                .subtitle1
                ?.copyWith(fontWeight: FontWeight.bold),
          ),

          buildSearchBar(context),

          buildBloc(),
        ],
      ),
    );
  }

  Expanded buildBloc() {
    return Expanded(
      child: BlocBuilder<SearchMoviesBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchLoading) {
            return const LoadingAnimation(tileHeight: 80, totalTile: 5);
          } else if (state is SearchHasData) {
            final movieResult = state.result;
            try {
              return MovieList(
                movieResult: movieResult,
                detailMovieRoute: detailMovieRoute,
              );
            } catch(e) {
              return const Center();
            }
          } else if (state is SearchError) {
            if (kDebugMode) {
              print(state.message);
            }
            return const Center();
          } else {
            // return const SizedBox.shrink();
            return const Center();
          }
        },
      ),
    );
  }

  Container buildSearchBar(BuildContext context) {
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
            context.read<SearchMoviesBloc>().add(OnQueryChanged(query)),
        style: const TextStyle(),
        decoration: null,
      ),
    );
  }
}