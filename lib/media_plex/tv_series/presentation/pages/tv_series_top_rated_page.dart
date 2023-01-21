import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:media_plex/media_plex/tv_series/presentation/bloc/tv_series_top_rated_bloc/tv_series_top_rated_bloc.dart';
import 'package:media_plex/media_plex/tv_series/presentation/widgets/tv_series_card_list.dart';

class TVSeriesTopRatedPage extends StatefulWidget {
  const TVSeriesTopRatedPage({Key? key}) : super(key: key);

  @override
  State<TVSeriesTopRatedPage> createState() => _TVSeriesTopRatedPageState();
}

class _TVSeriesTopRatedPageState extends State<TVSeriesTopRatedPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<TVSeriesTopRatedBloc>(context, listen: false)
            .add(FetchTVSeriesTopRated()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TVSeriesTopRatedBloc, TVSeriesTopRatedState>(
          builder: (context, state) {
            if (state is TVSeriesTopRatedLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TVSeriesTopRatedHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final topRatedTVSeries = state.result[index];
                  return TVSeriesCard(item: topRatedTVSeries);
                },
                itemCount: state.result.length,
              );
            } else if (state is TVSeriesTopRatedError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return const Center();
            }
          },
        ),
      ),
    );
  }
}
