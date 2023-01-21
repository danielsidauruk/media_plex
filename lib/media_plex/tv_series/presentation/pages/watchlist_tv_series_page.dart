import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_plex/core/common/utils.dart';
import 'package:media_plex/media_plex/tv_series/presentation/bloc/tv_series_watchlist_bloc/tv_series_watchlist_bloc.dart';
import 'package:media_plex/media_plex/tv_series/presentation/widgets/tv_series_card_list.dart';

class TVSeriesWatchlistPage extends StatefulWidget {
  const TVSeriesWatchlistPage({Key? key}) : super(key: key);

  @override
  State<TVSeriesWatchlistPage> createState() => _TVSeriesWatchlistPageState();
}

class _TVSeriesWatchlistPageState extends State<TVSeriesWatchlistPage> with RouteAware{
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<TVSeriesWatchlistBloc>(context, listen: false)
          .add(FetchWatchlistTVSeries());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    BlocProvider.of<TVSeriesWatchlistBloc>(context, listen: false)
        .add(FetchWatchlistTVSeries());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TVSeriesWatchlistBloc, TVSeriesWatchlistState>(
      builder: (context, state) {
        if (state is TVSeriesWatchlistLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TVSeriesWatchlistHasData) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final watchlistTVSeries = state.result[index];
              return TVSeriesCard(item: watchlistTVSeries);
            },
            itemCount: state.result.length,
          );
        } else if (state is TVSeriesWatchlistError) {
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
