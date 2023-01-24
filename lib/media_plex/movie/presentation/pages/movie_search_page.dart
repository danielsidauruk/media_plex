import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:media_plex/core/utils/constants.dart';
import 'package:media_plex/core/utils/routes.dart';

import '../../../../core/styles/text_styles.dart';
import '../bloc/movie_search_bloc/search_bloc.dart';
import '../widgets/movie_card_list.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

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
      body: Padding(
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

            Container(
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
                query != "" ?
                context.read<SearchMoviesBloc>().add(OnQueryChanged(query)) :
                context.read<SearchMoviesBloc>().add(const OnQueryChanged("")),
                style: const TextStyle(),
                decoration: null,
              ),
            ),

            Expanded(
              child: BlocBuilder<SearchMoviesBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is SearchHasData) {
                    final movie = state.result;
                    return Expanded(
                      child: ListView.builder(
                        itemCount: movie.length,
                        itemBuilder: (context, index) {
                          try {
                            return InkWell(
                              onTap: () => Navigator.pushNamed(
                                context,
                                detailMovieRoute,
                                arguments: movie[index].id,
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                margin: const EdgeInsets.symmetric(vertical: 4.0),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(color: Colors.white),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CachedNetworkImage(
                                      width: 40,
                                      fit: BoxFit.fill,
                                      imageUrl: '$baseImageURL${movie[index].posterPath}',
                                      placeholder: (context, url) => Container(
                                        width: 40,
                                        height: 60,
                                        color: Colors.grey,
                                      ),
                                      errorWidget: (context, url, error) => Image.asset(
                                        'assets/images/not_applicable_icon.png',
                                      ),
                                    ),
                                    const SizedBox(width: 8.0),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                textAlign: TextAlign.start,
                                                '${movie[index].title}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1
                                                    ?.copyWith(fontWeight: FontWeight.bold),
                                              ),

                                              Text('Rating : ${movie[index].popularity! / 2}')

                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } catch (e) {
                            return const Center();
                          }
                        },
                      ),
                    );
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
            ),
          ],
        ),
      ),
    );
  }
}