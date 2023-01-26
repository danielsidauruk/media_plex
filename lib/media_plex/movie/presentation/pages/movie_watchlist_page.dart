import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_plex/core/common/utils.dart';
import 'package:media_plex/media_plex/movie/presentation/bloc/movie_watchlist_bloc/movie_watchlist_bloc.dart';
import 'package:media_plex/media_plex/movie/presentation/widgets/movie_card_list.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const routeName = 'watchlistMoviePageRoute';
  const WatchlistMoviesPage({super.key});

  @override
  State<WatchlistMoviesPage> createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage> with RouteAware{
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<MovieWatchlistBloc>(context, listen: false)
          .add(FetchMovieWatchlist());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    BlocProvider.of<MovieWatchlistBloc>(context, listen: false)
        .add(FetchMovieWatchlist());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieWatchlistBloc, MovieWatchlistState>(
      builder: (context, state) {
        if (state is MovieWatchlistLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MovieWatchlistHasData) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final watchlistMovie = state.result[index];
              return MovieCard(item: watchlistMovie);
            },
            itemCount: state.result.length,
          );
        } else if (state is MovieWatchlistError) {
          return Center(
            key: const Key('error_message'),
            child: Text(state.message),
          );
        } else {
          return Container();
        }
      },
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}