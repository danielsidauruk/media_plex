import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_plex/core/utils/utils.dart';
import 'package:media_plex/core/utils/constants.dart';
import 'package:media_plex/core/utils/routes.dart';
import 'package:media_plex/media_plex/books/presentation/bloc/bookmark_bloc/bookmark_bloc.dart';
import 'package:media_plex/media_plex/movie/presentation/bloc/movie_watchlist_bloc/movie_watchlist_bloc.dart';
import 'package:media_plex/media_plex/tv_series/presentation/bloc/tv_series_watchlist_bloc/tv_series_watchlist_bloc.dart';
import 'package:media_plex/shared/presentation/widget/loading_animation.dart';
import 'package:media_plex/shared/presentation/widget/total_text.dart';

class RepositoryPage extends StatefulWidget {
  const RepositoryPage({super.key});

  @override
  State<RepositoryPage> createState() => _RepositoryPageState();
}

class _RepositoryPageState extends State<RepositoryPage> with RouteAware {
  String menu = media[0];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<MovieWatchlistBloc>(context, listen: false)
          .add(FetchMovieWatchlist());
      BlocProvider.of<TVSeriesWatchlistBloc>(context, listen: false)
          .add(FetchWatchlistTVSeries());
      BlocProvider.of<BookmarkBloc>(context, listen: false)
          .add(FetchBookmark());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Future.microtask(() {
      BlocProvider.of<MovieWatchlistBloc>(context, listen: false)
          .add(FetchMovieWatchlist());
      BlocProvider.of<TVSeriesWatchlistBloc>(context, listen: false)
          .add(FetchWatchlistTVSeries());
      BlocProvider.of<BookmarkBloc>(context, listen: false)
          .add(FetchBookmark());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Repository',
          style: Theme.of(context).textTheme.bodyText1
              ?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Text(
                  'Category : ',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),

                dropDownTile(context),
              ],
            ),

            const SizedBox(height: 8),

            menu == media[0] ?
            buildBookRepository() :
            menu == media[1] ?
            buildMoviesRepository() :
            buildTVSeriesRepository(),

          ],
        ),
      ),
    );
  }

  Expanded buildBookRepository() {
    return Expanded(
      child: BlocBuilder<BookmarkBloc, BookmarkState>(
        builder: (context, state) {
          if (state is BookmarkLoading) {
            return const LoadingAnimation();
          } else if (state is BookmarkHasData) {
            final books = state.result;
            return books.isNotEmpty ?
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => Navigator.pushNamed(
                          context,
                          bookDetailRoute,
                          arguments: books[index].key,
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.symmetric(vertical: 4.0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(color: Colors.white),
                          ),
                          child: Text(
                            textAlign: TextAlign.start,
                            books[index].title,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 8),

                TotalText(total: books.length, context: context),
              ],
            ) : const Center();
          } else if (state is BookmarkError) {
            return Center(
              key: const Key('error_message'),
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Container dropDownTile(BuildContext context) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
          vertical: 4.0, horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.white),
      ),
      child: DropdownButton(
        value: menu,
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.white,
        ),
        underline: const Center(),
        onChanged: (String? value) {
          setState(() {
            menu = value!;
          });
        },
        items: media
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Row(
              children: [

                Image.asset(
                  value == media[0] ?
                  'assets/images/book_icon.png' :
                  value == media[1] ?
                  'assets/images/movie_icon.png' :
                  'assets/images/tv_icon.png',
                ),

                const SizedBox(width: 8.0),

                Text(
                  value,
                  style: Theme.of(context).textTheme.subtitle1
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Expanded buildMoviesRepository() {
    return Expanded(
      child: BlocBuilder<MovieWatchlistBloc, MovieWatchlistState>(
        builder: (context, state) {
          if (state is MovieWatchlistLoading) {
            return const LoadingAnimation();
          } else if (state is MovieWatchlistHasData) {
            final movie = state.result;
            return movie.isNotEmpty ?
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: movie.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => Navigator.pushNamed(
                          context,
                          movieDetailRoute,
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
                          child: Text(
                            textAlign: TextAlign.start,
                            '${movie[index].title}',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 8),

                TotalText(total: movie.length, context: context),
              ],
            ) :
            const Center();
          } else if (state is MovieWatchlistError) {
            return Center(
              key: const Key('error_message'),
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Expanded buildTVSeriesRepository() {
    return Expanded(
      child: BlocBuilder<TVSeriesWatchlistBloc, TVSeriesWatchlistState>(
        builder: (context, state) {
          if (state is TVSeriesWatchlistLoading) {
            return const LoadingAnimation();
          } else if (state is TVSeriesWatchlistHasData) {
            final movie = state.result;
            return movie.isNotEmpty ?
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: movie.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => Navigator.pushNamed(
                          context,
                          tvSeriesDetailRoute,
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
                          child: Text(
                            textAlign: TextAlign.start,
                            '${movie[index].name}',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 8),

                TotalText(total: movie.length, context: context),
              ],
            ) :
            const Center();
          } else if (state is TVSeriesWatchlistError) {
            return Center(
              key: const Key('error_message'),
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}