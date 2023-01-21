import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:media_plex/media_plex/tv_series/presentation/bloc/tv_series_on_air_bloc/tv_series_on_air_bloc.dart';
import 'package:media_plex/media_plex/tv_series/presentation/widgets/tv_series_card_list.dart';

class TVSeriesOnAirPage extends StatefulWidget {
  const TVSeriesOnAirPage({Key? key}) : super(key: key);

  @override
  State<TVSeriesOnAirPage> createState() => _TVSeriesOnAirPageState();
}

class _TVSeriesOnAirPageState extends State<TVSeriesOnAirPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<TVSeriesOnAirBloc>(context, listen: false)
            .add(FetchTVSeriesOnAir()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('On Air TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TVSeriesOnAirBloc, TVSeriesOnAirState>(
            builder: (context, state) {
          if (state is TVSeriesOnAirLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TVSeriesOnAirHasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final onAirTVSeries = state.result[index];
                return TVSeriesCard(item: onAirTVSeries);
              },
              itemCount: state.result.length,
            );
          } else if (state is TVSeriesOnAirError) {
            return Center(
              key: const Key('error_message'),
              child: Text(state.message),
            );
          } else {
            return const Text('Failed');
          }
        }),
      ),
    );
  }
}
